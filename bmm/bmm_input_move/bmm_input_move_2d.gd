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


## 信号，移动结束
signal move_done(position: Vector2, direction: Vector2)


## 驱动节点 Node2D
@export var drive_node: Node2D = null:
	set(value):
		drive_node = value
	get:
		return drive_node


## 移动速度
@export var speed: int = 400

## 向上 Y轴+
@export var input_up: String = "MOVE_UP"

## 向下 Y轴-
@export var input_down: String = "MOVE_DOWN"

## 向左 X轴-
@export var input_left: String = "MOVE_LEFT"

## 向右 X轴+
@export var input_right: String = "MOVE_RIGHT"

## 保持移动
@export var keep_move: bool = false

## 允许斜方向移动
@export var multi_move: bool = false

## 自动朝向
@export var auto_look_at: bool = false


# 保持的速度
var _keep_velocity: Vector2 = Vector2.ZERO


func _process(delta):
	var target_velocity: Vector2 = Vector2.ZERO
	var direction: Vector2 = Vector2.ZERO
	var is_key_pressed: bool = false
	
	if multi_move:
		if Input.is_action_pressed(input_up):
			direction.y -= 1
			is_key_pressed = true
		if Input.is_action_pressed(input_down):
			direction.y += 1
			is_key_pressed = true
		if Input.is_action_pressed(input_left):
			direction.x -= 1
			is_key_pressed = true
		if Input.is_action_pressed(input_right):
			direction.x += 1
			is_key_pressed = true
	else:
		if Input.is_action_pressed(input_up):
			direction.y -= 1
			is_key_pressed = true
		elif Input.is_action_pressed(input_down):
			direction.y += 1
			is_key_pressed = true
		elif Input.is_action_pressed(input_left):
			direction.x -= 1
			is_key_pressed = true
		elif Input.is_action_pressed(input_right):
			direction.x += 1
			is_key_pressed = true
		else:
			is_key_pressed = false
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		if auto_look_at:
			drive_node.look_at(drive_node.position + direction)

	if is_key_pressed:
		target_velocity.x = direction.x * speed * delta
		target_velocity.y = direction.y * speed * delta
		drive_node.position += target_velocity
		if keep_move:
			_keep_velocity = target_velocity
	else:
		if keep_move:
			drive_node.position += _keep_velocity
	
	move_done.emit(drive_node.position, direction)
