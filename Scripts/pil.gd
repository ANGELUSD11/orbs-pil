extends Node2D

@export var orb_scene: PackedScene
@export var spawn_width: float = 200.0 

@onready var spawn_timer = $Timer
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var spawn_timeout: Timer = $SpawnTimeout


func _on_timer_timeout():
	if not orb_scene:
		return
	
	var orb_instance = orb_scene.instantiate()
	var width_middle = spawn_width / 2.0
	var x_random = randf_range(-width_middle, width_middle)
	
	orb_instance.position = Vector2(spawn_point.position.x + x_random, spawn_point.position.y)
	
	add_child(orb_instance)
	
func _on_spawn_timeout_timeout() -> void:
	spawn_timer.stop() # Replace with function body.
