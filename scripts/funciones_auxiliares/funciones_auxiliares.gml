//  BOTON GENERICO
function draw_boton(x, y, text, margen = 6, color_fondo = control.c_relleno, color_borde = control.c_borde, color_texto = c_black, fuente = ft_media){
	var color = draw_get_color(), width = string_width(text), height = string_height(text)
	if margen > 0{
	    draw_set_color(color_borde)
	    draw_rectangle(x - 2 * margen, y - margen - 2, x + width + 2 * margen, y + height + margen + 2, false)
	}
    draw_set_color(color_fondo)
    draw_rectangle(x - margen, y - 2, x + width + margen, y + height + 2, false)
    draw_set_font(fuente)
    draw_set_color(c_black)
    draw_text(x, y, text)
	draw_set_color(color)
	if mouse_x > x - margen and mouse_y > y - margen and mouse_x < x + width + margen and mouse_y < y + height + margen{
        window_set_cursor(cr_handpoint)
        if mouse_check_button_pressed(mb_left)
			return true
    }
    return false
}

//  TAGGEAR DISPAROS
function disparar(home = noone){
	var a = home.x, b = home.y
	if home.object_index = obj_jugador{
		angle = arctan2(mouse_y - b, mouse_x - a)
		//Los enemigos escuchan disparos si están cerca
		with obj_enemigo
			if distance_to_object(obj_jugador) < 200
				alerta = 60
	}
	else{
		if instance_number(obj_jugador) = 0
			angle = 0
		else
			angle = arctan2(obj_jugador.y - b, obj_jugador.x - a)
	}
	angle += degtorad(random_range(-home.recoil, home.recoil))
	home.recoil += 10
	hmove = cos(angle)
	vmove = sin(angle)
	angle = (10 * floor(radtodeg(-angle / 10)) + 360) mod 360
	home.bala_step = 8
	//Moverse pixel por pixel hasta colisionar o salir de la pantalla
	repeat(500){
		a += hmove
		b += vmove
		if (position_meeting(a, b, int_solido) and not position_meeting(a, b, home)) or a < 0 or b < 0 or a > room_width or b > room_height{
			home.bala_x = a
			home.bala_y = b
			if position_meeting(a, b, obj_enemigo){
				var inst = instance_place(a, b, obj_enemigo), c  = degtorad(inst.dir), d = cos(c), e = sin(c), angle_2 = radtodeg(arctan2(e, d))
				inst.vida--
				inst.alerta = 300
				if sqrt(sqr(obj_jugador.x - a) + sqr(obj_jugador.y - b)) < 200 and abs(angle_difference(angle, angle_2)) > 120
					control.tranquilidad -= (abs(angle_difference(angle, angle_2)) - 120) / 3
				var surf = surface_create(200, 200), spr = spr_sangre
				surface_set_target(surf)
				draw_set_color(make_color_rgb(100, 0, 32))
				for(c = -10; c < 70; c++){
					d = degtorad(random_range(angle - 25, angle + 25))
					draw_circle(100 + c * cos(d), 100 - c * sin(d), 1, false)
				}
				spr = sprite_create_from_surface(surf, 0, 0, 200, 200, true, false, 0, 0)
				surface_reset_target()
				surface_free(surf)
				array_push(control.manchas_sangre, {sprite : spr, x : a - 100, y : b - 100})
			}
			return
		}
	}
	home.bala_x = a
	home.bala_y = b
}
//  propiedad intelectual de Axel dibuja barras variables con fondo en negro
function minibar(x01, y01, x001, y001, alfa, colorcitope, tof){
	var lambda = clamp(alfa, 0, 90)
	var newlambda = lambda / 90
	var x02 = x01 + (x001 - x01) * newlambda
	draw_set_alpha(0.6)
	draw_set_color(c_black)
	draw_rectangle(x01, y01, x001, y001, tof)
	draw_set_color(colorcitope)
	draw_rectangle(x01, y01, x02, y001, false)
}