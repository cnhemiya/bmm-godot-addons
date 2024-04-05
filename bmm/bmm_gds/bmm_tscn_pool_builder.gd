# 场景节点池构建器
class_name BmmTscnPoolBuilder
extends Node

# 生成节点后的信号
signal make_done(_node: Node)
# 移动节点到后的信号
signal move_done(_node: Node)


# 用于生成节点的场景路径
var tscn_path: String = "":
	get:
		return tscn_path
	set(value):
		tscn_path = value


# 不用的节点放到节点池
static var _node_pool: Node = Node.new()


# 节点池节点数量
func size() -> int:
	return _node_pool.get_child_count()


# 节点池节点数量是否为空
func is_empty() -> bool:
	return size() == 0

	
# 清除数据池和节点池，并释放节点资源
func clear() -> void:
	for i in range(_node_pool.get_child_count()):
		var _node: Node = _node_pool.get_child(i)
		_node_pool.remove_child(_node)
		_node.queue_free()

# 弹出最后一个索引的节点，并返回该节点
# 如果池为空返回 null
func _pop_back() -> Node:
	var _node: Node = null
	if not is_empty():
		_node = _node_pool.get_child(_node_pool.get_child_count() - 1)
		_node_pool.remove_child(_node)
	return _node


# 压入节点到节点池	
func _push_back(_node: Node):
	_node_pool.add_child(_node)


# 生成节点，如果节点池没有就从场景生成
func make(_parent: Node) -> Node:
	var _node: Node = null
	if is_empty():
		assert(FileAccess.file_exists(tscn_path), "场景不存在：" + tscn_path)
		_node = BmmBuilder.make_tscn(tscn_path, _parent)
	else:
		_node = _pop_back()
		_parent.add_child(_node)
	assert(_node != null, "节点为：null")
	make_done.emit(_node)
	return _node


# 移动节点到池节点，原父节点删除 _node 子节点
func move(_node: Node) -> Node:
	assert(_node != null, "节点为：null")
	var _parent: Node = _node.get_parent()
	_parent.remove_child(_node)
	_push_back(_node)
	move_done.emit(_node)
	return _node
