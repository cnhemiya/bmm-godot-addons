#   Copyright (c) 2024 CNHEMIYA
#   BaoMiMian Godot Addons is licensed under Mulan PSL v2.
#   You can use this software according to the terms and conditions of the Mulan PSL v2. 
#   You may obtain a copy of Mulan PSL v2 at:
#            http://license.coscl.org.cn/MulanPSL2 
#   THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, 
#   EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, 
#   MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.  
#   See the Mulan PSL v2 for more details. 
# 
#   repo: https://github.com/cnhemiya/bmm-godot-addons
#   repo: https://gitee.com/cnhemiya/bmm-godot-addons


class_name BmmGlobal
extends RefCounted
## BMM 全局函数


# 获取 Node2D 节点类型实际占用的 Rect2 区域，float 类型
static func get_node2d_rect2(_node: Node2D, _rect: Rect2) -> Rect2:
	var size: Vector2  = _rect.size
	var pos: Vector2
	var width: int = size.x * _node.scale.x
	var height: int = size.y * _node.scale.y
	pos.x = _node.position.x - width / 2
	pos.y = _node.position.y - height / 2
	return Rect2(pos.x, pos.y, width, height)


# 获取 Node2D 节点类型实际占用的 Rect2i 区域，int 类型
static func get_node2d_rect2i(_node: Node2D, _rect: Rect2) -> Rect2i:
	return Rect2i(get_node2d_rect2(_node, _rect))


# 判断两个 Node2D 实际占用的 Rect2 区域，是否重叠
static func node2d_intersects(_node_a: Node2D, _rect_a: Rect2, 
		_node_b: Node2D, _rect_b: Rect2) -> bool:
	var rect_1 = get_node2d_rect2(_node_a, _rect_a)
	var rect_2 = get_node2d_rect2(_node_b, _rect_b)
	return rect_1.intersects(rect_2)


# 获取 Sprite2D 实际占用的 Rect2 区域，float 类型
static func get_sprite2d_rect2(from: Sprite2D) -> Rect2:
	return get_node2d_rect2(from, from.get_rect())


# 获取 Sprite2D 实际占用的 Rect2i 区域，int 类型
static func get_sprite2d_rect2i(from: Sprite2D) -> Rect2i:
	return Rect2i(get_node2d_rect2(from, from.get_rect()))


# 判断两个 Sprite2D 实际占用的 Rect2 区域，是否重叠
static func sprite2d_intersects(_node_a: Sprite2D, _node_b: Sprite2D) -> bool:
	return node2d_intersects(_node_a, _node_a.get_rect(), _node_b, _node_b.get_rect())


# 获取 CollisionShape2D 的 Shape2D 实际占用的 Rect2 区域，float 类型
static func get_collision_shape2d_rect2(from: CollisionShape2D) -> Rect2:
	return get_node2d_rect2(from, from.shape.get_rect())


# 获取 CollisionShape2D 的 Shape2D 实际占用的 Rect2i 区域，int 类型
static func get_collision_shape2d_rect2i(from: CollisionShape2D) -> Rect2i:
	return Rect2i(get_node2d_rect2(from, from.shape.get_rect()))


# 判断两个 CollisionShape2D 的 Shape2D 实际占用的 Rect2 区域，是否重叠
static func collision_shape2d_intersects(_node_a: CollisionShape2D, 
		_node_b: CollisionShape2D) -> bool:
	return node2d_intersects(_node_a, _node_a.shape.get_rect(), _node_b, _node_b.shape.get_rect())


# 检查计数是否在数组范围内
static func array_check_count_ok(_array: Array, _count: int) -> bool:
	return (_count >= 0 and _count <= _array.size())


# 检查索引是否在数组范围内
static func array_check_index_ok(_array: Array, _index: int) -> bool:
	return (_index >= 0 and _index < _array.size())


# 从数组中删除指定索引到头部的数据
static func array_remove_to_front(_array: Array, _index: int):
	var count = _index + 1
	if array_check_count_ok(_array, count):
		for i in range(count):
			_array.pop_front()


# 从数组中删除指定索引到尾部的数据
static func array_remove_to_back(_array: Array, _index: int):
	var count = _array.size() - _index
	if array_check_count_ok(_array, count):
		for i in range(count):
			_array.pop_back()


# 从数组中删除指定索引范围的数据
static func array_remove_range(_array: Array, _index: int, _count: int):
	if array_check_count_ok(_array, _index + _count):
		for i in range(_count):
			_array.remove_at(_index)
