extends KinematicBody2D


# switch between COLOR or STYLE
var state = 0 # variable modified by char_mod.gd --> _on_color_pressed() or _on_style_pressed()


# HAIR COLOR PROPERTIES
var hair_color = 0
var arr_hair_color = \
	[
	Color( "9A6153" ), 
	Color( "FFB666" ), 
	Color( "D7806B" ), 
	Color( "448258" ), 
	]
# HAIR PROPERTIES
var hair_texture = 0
onready var hair = $base/body/head/hair
var arr_hair_texture = []
var arr_hair_texture_clicked = []
var arr_hair_texture_bitmap = []


# HEAD COLOR PROPERTIES
var head_color = 0
var arr_head_color = \
	[
	Color( "FFE6C7" ), 
	Color( "BE8D51" ), 
	Color( "FFFEC7" ), 
	]
# HEAD PROPERTIES
var head_texture = 0
onready var head = $base/body/head
var arr_head_texture = []
var arr_head_texture_clicked = []
var arr_head_texture_bitmap = []


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	# fill HAIR arrays
	fill_array_textures(arr_hair_texture, 'char_part_0', 'normal')
	fill_array_textures(arr_hair_texture_clicked, 'char_part_0', 'clicked')
	fill_array_textures(arr_hair_texture_bitmap, 'char_part_0', 'bitmap')
	
	
	# fill HEAD arrays
	fill_array_textures(arr_head_texture, 'char_part_1', 'normal')
	fill_array_textures(arr_head_texture_clicked, 'char_part_1', 'clicked')
	fill_array_textures(arr_head_texture_bitmap, 'char_part_1', 'bitmap')
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	# current HAIR
	_change_texture(hair, hair_texture)
	_change_color(hair, hair_color)
	# current HEAD
	_change_texture(head, head_texture)
	_change_color(head, head_color)


func _on_hair_pressed():
	if state == 0:
		hair_texture += 1
	
		if hair_texture == arr_hair_texture.size():
			hair_texture = 0
	
	else:
		hair_color += 1
	
		if hair_color == arr_hair_color.size():
			hair_color = 0


func _on_head_pressed():
	if state == 0:
		head_texture += 1
	
		if head_texture == arr_head_texture.size():
			head_texture = 0
	
	else:
		head_color += 1
	
		if head_color == arr_head_color.size():
			head_color = 0


func _change_texture(part, value):
	part.texture_normal = get("arr_" + str(part.name) + "_texture")[value]
	part.texture_hover = get("arr_" + str(part.name) + "_texture_clicked")[value]
	part.texture_click_mask = get("arr_" + str(part.name) + "_texture_bitmap")[value]


func _change_color(part, value):
	part.self_modulate = get("arr_" + str(part.name) + "_color")[value]


func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()
	
    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif file.ends_with(".import"):
            files.append(file.replace(".import", ""))
			
    dir.list_dir_end()
    return files


func fill_array_textures(arr, directory, directory_type):
	var dir = "res://images/" + directory + "/" + directory_type + "/"
	for file_name in list_files_in_directory(dir):
		arr.append(load(dir + file_name))
