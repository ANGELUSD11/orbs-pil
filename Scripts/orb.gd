extends RigidBody2D

@export var textures: Array[Texture2D]
@onready var sprites = $Sprite2D
@onready var colliders = $CollisionShape2D

var freeze_umbral: float = 0.2
var time_for_freeze: float = 0.01
var static_cronometer = 0.0
var can_opacity: bool = Global.can_opacity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	
	if textures.size() > 0:
		sprites.texture = textures.pick_random()
		
	var base_scale: float = 0.2
	var variation = randf_range(0.8, 1.0)
	var final_scale = base_scale * variation
	
	sprites.scale = Vector2(final_scale, final_scale)
	
	physics_material_override = PhysicsMaterial.new()
	physics_material_override.bounce = randf_range(0.2, 0.7)
	
func _physics_process(delta: float) -> void:
	if freeze:
		return
		
	var move_slow = linear_velocity.length() < freeze_umbral
	var has_contacts = get_contact_count() > 0
		
	if move_slow and has_contacts:
		static_cronometer += delta
		if static_cronometer >= time_for_freeze:
			freeze_on()
			
	else:
		static_cronometer = 0.0
	
func freeze_on():
	#optimzation variables
	freeze = true
	collision_mask = false
	contact_monitor = false
	
	set_physics_process(false)
	
	if can_opacity == true:
		modulate.a = 0.1
