extends Node2D

func _on_point_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	get_parent().score += 1
