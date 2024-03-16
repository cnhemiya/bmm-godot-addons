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


## 移动速度
@export var speed: int = 400

## 前进 Z轴+
@export var input_move_forward: String = "MOVE_FORWARD"

## 后退 Z轴-
@export var input_move_back: String = "MOVE_BACK"

## 往左 X轴-
@export var input_move_left: String = "MOVE_LEFT"

## 往右 X轴+
@export var input_move_right: String = "MOVE_RIGHT"

## 保持移动
@export var keep_move: bool = false

## 允许斜方向移动
@export var multi_move: bool = true


# 驱动节点 CharacterBody3D
var drive_node: CharacterBody3D = null:
	set(value):
		drive_node = value
	get:
		return drive_node

# 保持的速度
var _keep_velocity: Vector3 = Vector3.ZERO


func _enter_tree():
	# 获取父级驱动节点 CharacterBody3D
	drive_node = get_parent()
	

func _process(delta):
	var target_velocity: Vector3 = Vector3.ZERO
	var direction: Vector3 = Vector3.ZERO
	var is_key_pressed: bool = false
	
	if multi_move:
		if Input.is_action_pressed(input_move_forward):
			direction.z -= 1
			is_key_pressed = true
		if Input.is_action_pressed(input_move_back):
			direction.z += 1
			is_key_pressed = true
		if Input.is_action_pressed(input_move_left):
			direction.x -= 1
			is_key_pressed = true
		if Input.is_action_pressed(input_move_right):
			direction.x += 1
			is_key_pressed = true
	else:
		if Input.is_action_pressed(input_move_forward):
			direction.z -= 1
			is_key_pressed = true
		elif Input.is_action_pressed(input_move_back):
			direction.z += 1
			is_key_pressed = true
		elif Input.is_action_pressed(input_move_left):
			direction.x -= 1
			is_key_pressed = true
		elif Input.is_action_pressed(input_move_right):
			direction.x += 1
			is_key_pressed = true
		else:
			is_key_pressed = false
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		drive_node.look_at(drive_node.position + direction, Vector3.UP)

	if is_key_pressed:
		target_velocity.x = direction.x * speed * delta
		target_velocity.z = direction.z * speed * delta
		drive_node.velocity = target_velocity
		drive_node.move_and_slide()
		if keep_move:
			_keep_velocity = target_velocity
	else:
		if keep_move:
			drive_node.velocity = _keep_velocity
			drive_node.move_and_slide()
