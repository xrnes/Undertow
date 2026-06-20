# roomtel.gd
extends Node3D

func _ready():
	# Only execute if an external transition brought us here
	if TransitionManager.target_door_name != "":
		# Finds a unique node registered with a percentage (%) identifier in the new room
		var spawn_point = get_node_or_null("%" + TransitionManager.target_door_name)
		var player = get_node_or_null("%Player")
		
		if spawn_point and player:
			player.velocity = Vector3.ZERO
			player.global_position = spawn_point.global_position
			player.global_rotation.y = spawn_point.global_rotation.y
			
			# Clear the handoff state variable
			TransitionManager.target_door_name = ""
			
			# Trigger the global visual layer overlay to peel back the black screen
			TransitionManager.fade_in_after_scene_load()
