extends RigidBody2D

export var min_speed = 150 
export var max_speed = 300

#vai randomizar o tamnho do inimigo e as animações
func _ready():
	var tipo_inimigo = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = tipo_inimigo[randi() %tipo_inimigo.size()]
	
#quando o inimigo sair da tela, ele vai ser excluido	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
