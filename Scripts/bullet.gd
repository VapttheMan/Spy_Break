extends Node2D

class_name Bullet

var speed = 300
var direction = Vector2.ZERO



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta #Bullet movement

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"): #Kill enemies
		body.die()
		queue_free()
	if body.name != "Player": #If collision to anything, but player, disappear
		queue_free()
	
