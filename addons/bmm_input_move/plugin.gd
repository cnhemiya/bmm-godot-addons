@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type("BmmInputMove3DY", "Node", preload("bmm_input_move_3dy.gd"), preload("bmm_input_move_3dy.png"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("BmmInputMove3DY")
