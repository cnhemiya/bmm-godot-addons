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
## ** 未完成，有缺陷 **


# 领头节点
var head: BmmNodeArea2D:
	get:
		return head
	set(value):
		head = value

# 领头位移偏移
var head_offset: float = 5.0:
	get:
		return head_offset
	set(value):
		head_offset = value


# 跟随节点
var team: Array[BmmNodeAreaPath2D]:
	get:
		return team
	set(value):
		team = value

# 记录的路径
var path: Array[BmmAreaPoint2D]:
	get:
		return path
	set(value):
		path = value


# 添加领头节点路径
func _append_head_path():
	path.push_front(BmmAreaPoint2D.new(head.node))


# 更新 head 路径
func update_head_path():
	if path.is_empty():
		_append_head_path()
	elif path.front().position.distance_to(head.node.position) > head_offset:
		_append_head_path()


# 添加跟随节点路径
func _append_team_path(area: BmmNodeArea2D) -> int:
	path.push_back(BmmAreaPoint2D.new(area.node))
	return path.size() - 1


# 添加跟随节点
func append_team_node(node: Node2D, rect: Rect2):
	var team_area = BmmNodeArea2D.new(node, rect)
	var last: int = _append_team_path(team_area)
	team.append(BmmNodeAreaPath2D.new(team_area, last))




class BmmNodeAreaPath2D extends RefCounted:
	var area: BmmNodeArea2D
	var index: int

	func _init(_area: BmmNodeArea2D, _index: int):
		area = _area
		index = _index

