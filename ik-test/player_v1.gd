extends CharacterBody3D

@export var anim_player: AnimationPlayer
@export var anim_tree: AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")



var inputdir = Vector3()

var anim_canmove = bool()

@onready var root = $"Love-chan Model (Rigging Test)/Armature/Skeleton3D/root"


#Physics Values
var direction = Vector3()
var vertical_velocity = Vector3()
var root_velocity = Vector3()
var turn_speed = 10

#input
var horizontal = float()
var vertical = float()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var root_pos = anim_tree.get_root_motion_position()
	var current_rotation = transform.basis.get_rotation_quaternion().normalized()
	root_velocity = current_rotation * root_pos / delta
	var root_rotation = anim_tree.get_root_motion_rotation()
	set_quaternion(get_quaternion() * root_rotation)
	
	horizontal = Input.get_axis("right", "left")
	vertical = Input.get_axis("back", "forward")
	
	#Movement Input
	inputdir = Vector3(horizontal, 0, vertical).normalized()
	
	#print(anim_tree.get_root_motion_position())
	
	pass

func _physics_process(delta: float) -> void:
	#anim_tree.root_motion_track = "%Skeleton:Root"
	
	anim_tree.set("parameters/conditions/startmove", anim_canmove)
	anim_tree.set("parameters/conditions/idle", !anim_canmove)
	
	
	
	if (inputdir != Vector3.ZERO):
		anim_canmove = true
	else:
		anim_canmove = false
	
	#Player Rotation
	rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.z), turn_speed * delta)
	
	velocity = Vector3(root_velocity.x, vertical_velocity.y, root_velocity.z)
	move_and_slide()
	pass












#End Script
