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


class_name BmmFollowQueue
extends RefCounted
## 这个类用于管理跟随队列，head 是领头节点，team 是跟随节点。
## 目前移动实现是“瞬移”方式


# 领头位移偏移
var head_offset: float = 5.0:
	get:
		return head_offset
	set(value):
		head_offset = value

# 节点最小间距
var min_distance: float = 128.0:
	get:
		return min_distance
	set(value):
		min_distance = value

# team.back().index 到 path.size - 1 的数量
# 达到这个阈值就重置 path 大小 为 team.back().index + 1
var extra_path_size: int = 500

# 领头节点
var head: BmmNodeArea2D:
	get:
		return head
	set(value):
		head = value

# 跟随节点
var team: Array[BmmNodeAreaPath2D]:
	get:
		return team
	set(value):
		team = value

# 记录的路径
var path: Array[Vector2]:
	get:
		return path
	set(value):
		path = value


# 添加领头节点路径
func _append_head_path():
	path.push_front(head.node.position)
	_update_team_path_index(1)


# 更新 head 路径
func update_head_path():
	if path.is_empty():
		_append_head_path()
	elif path.front().distance_to(head.node.position) > head_offset:
		_append_head_path()


# 添加跟随节点路径
func _append_team_path(node: Node2D) -> int:
	return path.size() - 1


# 添加跟随节点
func append_team_node(node: Node2D, rect: Rect2):
	var team_area = BmmNodeArea2D.new(node, rect)
	var last: int = _append_team_path(node)
	team.append(BmmNodeAreaPath2D.new(team_area, last))


# 更新跟随节点的路径索引
func _update_team_path_index(offset: int = 1):
	for i in team:
		i.index += offset


# 更新跟随节点路径
func update_team_path():
	if team.is_empty() or path.size() < 2:
		return
	var target_pos = path.front()
	for t_i in team:
		if path[t_i.index].distance_to(target_pos) <= min_distance + head_offset:
			target_pos = path[t_i.index]
		else:
			for p_idx in range(t_i.index, 1, -1):
				if path[p_idx - 1].distance_to(target_pos) <= min_distance + head_offset:
					target_pos = path[p_idx]
					t_i.index = p_idx
					t_i.area.node.position = path[p_idx]
					break


# 重置 path 的 size
func reset_path_size():
	if (not path.is_empty()) and \
			((path.size() - 1 - team.back().index) >= extra_path_size):
		path.resize(team.back().index + 1)


# 记录 NodeArea2D 和所在 path 的索引
class BmmNodeAreaPath2D extends RefCounted:
	var area: BmmNodeArea2D
	var index: int

	func _init(_area: BmmNodeArea2D, _index: int):
		area = _area
		index = _index
