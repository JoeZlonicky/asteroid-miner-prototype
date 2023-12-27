class_name Inventory
extends Component


var items: Dictionary = {}


func add_item(item_name: ItemData, n: int = 1):
	items[item_name] = items.get(item_name, 0) + n
