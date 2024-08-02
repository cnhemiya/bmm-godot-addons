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


class_name BmmTimerManager
extends RefCounted
## 多定时器管理


# 存储计时器的字典
var _timer_list: Dictionary = {}


#添加计时器，如果计时器已存在，则返回 null，否则返回计时器
func append(name: String, timer: Timer) -> Timer:
	var result: Timer = null
	if not name in _timer_list.keys():
		_timer_list[name] = timer
		result = timer
	return result


# 创建计时器，如果存在则停止，重新设定已存在的计时器
func make(name: String, wait_time: float, callback: Callable, one_shot: bool = true) -> Timer:
	var timer: Timer = null
	if not name in _timer_list.keys():
		timer = Timer.new()
	else:
		timer = _timer_list[name]
		timer.stop()
	timer.wait_time = wait_time
	timer.one_shot = one_shot
	timer.timeout.connect(callback)
	return timer


# 是否包含定时器
func has(name: String) -> bool:
	return name in _timer_list.keys()


# 删除计时器，如果计时器不存在，则返回 false
func remove(name: String) -> bool:
	var timer: Timer = get_timer(name)
	var is_ok: bool = false
	if timer != null:
		timer.stop()
		_timer_list.erase(name)
		timer.queue_free()
		is_ok = true
	return is_ok


# 清空所有计时器
func clear():
	for timer in _timer_list.values():
		timer.stop()
		timer.queue_free()
	_timer_list.clear()


# 获取计时器，如果存在则返回，否则返回null
func get_timer(name: String) -> Timer:
	var timer: Timer = null
	if name in _timer_list.keys():
		timer = _timer_list[name]
	return timer


# 启动计时器，如果计时器不存在，则返回 false
func start(name: String, time_sec = -1) -> bool:
	var timer: Timer = get_timer(name)
	var is_ok: bool = false
	if timer != null:
		if timer.paused:
			timer.paused = false
		timer.start(time_sec)
		is_ok = true
	return is_ok


# 停止计时器，如果计时器不存在，则返回 false
func stop(name: String) -> bool:
	var timer: Timer = get_timer(name)
	var is_ok: bool = false
	if timer != null:
		timer.stop()
		is_ok = true
	return is_ok


# 如果计时器停止，则返回 true，否则返回 false，如果计时器不存在，则返回 false
func is_stopped(name: String) -> bool:
	var timer: Timer = get_timer(name)
	var result: bool = false
	if timer != null:
		result = timer.is_stopped()
	return result


# 暂停计时器，is_paused = true 暂停，is_paused = false 恢复
# 如果计时器不存在，则返回 false
func pause(name: String, is_paused = true) -> bool:
	var timer: Timer = get_timer(name)
	var is_ok: bool = false
	if timer != null:
		timer.paused = is_paused
		is_ok = true
	return is_ok


# 如果计时器暂停，则返回 true，否则返回 false，如果计时器不存在，则返回 false
func is_paused(name: String) -> bool:
	var timer: Timer = get_timer(name)
	var result: bool = false
	if timer != null:
		result = timer.paused
	return result


# 返回计时器的时间，如果计时器不存在，则返回 -1
func get_wait_time(name: String) -> float:
	var timer: Timer = get_timer(name)
	var result: float = -1
	if timer != null:
		result = timer.wait_time
	return result


# 设置计时器的时间，如果计时器不存在，则返回 false
func set_wait_time(name: String, time_sec: float) -> bool:
	var timer: Timer = get_timer(name)
	var is_ok: bool = false
	if timer != null:
		timer.wait_time = time_sec
		is_ok = true
	return is_ok
