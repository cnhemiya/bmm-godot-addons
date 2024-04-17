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


class_name BmmNodeArea2D
extends RefCounted
## 记录区域点，包含 Node2D 和 Rect2 信息


# 属性 node
var node: Node2D:
	get:
		return node
	set(value):
		node = value

# 属性 rect
var rect: Rect2:
	get:
		return rect
	set(value):
		rect = value


# 初始化
func _init(_node: Node2D, _rect: Rect2):
	node = _node
	rect = _rect


# 获取 Node2D 的 Rect2 的真实区域
func get_real_rect() -> Rect2:
	return BmmGlobal.get_node2d_rect2(node, rect)
