extends Node2D

class_name Enemy


@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var timer: Timer = $Timer


const speed = 30.0
var direction = 1
var pathfollow
var can_move = true
var is_alive = true

var skin_variants = { #Four skins variants for enemies
	"Idle": ["Idle1", "Idle2", "Idle3", "Idle4"],
	"Run": ["Run1", "Run2", "Run3", "Run4"],
	"Attack": ["Attack1", "Attack2", "Attack3", "Attack4"],
	"Death": ["Death1", "Death2", "Death3", "Death4"]
}

@export var skin_suffix: int = 1 #Choose Skin for each enemy
@export var on_node = true #Determine if enemy has pathing

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if on_node: #Determine if pathing
		pathfollow = get_parent()
		pathfollow.loop = false 
	set_skin_suffix(skin_suffix) #Set enemy skin animations

func set_skin_suffix(value: int) -> void: #Ensure enemy skin change
	skin_suffix = value
	#Variable Check
	skin_suffix = clamp(skin_suffix, 1, 4) 
	
	for action in skin_variants.keys():
		skin_variants[action] = skin_variants[action][skin_suffix - 1]

func _physics_process(delta): 
	if can_move:
		if on_node: #If has pathing
			patrol(delta) 
		else: #No pathing
			all_anim("Idle")
	else:
		if not is_alive: #If shoot by bullet
			all_anim("Death")
		else:
			start_attack_sequence() #If detects player

func start_attack_sequence(): #If seen, see sight script
	if not timer.is_stopped():
		return
	
	all_anim("Idle")
	await get_tree().create_timer(0.3).timeout #Duration of Time for Player Detection
	if not can_move: #If player is still seen
		all_anim("Attack")
		$AnimatedSprite2D/Gun_Shot.play("Attack")
		player.set_is_alive(false) #Signal player to die



func set_can_move(move: bool) -> void:
	can_move = move

#Animation Functions
func all_anim(action: String):
	var anim_name = skin_variants.get(action,action)
	$AnimatedSprite2D.play(anim_name)
	$"AnimatedSprite2D/Left Hands".play(action)
	$"AnimatedSprite2D/Right Hand".play(action)

func all_anim_flip(flip):
	$AnimatedSprite2D.flip_h = flip
	$"AnimatedSprite2D/Left Hands".flip_h = flip
	$"AnimatedSprite2D/Right Hand".flip_h = flip
	
	if flip == false:
		$Sight/Enemy_vision.scale.x = 1
		$AnimatedSprite2D/Gun_Shot.position.x = 11.5
		$AnimatedSprite2D/Gun_Shot.scale.x = 1
	else:
		$Sight/Enemy_vision.scale.x = -1
		$AnimatedSprite2D/Gun_Shot.position.x = -11.5
		$AnimatedSprite2D/Gun_Shot.scale.x = -1

#Patrol Function
func patrol(delta):
	if direction == 1:
		all_anim_flip(false)
		if pathfollow.progress_ratio == 1:
			all_anim("Idle")
			await get_tree().create_timer(1).timeout
			all_anim_flip(true)
			await get_tree().create_timer(0.5).timeout
			direction = 0
		else:
			all_anim("Run")
			pathfollow.progress += speed * delta
	else:
		all_anim_flip(true)
		if pathfollow.progress_ratio == 0:
			all_anim("Idle")
			await get_tree().create_timer(1).timeout
			all_anim_flip(false)
			await get_tree().create_timer(0.5).timeout
			direction = 1
		else:
			all_anim("Run")
			pathfollow.progress -= speed * delta

#Death Function
func die():
	can_move = false #Stop Patrol movement
	is_alive = false #Send Death Animation
	await get_tree().create_timer(1).timeout
	queue_free()
