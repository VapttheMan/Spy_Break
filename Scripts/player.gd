extends CharacterBody2D

class_name Player

@export var BulletScene: PackedScene

@onready var timer_death: Timer = $Death_Timer
@onready var timer_roll: Timer = $Roll_Timer


#Player Ordering is set to 5

const speed = 100.0
const roll_speed_multiplier = 2
var current_dir = "none"
var is_alive = true
var can_move = true
var death_animation_played = false
var has_gun = false
var is_rolling = false
var rolling_cooldown = false

func _ready():
	$Player_Sprite.play("down_idle")

func _physics_process(delta):
	if not is_alive and not death_animation_played:
		$Player_Sprite.play("death")
		death_animation_played = true
		timer_death.start()
	elif is_alive:
		if is_rolling:
			perform_roll(delta)
			#print("im am rolling")
		elif can_move:
			player_movement(delta)
	
	if Input.is_action_just_pressed("ui_restart"):
		timer_death.start()
	
	if has_gun == true and Input.is_action_just_pressed("ui_roll"):
		fire_bullet()
		
	if Input.is_action_just_pressed("ui_select") and !is_rolling:
		start_roll()
		#print("roll started")
		
func start_roll():
	is_rolling = true
	#rolling_cooldown = true
	play_roll_animation()
	timer_roll.start()
	
func play_roll_animation():
	var dir = current_dir
	var anim = $Player_Sprite
	var suffix = "_gun" if has_gun else ""
	
	match dir:
		"right":
			anim.flip_h = true
			anim.play("side_roll" + suffix)
		"left":
			anim.flip_h = false
			anim.play("side_roll" + suffix)
		"down":
			anim.play("down_roll" + suffix)
		"up":
			anim.play("up_roll" + suffix)
		
	
func perform_roll(delta):
	match current_dir:
		"right": 
			velocity = Vector2.RIGHT * speed * roll_speed_multiplier 
		"left": 
			velocity = Vector2.LEFT * speed * roll_speed_multiplier 
		"up": 
			velocity = Vector2.UP * speed * roll_speed_multiplier 
		"down": 
			velocity = Vector2.DOWN * speed * roll_speed_multiplier
	move_and_slide()
	#print("i rolled")
	

	

func fire_bullet():
	var bullet = BulletScene.instantiate()
	
	bullet.position = global_position
	
	match current_dir:
		"right":
			bullet.direction = Vector2.RIGHT
			bullet.position.y -= 4
		"left":
			bullet.direction = Vector2.LEFT
			bullet.position.y -= 4
		"up":
			bullet.direction = Vector2.UP
		"down":
			bullet.direction = Vector2.DOWN
	
	get_parent().add_child(bullet)

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $Player_Sprite
	var suffix = "_gun" if has_gun else ""
	
	if dir == "right":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk" + suffix)
		elif movement == 0:
			anim.play("side_idle" + suffix)
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk" + suffix)
		elif movement == 0:
			anim.play("side_idle" + suffix)
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("down_walk" + suffix)
		elif movement == 0:
			anim.play("down_idle" + suffix)
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("up_walk" + suffix)
		elif movement == 0:
			anim.play("up_idle" + suffix)
		
func set_is_alive(alive: bool) -> void:
	is_alive = alive
	
func set_can_move(move: bool) -> void:
	can_move = move
	
func set_has_gun(gun: bool) -> void:
	has_gun = gun
	
func _on_timer_timeout() -> void:
	get_tree().reload_current_scene() # Replace with function body.


func _on_roll_timer_timeout() -> void:
	is_rolling = false
	#rolling_cooldown = false
