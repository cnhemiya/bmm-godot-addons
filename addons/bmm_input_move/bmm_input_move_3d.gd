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
@export var mulit_move: bool = false

# 获取父节点 CharacterBody3D
var _parent


func _enter_tree():
	# 获取父节点 CharacterBody3D
	_parent = get_parent() as CharacterBody3D


func _process(delta):
	var target_velocity: Vector3 = Vector3.ZERO
	var direction: Vector3 = Vector3.ZERO
	var is_key_pressed: bool = false
	
	if mulit_move:
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
		# 速度不统一，容易卡顿
		#direction = direction.normalized()
		_parent.look_at(_parent.position + direction, Vector3.UP)

	if is_key_pressed:
		target_velocity.x = direction.x * speed * delta
		target_velocity.z = direction.z * speed * delta
		_parent.velocity = target_velocity
		_parent.move_and_slide()
	else:
		if keep_move:
			_parent.move_and_slide()
