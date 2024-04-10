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
## 记录区域点，包含 Node2D 和 Rect2 信息，
## Rect2 记录的是真实坐标区域，符合 Node2D 信息


# Node2D 节点
var node: Node2D:
	get:
		return node

# 区域矩形
var rect: Rect2:
	get:
		return rect


# 初始化
func _init(_node: Node2D, _rect: Rect2):
	set_all(_node, _rect)


# 设置所有
func set_all(_node: Node2D, _rect: Rect2):
	node = _node
	rect = BmmGlobal.get_node2d_rect2(_node, _rect)
