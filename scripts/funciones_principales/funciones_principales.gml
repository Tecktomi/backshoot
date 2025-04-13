//  CREAR EL INICIO
function crear_inicio()
{
	//  BACKGROUD
	draw_set_color(control.c_fondo)
	draw_rectangle(0, 0, room_width, room_height, false)
	//  ELEMENTOS VENTANA DE INICIO
	if draw_boton(room_width / 2, room_height / 10, "Jugar")
		return Gsetup
	if draw_boton(room_width * 0.4, room_height * 0.9, "Salir")
		game_end()
	if draw_boton(room_width * 0.6, room_height * 0.9, "Información")
		return ajuste
	return inicio
}

//  CREAR EL GAME-SETUP
function crear_Gsetup()
{	
	draw_clear(c_black)
	var filas = string_split(control.mapa, "-")
	gen_map(filas)
	gen_enemy(filas) 
	instance_create_layer(16, 16, control.dp1, obj_jugador)
	control.tiempo = 120
}

//  CREAR EL JUEGO
function crear_juegos()
{	
	draw_set_font(Font2)
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
		control.sigilo = 0
		return cierre
	}
	if control.sigilo > 90
		control.sigilo = 90
	if control.tranquilidad < 0{
		control.tranquilidad = 0
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
	if control.tiempo <= 0
		return cierre
	return juegos
}

//  CREAR EL CIERRE
function crear_cierre()
{
	//  BACKGROUD
	draw_set_color(make_color_rgb(100, 0, 32))
	draw_rectangle(0, 0, room_width, room_height, false)
	//  ELEMENTOS VENTANA DE INICIO
	if draw_boton(room_width / 2, room_height * 0.8, win ? "Has Ganado" : "Has Perdido")
		return game_end()
	return cierre
}

//  CREAR EL AJUSTE
function crear_ajuste()
{
	//  BACKGROUD
	draw_set_color(make_color_rgb(100, 0, 032))
	draw_rectangle(0, 0, room_width, room_height, false)
	//  ELEMENTOS VENTANA DE INICIO
	print_msg()
	if draw_boton(room_width / 2, room_height * 0.9 , "Volver")
		return inicio
	return ajuste
}




