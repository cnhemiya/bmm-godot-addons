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


class_name BmmAreaPointArray2D
extends RefCounted
## 这个类用于管理一组 BmmAreaPoint 区域点


# 存储 Area point 的数组
var _area_point_data: Array[BmmAreaPoint2D] = []


# 向数组中头部添加一个 Area point
func push_front(_area: BmmAreaPoint2D) -> void:
	_area_point_data.push_front(_area)


# 向数组中头部添加一个 Area point
func push_front_data(_node: Node2D, _rect: Rect2):
	var _area = BmmAreaPoint2D.new(_node, _rect)
	push_front(_area)


# 向数组中尾部添加一个 Area point
func push_back(_area: BmmAreaPoint2D) -> void:
	_area_point_data.push_back(_area)


# 向数组中尾部添加一个 Area point
func push_back_data(_node: Node2D, _rect: Rect2):
	var _area = BmmAreaPoint2D.new(_node, _rect)
	push_back(_area)


# 从数组中删除第一个 Area point
func pop_front() -> void:
	_area_point_data.pop_front()


# 从数组中删除最后一个 Area point
func pop_back() -> void:
	_area_point_data.pop_back()


# 从数组中删除指定索引的 Area point
func remove_at(_index: int) -> void:
	if _check_index_ok(_index):
		_area_point_data.remove_at(_index)


# 从数组中删除指定索引范围的 Area point
func remove_range(_index: int, _count: int) -> void:
	if _check_count_ok(_index + _count):
		for i in range(_count):
			_area_point_data.remove_at(_index)


# 从数组中删除指定索引到头部的 Area point
func remove_to_front(_index: int) -> void:
	var count = _index + 1
	if _check_count_ok(count):
		for i in range(count):
			_area_point_data.pop_front()


# 从数组中删除指定索引到尾部的 Area point
func remove_to_back(_index: int) -> void:
	var count = _area_point_data.size() - _index
	if _check_count_ok(count):
		for i in range(count):
			_area_point_data.pop_back()


# 检查计数是否在数组范围内
func _check_count_ok(_count: int) -> bool:
	return (_count >= 0 and _count <= _area_point_data.size())


# 检查索引是否在数组范围内
func _check_index_ok(_index: int) -> bool:
	return (_index >= 0 and _index < _area_point_data.size())


# 清空数组
func clear() -> void:
	_area_point_data.clear()


# 返回数组的大小
func size() -> int:  
	return _area_point_data.size()


# 返回数组中指定索引的 Area point
# 如果索引超出范围，则返回 null
func at(_index: int) -> BmmAreaPoint2D:
	if _check_index_ok(_index):
		return _area_point_data[_index]
	else:
		return null


# 返回数组中第一个 Area point
func front() -> BmmAreaPoint2D:
	return _area_point_data.front()


# 返回数组中最后一个 Area point
func back() -> BmmAreaPoint2D:
	return _area_point_data.back()


# 检查数组是否为空
func is_empty() -> bool:
	return _area_point_data.is_empty()
