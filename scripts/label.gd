extends Label

signal textFinished

var full:String = ""
var curr:String = ""
var i:int = 0

var timer:float = 0.0
var textSpeed:float = 0.05 # Seconds between characters

func _ready() -> void:
	setText("welcome to RAHHHHH!")
	await textFinished
	await get_tree().create_timer(1.0).timeout

	setText("you can jump on trees.")
	await textFinished
	await get_tree().create_timer(2.0).timeout
	
	setText("homer let the barts out")
	await textFinished
	await get_tree().create_timer(2.0).timeout
	
	setText("")

func setText(newString:String) -> void:
	full = newString
	curr = ""
	i = 0
	text = ""

func _process(delta: float) -> void:
	if i < full.length():
		timer += delta
		if timer >= textSpeed:
			timer = 0.0
			curr += full[i]
			i += 1

			text = curr
			
			if i >= full.length():
				textFinished.emit()
