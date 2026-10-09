extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var anim_player: AnimationPlayer
@export var anim_tree: AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")


var root_velocity = Vector3()

var anim_canmove = bool()

#input
var horizontal = float()
var vertical = float()

func _ready():
	print(root_velocity)
	pass

func _process(delta: float) -> void:
	var root_pos = anim_tree.get_root_motion_position()
	var current_rotation = (anim_tree.get_root_motion_rotation_accumulator().inverse() * get_quaternion())
	root_velocity = ((current_rotation * root_pos) / delta)
	var root_rotation = anim_tree.get_root_motion_rotation()
	set_quaternion(get_quaternion() * root_rotation)
	
	pass


func _physics_process(_delta: float) -> void:
	anim_tree.set("parameters/conditions/startmove", anim_canmove)
	anim_tree.set("parameters/conditions/idle", !anim_canmove)
	
	
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction != Vector3.ZERO:
		anim_canmove = true
	else:
		anim_canmove = false
	
	
	velocity = root_velocity
	move_and_slide()
