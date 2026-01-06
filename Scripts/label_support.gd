extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var current_fps = Global.fps
	text = str(current_fps)
	
	if current_fps >= 30:
		modulate = Color.GREEN
