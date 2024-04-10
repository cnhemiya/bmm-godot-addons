@tool
extends EditorPlugin


const _bmm_2d_icon: String = "art/bmm_2d_icon.png"
const _bmm_3d_icon: String = "art/bmm_3d_icon.png"


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type("BmmInputMove3D", "Node", 
			preload("bmm/bmm_input_move/bmm_input_move_3d.gd"), preload(_bmm_3d_icon))
	add_custom_type("BmmInputMove2D", "Node", 
			preload("bmm/bmm_input_move/bmm_input_move_2d.gd"), preload(_bmm_2d_icon))
	add_custom_type("BmmGridPos2D", "Node", 
			preload("bmm/bmm_helper/bmm_grid_pos_2d.gd"), preload(_bmm_2d_icon))


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("BmmInputMove3D")
	remove_custom_type("BmmInputMove2D")
	remove_custom_type("BmmGridPos2D")
	
