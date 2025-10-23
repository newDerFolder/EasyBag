extends Window

var mainNode
@onready var tagsList=$tagsList

func change():
	for i in tagsList.get_children():
		i.queue_free()
	for n in mainNode.tagsData:
		var t=preload("res://easyBag/activitys/tagItem.tscn").instantiate()
		t.id=n
		add_child(t)
func changeUI():
	pass
