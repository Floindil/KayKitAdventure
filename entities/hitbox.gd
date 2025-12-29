extends Area3D
class_name Hitbox

@export var damage: int

var active: bool = false
var hit_entities: = []

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area3D):
	if active:
		if area is Hurtbox and area.parent.name not in hit_entities:
			area.take_damage(damage)
			hit_entities.append(area.parent.name)

func activate():
	active = true
	hit_entities = []

func deactivate():
	active = false
	hit_entities = []
