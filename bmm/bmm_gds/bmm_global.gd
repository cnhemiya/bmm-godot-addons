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
static func array_check_count_ok(_size: int, _count: int) -> bool:
	return (_count >= 0 and _count <= _size)


# 检查索引是否在数组范围内
static func array_check_index_ok(_size: int, _index: int) -> bool:
	return (_index >= 0 and _index < _size)


# 重置数组大小，保留从索引到头部的数据，index 超出范围返回 false
static func array_resize_to_front(_array: Array, _index: int) -> bool:
	if not array_check_index_ok(_array.size(), _index):
		return false
	return (_array.resize(_index + 1) == OK)


# 重置数组大小，保留从索引到部的数据，index 超出范围返回 false
static func array_remove_to_back(_array: Array, _index: int) -> bool:
	if not array_check_index_ok(_array.size(), _index):
		return false
	_array.reverse()
	var is_ok = false
	if (_array.resize(_array.size() - _index) == OK):
		_array.reverse()
		is_ok = true
	return is_ok


# 从数组中删除指定索引范围的数据
static func array_remove_range(_array: Array, _index: int, _count: int):
	if array_check_count_ok(_array.size(), _index + _count):
		for i in range(_count):
			_array.remove_at(_index)


# 基础实现 计算C点坐标是a，b点的延长线，距离为distance的点
static func _find_point_at_distance_base(a, b, distance: float):
	# 计算从A到B的方向向量
	var direction = b - a
	# 如果A和B是同一个点，不能计算方向向量，返回B点
	if direction is Vector2:
		if direction == Vector2.ZERO:
			return b
	elif direction is Vector3:
		if direction == Vector3.ZERO:
			return b
	# 标准化方向向量
	var normalized_direction = direction.normalized()
	# 缩放方向向量
	var scaled_direction = normalized_direction * distance
	# 计算点C的坐标
	var c = b + scaled_direction
	return c


# 2D 计算C点坐标是a，b点的延长线，距离为distance的点
static func find_point_at_distance_2d(a: Vector2, b: Vector2, distance: float) -> Vector2:
	return _find_point_at_distance_base(a, b, distance)


# 3D 计算C点坐标是a，b点的延长线，距离为distance的点
static func find_point_at_distance_3d(a: Vector3, b: Vector3, distance: float) -> Vector3:
	return _find_point_at_distance_base(a, b, distance)


# 基础实现 计算C点坐标是a，b点的延长线，缩放距离的点
static func _find_point_on_extended_line_base(a, b, scale: float):
	# 计算从A到B的方向向量
	var direction = b - a
	# 缩放方向向量
	var scaled_direction = direction * scale
	# 计算点C的坐标
	var c = b + scaled_direction
	return c


# 2D 计算C点坐标是a，b点的延长线，缩放距离的点
static func find_point_on_extended_line_2d(a: Vector2, b: Vector2, scale: float) -> Vector2:
	return _find_point_on_extended_line_base(a, b, scale)


# 3D 计算C点坐标是a，b点的延长线，缩放距离的点
static func find_point_on_extended_line_3d(a: Vector3, b: Vector3, scale: float) -> Vector3:
	return _find_point_on_extended_line_base(a, b, scale)


# 2D 随机生成网格点
static func random_grid_point_2d(min_pos: Vector2i, max_pos: Vector2i, 
		no_has: Array[Vector2i], size: int = 1, append_no_has: bool = true) -> Array[Vector2i]:
	var max_size: int = abs((max_pos.x - min_pos.x) * (max_pos.y - min_pos.y))
	assert(max_size >= size, "备选点数小于 size， 备选点数： %d" % max_size)
	var no_has_new: Array[Vector2i] = no_has
	var points: Array[Vector2i]
	while points.size() < size:
		var x = randi_range(min_pos.x, max_pos.x)
		var y = randi_range(min_pos.y, max_pos.y)
		var p = Vector2i(x, y)
		if not p in no_has_new:
			points.append(p)
			if append_no_has:
				no_has_new.append(p)
	return points


# 3D 随机生成网格点
static func random_grid_point_3d(min_pos: Vector3i, max_pos: Vector3i, 
		no_has: Array[Vector3i], size: int = 1, append_no_has: bool = true) -> Array[Vector3i]:
	var max_size: int = abs((max_pos.x - min_pos.x) * 
			(max_pos.y - min_pos.y) * (max_pos.z - min_pos.z))
	assert(max_size >= size, "备选点数小于 size， 备选点数： %d" % max_size)
	var no_has_new: Array[Vector3i] = no_has
	var points: Array[Vector3i]
	while points.size() < size:
		var x = randi_range(min_pos.x, max_pos.x)
		var y = randi_range(min_pos.y, max_pos.y)
		var z = randi_range(min_pos.z, max_pos.z)
		var p = Vector3i(x, y, z)
		if not p in no_has_new:
			points.append(p)
			if append_no_has:
				no_has_new.append(p)
	return points
