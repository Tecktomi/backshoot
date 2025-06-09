//  CREAR EL INICIO
function crear_inicio(){
	//  BACKGROUD
	draw_set_color(make_color_rgb(100, 0, 32))
	draw_rectangle(0, 0, room_width, room_height, false)
	//  ELEMENTOS VENTANA DE INICIO
	draw_set_color(c_black)
	draw_set_font(font_titulo)
	draw_set_halign(fa_center)
	draw_text(room_width / 2, 300, "B A C K S H O O T")
	draw_set_halign(fa_left)
	draw_set_font(ft_media)
	if draw_boton((room_width - string_width("Jugar")) / 2, 200, "Jugar")
		return Gsetup
	if draw_boton(room_width * 0.4, room_height - 100, "Salir") or keyboard_check(vk_escape)
		game_end()
	if draw_boton(room_width * 0.6, room_height - 100, "Información")
		return ajuste
	draw_sprite(spr_vineta, 0, 0, 0)
	return inicio
}

//  CREAR EL GAME-SETUP
function crear_Gsetup(){	
	draw_clear(c_black)
	for(var a = 0; a < xsize; a++)
		for(var b = 0; b < ysize; b++)
			if cajas[# a, b]
				instance_create_layer(a * 32, b * 32, dp2, obj_muro)
	var visited = ds_grid_create(xsize, ysize), pila = ds_list_create()
	ds_grid_clear(visited, false)
	ds_list_add(pila, [0, 0])
	ds_grid_set(visited, 0, 0, true)
	while not ds_list_empty(pila){
		var coord = ds_list_find_value(pila, 0), a = coord[0], b = coord[1]
		ds_list_delete(pila, 0)
		var vecinos = [[a - 1, b], [a, b - 1], [a + 1, b], [a, b + 1]]
		for(var c = 0; c < 4; c++){
			coord = vecinos[c]
			a = coord[0]
			b = coord[1]
			if a >= 0 and b >= 0 and a < xsize and b < ysize and not visited[# a, b] and not cajas[# a, b]{
				ds_list_add(pila, [a, b])
				ds_grid_set(visited, a, b, true)
			}
		}
	}
	repeat(control.enemigos_max){
		do var a = irandom_range(5, xsize), b = irandom_range(5, ysize)
		until visited[# a, b]
		ds_grid_set(visited, a, b, false)
		instance_create_layer(a * 32 + 16, b * 32 + 16, dp2, obj_enemigo)
	}
	instance_create_layer(16, 16, dp1, obj_jugador)
	tiempo = 120
}

//  CREAR EL JUEGO
function crear_juegos(){
	draw_set_font(ft_little)
	draw_set_color(#00FFFF)
    draw_rectangle(0, 32 * control.N_interfaz, room_width, room_height, false)
	var dd = 4
	draw_set_color(#1E1E1E)
    draw_rectangle(dd, 32 * control.N_interfaz + dd, room_width - dd, room_height - dd, false)
	draw_set_color(#FFA500)
	draw_text(500, 32 * control.N_interfaz + 32, "Sigilo")
	draw_text(500, 32 * control.N_interfaz + 74, "Tranquilidad")
	draw_text(800, 32 * control.N_interfaz + 32, "TIEMPO:")
	draw_text(800, 32 * control.N_interfaz + 64, $"{floor(control.tiempo)} s")
	draw_text(room_width - 150, 32 * control.N_interfaz + 32, "Objetivos:")
	draw_text(room_width - 150, 32 * control.N_interfaz + 64, $"{instance_number(obj_enemigo)}/{control.enemigos_max}")

	minibar(40, 32 * control.N_interfaz + 16, 380, 32 * control.N_interfaz + 56 , control.sigilo, #FF0000, false)
	minibar(40, 32 * control.N_interfaz + 74, 380, 32 * control.N_interfaz + 114, control.tranquilidad, #9B4DFF, false)
	control.sigilo += 0.02
	if control.sigilo < 0{
		control.motivo_perdida = 2
		control.sigilo = 0
		return cierre
	}
	if control.sigilo > 90
		control.sigilo = 90
	if control.tranquilidad < 0{
		control.tranquilidad = 0
		control.motivo_perdida = 1
		return cierre
	}
	if control.tranquilidad > 90
		control.tranquilidad = 90
	control.tranquilidad = control.tranquilidad + 0.02
	control.tiempo -= 1 / 60
	if instance_number(obj_enemigo) = 0{
		control.win = true
		return cierre
	}
	if control.tiempo <= 0{
		control.motivo_perdida = 0
		return cierre
	}
	draw_set_color(c_white)
	if keyboard_check(vk_escape)
		return inicio
	draw_set_alpha(1 - tranquilidad / 90)
	draw_sprite(spr_vineta, 0, 0, 0)
	draw_set_alpha(0.2)
	draw_sprite(spr_vineta, 0, 0, 0)
	draw_set_alpha(1)
	return juegos
}

//  CREAR EL CIERRE
function crear_cierre(){
	//  BACKGROUD
	draw_set_color(make_color_rgb(100, 0, 32))
	draw_rectangle(0, 0, room_width, room_height, false)
	draw_set_color(c_black)
	draw_set_halign(fa_center)
	if not win{
		draw_set_font(font_titulo)
		draw_text(room_width / 2, 200, "Has Perdido")
		var a = 200 + string_height("Has Perdido")
		draw_set_font(ft_media)
		if control.motivo_perdida = 0
			draw_text(room_width / 2, a, "Se te ha acabado el tiempo")
		else if control.motivo_perdida = 1
			draw_text(room_width / 2, a, "Has asesinado a alguien mirándolo a los ojos...")
		else if control.motivo_perdida = 2
			draw_text(room_width / 2, a, "Te han visto!")
	}
	else{
		draw_set_font(font_titulo)
		draw_text(room_width / 2, 200, "Has ganado")
		var a = 200 + string_height("Has ganado")
		draw_set_font(ft_media)
		draw_text(room_width / 2, a, "Has matado a un montón de personas, felicidades")
	}
	draw_set_halign(fa_left)
	//  ELEMENTOS VENTANA DE INICIO
	if draw_boton(room_width / 2, room_height - 200, "Salir")
		return game_end()
	draw_sprite(spr_vineta, 0, 0, 0)
	return cierre
}

//  CREAR EL AJUSTE
function crear_ajuste(){
	//  BACKGROUD
	draw_set_color(make_color_rgb(100, 0, 032))
	draw_rectangle(0, 0, room_width, room_height, false)
	//  ELEMENTOS VENTANA DE INICIO
	draw_set_color(c_black)
	draw_text(200, 80, "CREADORES:\n" +
						"  Sebastián Cornejo\n"+
						"  Axel Garrido\n"+
						"  Tomás Ramdohr\n\n"+
						"Assets:\n"+
						"  Ninguno\n\n"+
						"Mecánicas:\n"+
						"  Sigilo y Remordimiento\n\n"+
						"En Backshoot tendrás que practicar el sigilo\n"+
						"Encarnas a un sicario con una misión: matarlos a todos.\n"+
						"Sin embargo hay algo dentro tuyo que carcome tu alma...\n"+
						"Así es! La Culpa.\n"+
						"No soportas verlos a los ojos.\n"+
						"Suerte en tu misión...")
	if draw_boton(room_width / 2, room_height * 0.9 , "Volver")
		return inicio
	draw_sprite(spr_vineta, 0, 0, 0)
	return ajuste
}