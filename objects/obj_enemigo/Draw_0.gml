if not alerta{
	draw_set_color(c_red)
	draw_set_alpha(0.3)
	var angle = 60, radio = 150
	//Triángulo de visión
	for(var a = -angle / 10; a < angle / 10; a++){
		var cosa = cos(degtorad(dir + a * 10)), sina = sin(degtorad(dir + a * 10))
		var cosb = cos(degtorad(dir + a * 10 + 10)), sinb = sin(degtorad(dir + a * 10 + 10))
		draw_triangle(x, y, x + cosa * radio, y - sina * radio, x + cosb * radio, y - sinb * radio, false)
	}
	draw_set_color(c_black)
	draw_set_alpha(1)
	//Detección del jugador
	if distance_to_object(obj_jugador) < radio{
		var a = x, b = y
		angle = point_direction(x, y, obj_jugador.x, obj_jugador.y)
		if abs(angle_difference(angle, dir)) < 60{
			angle = degtorad(angle)
			var cosa = cos(angle), sina = -sin(angle)
			repeat(150){
				a += cosa
				b += sina
				if position_meeting(a, b, obj_muro)
					break
				if position_meeting(a, b, obj_jugador){
					control.sigilo -= 2
					break
				}
			}
		}
	}
	dir += dir_spd
	dir_step--
	if dir_step = 0{
		dir_step = irandom_range(120, 420)
		dir_spd = random_range(-1, 1)
	}
}

draw_self()
if vida <= 0
	instance_destroy()

if alerta{
	var jug_angle = point_direction(x, y, obj_jugador.x, obj_jugador.y)
	step++
	if step = 8{
		step = 0
		if ver(id)
			disparar(id)
	}
	recoil *= 0.9
	//Dibujar la trayectoria de la bala
	if bala_step > 0{
		draw_set_color(c_yellow)
		draw_set_alpha(bala_step-- / 8)
		draw_line(x, y, bala_x, bala_y)
		repeat(6)
			draw_line(bala_x, bala_y, bala_x + irandom_range(-10, 10), bala_y + irandom_range(-10, 10))
		draw_set_alpha(1)
		draw_set_color(c_black)
	}
	draw_text(x, y - 20, "!")
}