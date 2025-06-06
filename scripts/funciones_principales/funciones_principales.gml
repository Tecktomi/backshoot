//  CREAR EL INICIO
function crear_inicio(){
	//  BACKGROUD
	draw_set_color(control.c_fondo)
	draw_rectangle(0, 0, room_width, room_height, false)
	//  ELEMENTOS VENTANA DE INICIO
	draw_set_color(c_black)
	draw_set_font(font_titulo)
	draw_text(room_width / 2, 100, "BACKSHOOT")
	draw_set_font(ft_media)
	if draw_boton(room_width / 2, 200, "Jugar")
		return Gsetup
	if draw_boton(room_width * 0.4, room_height - 100, "Salir")
		game_end()
	if draw_boton(room_width * 0.6, room_height - 100, "Información")
		return ajuste
	return inicio
}

//  CREAR EL GAME-SETUP
function crear_Gsetup(){	
	draw_clear(c_black)
	for(var a = 0; a < xsize; a++)
		for(var b = 0; b < ysize; b++)
			if cajas[# a, b]
				instance_create_layer(a * 32, b * 32, dp2, obj_muro)
	repeat(15){
		do var a = irandom_range(5, xsize), b = irandom_range(5, ysize)
		until not cajas[# a, b]
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
	draw_text(800, 32 * control.N_interfaz + 64, control.tiempo )

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
	return juegos
}

//  CREAR EL CIERRE
function crear_cierre(){
	//  BACKGROUD
	draw_set_color(make_color_rgb(100, 0, 32))
	draw_rectangle(0, 0, room_width, room_height, false)
	if not win{
		draw_set_color(c_black)
		draw_set_font(font_titulo)
		draw_text(room_width / 2, 200, "Has Perdido")
		if control.motivo_perdida = 0
			draw_text(room_width / 2, 220, "Se te ha acabado el tiempo")
		else if control.motivo_perdida = 1
			draw_text(room_width / 2, 220, "Has asesinado a alguien mirándolo a los ojos...")
		else if control.motivo_perdida = 2
			draw_text(room_width / 2, 220, "Te han visto!")
	}
	else{
		draw_set_font(font_titulo)
		draw_text(room_width / 2, 200, "Has ganado")
		draw_set_font(ft_media)
		draw_text(room_width / 2, 220, "Has matado a un montón de personas, felicidades")
	}
	//  ELEMENTOS VENTANA DE INICIO
	if draw_boton(room_width / 2, room_height * 0.8, "Salir")
		return game_end()
	return cierre
}

//  CREAR EL AJUSTE
function crear_ajuste(){
	//  BACKGROUD
	draw_set_color(make_color_rgb(100, 0, 032))
	draw_rectangle(0, 0, room_width, room_height, false)
	//  ELEMENTOS VENTANA DE INICIO
	print_msg()
	if draw_boton(room_width / 2, room_height * 0.9 , "Volver")
		return inicio
	return ajuste
}