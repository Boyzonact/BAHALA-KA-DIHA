extends Node

var maxHP : int = 3
var currentHP : int

signal on_health_changed

func _ready():
	currentHP = maxHP
	
func decrease_HP(health_amt : int):
	currentHP -= health_amt
	
	if currentHP < 0:
		currentHP = 0
	print("decrease hp",currentHP)
	on_health_changed.emit(currentHP)
	
func increase_HP(health_amt : int):
	currentHP += health_amt
	
	if currentHP > maxHP:
		currentHP = maxHP
	print("increase hp")
	on_health_changed.emit(currentHP)
