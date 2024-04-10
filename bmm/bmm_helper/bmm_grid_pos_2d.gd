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


extends Node
## 获取监听的 Rect2 在网格节点 CollisionShape2D 的
## Shape2D 里所在的格子位置


## 监听的 Rect2 在网格里的位置改变，
## 如果 x = -1，y = -1，说明监听的 Rect2 没在网格里
signal listen_pos_changed(x: int, y: int)


## 网格节点 CollisionShape2D
@export var grid_node: CollisionShape2D:
	get:
		return grid_node
	set(value):
		grid_node = value
		update_grid_rect()


## X 轴方向，网格数量
@export var grid_x: int = 2

## Y 轴方向，网格数量
@export var grid_y: int = 2


# 监听的 Rect2
var listen_rect: Rect2: get = get_listen_rect, set = set_listen_rect


# 网格节点 Rect2
var _grid_rect: Rect2

# 网格 X 轴 1单位长度
var _grid_x_1_size: float

# 网格 Y 轴 1单位长度
var _grid_y_1_size: float

# 监听的 Rect2 所在的网格节点的位置
var _listen_pos: Vector2i = Vector2i(-1, -1)


func _enter_tree():
	update_grid_rect()


# 更新网格 Rect
func update_grid_rect():
	_grid_rect = BmmGlobal.get_node2d_rect2(grid_node, grid_node.shape.get_rect())
	# 获取 x y 轴的1单位长度
	_grid_x_1_size = _grid_rect.size.x / grid_x
	_grid_y_1_size = _grid_rect.size.y / grid_y


# 获取监听的 Rect
func get_listen_rect():
	return listen_rect


# 设置监听的 Rect
func set_listen_rect(value: Rect2):
	if listen_rect == value:
		return
	listen_rect = value
	# 获取监听的 Rect 中心坐标
	var _listen_center: Vector2 = listen_rect.get_center()
	# 临时变量，监听的 Rect2 所在的网格节点的位置
	var _listen_pos_temp: Vector2i = Vector2i(-1, -1)
	# 监听的 Rect 中心坐标是否在网格里
	if _grid_rect.has_point(_listen_center):
		# 监听的 x y 分别与网格 x y 差多少，被单位长度除，就是当前的位置，起始索引 0
		_listen_pos_temp.x = int((_listen_center.x - _grid_rect.position.x) / _grid_x_1_size)
		_listen_pos_temp.y = int((_listen_center.y - _grid_rect.position.y) / _grid_y_1_size)
	if _listen_pos != _listen_pos_temp:
		_listen_pos = _listen_pos_temp
		listen_pos_changed.emit(_listen_pos.x, _listen_pos.y)


# 获取网格中指定位置的中心点
func get_grid_pos_center(x: int, y: int) -> Vector2:
	var center_x = _grid_rect.position.x + _grid_x_1_size * (x + 0.5)
	var center_y = _grid_rect.position.y + _grid_y_1_size * (y + 0.5)
	return Vector2(center_x, center_y)
