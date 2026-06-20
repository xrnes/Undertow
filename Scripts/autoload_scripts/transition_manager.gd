# transition_manager.gd
extends CanvasLayer

@onready var fade_rect: ColorRect = $FadeRect
@onready var sound_player: AudioStreamPlayer = $SoundPlayer

var target_door_name: String = ""

func fade_to_same_scene(player: CharacterBody3D, marker: Marker3D, camera: Camera3D):
	# Block player input here if you have an input flag (e.g., player.can_move = false)
	
	# 1. Fade out to black
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.5) # Take 0.5 seconds to fade out
	await tween.finished
	
	# 2. Play door sound ONLY if a sound is assigned
	if sound_player.stream != null:
		sound_player.play()
		await get_tree().create_timer(0.2).timeout
	
	# 3. Teleport player and swap camera inside the same scene
	player.velocity = Vector3.ZERO
	player.global_position = marker.global_position
	player.global_rotation.y = marker.global_rotation.y
	camera.make_current()
	
	# black screen timer
	await get_tree().create_timer(1.0).timeout
	
	# 4. Fade back in
	var tween_in = create_tween()
	tween_in.tween_property(fade_rect, "modulate:a", 0.0, 0.5)
	await tween_in.finished
	
	# Unblock player input here (e.g., player.can_move = true)

func fade_to_new_scene(scene_path: String, door_name: String):
	# 1. Fade out to black
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.5)
	await tween.finished
	
	# 2. Play door sound and save the destination marker name
	sound_player.play()
	target_door_name = door_name
	
	# 3. Change the scene entirely
	get_tree().change_scene_to_file(scene_path)
	# The new scene's roomtel.gd will handle pulling the player and clearing target_door_name

func fade_in_after_scene_load():
	# Called by the new room script once the player is safely moved
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.5)
