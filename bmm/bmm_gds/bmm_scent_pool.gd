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


class_name BmmScentPool
extends RefCounted
## 场景池


# 存储场景路径和场景的映射，path:scent
var _scent_list: Dictionary


# 初始化，添加多个场景路径
func _init(paths: Array = []):
	append_array(paths)


# 添加单个场景
func append(path: String):
	if _scent_list.has(path) == false:
		_scent_list[path] = null


# 添加多个场景路径
func append_array(paths: Array):
	for i in paths:
		append(i)


# 检查所有场景路径是否存在
# 返回不存在路径列表
func check_all_path() -> Array[String]:
	var missing_paths: Array[String]
	for i in _scent_list:
		if FileAccess.file_exists(i) == false:
			missing_paths.append(i)
	return missing_paths


# 加载场景，失败返回 null
func _load_scent(path: String) -> PackedScene:
	if FileAccess.file_exists(path) == false:
		return null
	else:
		return load(path)


# 实例化场景，失败返回 null
func instantiate(path: String) -> Node:
	var _node: Node = null
	if _scent_list.has(path):
		if _scent_list[path] == null:
			var scent_ = _load_scent(path)
			if scent_ != null:
				_scent_list[path] = scent_
				_node = scent_.instantiate()
		else:
			if _scent_list[path] != null:
				_node = _scent_list[path].instantiate()
	return _node


# 随机场景实例化，失败返回 null
func random_instantiate() -> Node:
	if _scent_list.size() == 0:
		return null
	var _paths: Array = _scent_list.keys()
	var _path: String = _paths[randi_range(0, _paths.size() - 1)]
	return instantiate(_path)
