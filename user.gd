extends HBoxContainer

func _enter_tree():
	$UserLabel.text = name
	set_multiplayer_authority(str(name).to_int())
	if not is_multiplayer_authority(): 
		$LineEdit.editable = false
		$LineEdit.secret = true
		return  # Multiplayer authority guard

func _on_line_edit_text_submitted(new_text):
	send.rpc(new_text)
	
@rpc("call_local")
func send(text):
	$LineEdit.text = ""
	get_parent().get_parent().get_parent().get_parent().get_parent().cout(text)
