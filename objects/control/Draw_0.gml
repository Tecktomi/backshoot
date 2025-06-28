//  PARAMETROS COMPARTIDOS
window_set_cursor(cr_default)
//  SI ESTAMOS EN EL INICIO
if target = inicio{
	var run = crear_inicio()
	if run = Gsetup
		target = Gsetup
	else if run = ajuste
		target = ajuste
}
//  SI ESTAMOS EN EL GAME-SETUP
if target = Gsetup{
	crear_Gsetup()
	target = juegos
}
//  SI ESTAMOS EN EL JUEGO
if target = juegos and crear_juegos() = cierre
	target = cierre
//  SI ESTAMOS EN EL CIERRE
if target = cierre and crear_cierre() = inicio
	target = inicio
//  SI ESTAMOS EN LOS AJUSTES
if target = ajuste and crear_ajuste() = inicio
	target = inicio
if keyboard_check_pressed(vk_f4)
	window_set_fullscreen(not window_get_fullscreen)