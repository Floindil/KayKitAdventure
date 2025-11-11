extends MarginContainer
class_name ItemBanner

const my_scene: PackedScene = preload("res://scenens/ui/Inventory/ItemBanner.tscn")
var item: Item

static func new_item_banner(_item: Item) -> ItemBanner:
	var item_banner: ItemBanner = my_scene.instantiate()
	item_banner.item = _item
	var icon: TextureRect = item_banner.get_node("ItemBox/IconMargin/TextureMargin/IconTexture")
	icon.texture = _item.icon
	var name_label: Label = item_banner.get_node("ItemBox/NameMargin/Name")
	name_label.text = _item.name
	var amount_label: Label = item_banner.get_node("ItemBox/AmountMargin/Amount")
	amount_label.text = str(_item.amount)
	return item_banner

func get_item() -> Item:
	return item
