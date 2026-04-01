class_name ResultSelection extends OptionButton

func _ready():
	add_item("<Create>")
	
func reload_results(spin_results):
	clear()
	
	add_item("<Create>")
	for result in spin_results:
		add_item(result[SpinResultGenerator.TEXT])
