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


class_name BmmAreaPoint2D
extends RefCounted
## 记录区域点，包含 Node2D 的 Transform2D 信息


# 位置
var _position: Vector2 = Vector2(0, 0)
var position: Vector2:
	get:
		return _position
	set(value):
		_position = value

# 旋转
var _rotation: float = 0.0
var rotation: float:
	get:
		return _rotation
	set(value):
		_rotation = value

# 缩放
var _scale: Vector2 = Vector2(1, 1)
var scale: Vector2:
	get:
		return _scale
	set(value):
		_scale = value

# 倾斜
var _skew: float = 0.0
var skew: float:
	get:
		return _skew
	set(value):
		_skew = value


# 初始化
func _init(node: Node2D):
	set_from_node(node)


# 设置数据，来源 Node2D
func set_from_node(node: Node2D):
	_position = node.position
	_rotation = node.rotation
	_scale = node.scale
	_skew = node.skew


# 获取数据
func get_data() -> BmmAreaPoint2D:
	return self


# 将当前的数据应用到另一个 Node2D 节点上
func get_to_node(node: Node2D):
	node.position = _position
	node.rotation = _rotation
	node.scale = _scale
	node.skew = _skew
