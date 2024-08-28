class_name MeleeAction
extends ActionWithDirection

func perform() -> void:
	var target: Entity = get_blocking_entity_at_destination()
	if not target:
		return
	
	var damage: int = entity.fighter_component.power - target.fighter_component.defense

	var atk_desc: String = "%s attacks %s" % [entity.get_entity_name(), target.get_entity_name()]
	if damage > 0:
		atk_desc += " for %s damage" % damage
	else:
		atk_desc += " but does no damage."

	print(atk_desc)
	target.fighter_component.hp -= damage
