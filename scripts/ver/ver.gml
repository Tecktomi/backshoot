function ver(home = noone){
	var a = home.x, b = home.y
	hmove = (obj_jugador.x - a) / sqrt(sqr(obj_jugador.x - a) + sqr(obj_jugador.y - b))
	vmove = (obj_jugador.y - b) / sqrt(sqr(obj_jugador.x - a) + sqr(obj_jugador.y - b))
	//Moverse pixel por pixel hasta colisionar o salir de la pantalla
	repeat(200){
		a += hmove
		b += vmove
		if position_meeting(a, b, obj_jugador)
			return true
		if x < 0 or y < 0 or x > room_width or y > room_height or (position_meeting(a, b, int_solido) and not position_meeting(a, b, home))
			return false
	}
	return false
}