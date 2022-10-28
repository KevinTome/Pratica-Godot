extends Area2D

export var speed = 400
var screen_size
signal hit

#func ready = qnd começar o jogo
func _ready():
	hide()
	screen_size = get_viewport_rect().size

#func _process = enquanto o jogo estiver rodando
#conferir os inputs de movimento e incrementa-los qnd necessário	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x += -1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y += -1
	
	#chamar a animação e nomalizar a velocidade diagonal
	if velocity.length() >0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		$Rastro.emitting = true
	else:
		$AnimatedSprite.stop()
		$Rastro.emitting = false
	#coordenar as animações com as direções
	if velocity.x != 0:
		$AnimatedSprite.animation = "direita"
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_v = velocity.x < 0
	if velocity.y != 0:
		$AnimatedSprite.animation = "cima"
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_v = velocity.y > 0	
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_jogador_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
