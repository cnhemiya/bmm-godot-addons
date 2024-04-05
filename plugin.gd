@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type("BmmInputMove3D", "Node", preload("bmm_input_move/bmm_input_move_3d.gd"), preload("bmm_input_move/bmm_input_move_3d.png"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("BmmInputMove3D")
