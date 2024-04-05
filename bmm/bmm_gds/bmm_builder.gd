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


# 一些构建器
class_name BmmBuilder
extends Node


# 场景构建器
# 参数：tscn 场景路径
# 参数：parent 父级节点
# 参数：ide 附加的后缀防止重名，默认 -1，不使用 idx
# 返回：tscn 场景的根节点
static func make_tscn(tscn: String, parent: Node = null, idx: int = -1) -> Node:
	assert(FileAccess.file_exists(tscn), "场景不存在：" + tscn)
	var _node: Node = load(tscn).instantiate()
	if idx >= 0:
		_node.name += "_" + str(idx)
	if parent != null:
		parent.add_child(_node)
	return _node
