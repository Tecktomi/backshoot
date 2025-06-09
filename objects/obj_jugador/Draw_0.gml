//Movimiento más lento con shift (modo sigilio)
vel = 2 - keyboard_check(vk_lshift)
hmove = vel * (keyboard_check(ord("D")) - keyboard_check(ord("A")))
vmove = vel * (keyboard_check(ord("S")) - keyboard_check(ord("W")))
//Reducir la velocidad al moverse en diagonal
if abs(hmove * vmove) > vel{
	hmove /= sqrt(2)
	vmove /= sqrt(2)
}
//Colición horizontal
if place_meeting(x + hmove, y, int_solido){
	while not place_meeting(x + sign(hmove), y, int_solido)
		x += sign(hmove)
	hmove = 0
}
x += hmove
//Colición vertical
if place_meeting(x, y + vmove, int_solido){
	while not place_meeting(x, y + sign(vmove), int_solido)
		y += sign(vmove)
	vmove = 0
}
y += vmove

//  COLICION PAREDES/INTERFAZ
x = clamp(x, 16, room_width - 16)
y = clamp(y, 16, 32 * control.N_interfaz - 16)

//Disparar con el Mouse
if mouse_check_button(mb_left){
	step++
	if step = 8{
		step = 0
		balas--
		disparar(id)
	}
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
}
draw_set_color(c_black)
for(var a = 0; a < array_length(control.manchas_sangre); a++){
	var mancha = control.manchas_sangre[a]
	draw_sprite(mancha.sprite, 0, mancha.x, mancha.y)
}
//Recorrer todas las cajas para dibujar sus sombras
for(var a = 0; a < instance_number(obj_muro); a++){
	var muro = instance_find(obj_muro, a), mx = muro.x, my = muro.y
	//Dibujar solo las sombras de las cajas cercanas
	if sqrt(sqr(mx - x) + sqr(my - y)) < 400{
		var ne = sqrt(sqr(mx - x) + sqr(my - y)), xne = (mx - x) / ne, yne = (my - y) / ne
		var no = sqrt(sqr(mx + 32 - x) + sqr(my - y)), xno = (mx + 32 - x) / no, yno = (my - y) / no
		var se = sqrt(sqr(mx - x) + sqr(my + 32 - y)), xse = (mx - x) / se, yse = (my + 32 - y) / se
		var so = sqrt(sqr(mx + 32 - x) + sqr(my + 32 - y)), xso = (mx + 32 - x) / so, yso = (my + 32 - y) / so
		//Dibujar las sombras dependiendo desde dónde se vean (para evitar tapar la caja con su propia sombra)
		if x - 32 < mx{
			if y > my{
				draw_triangle(mx, my, mx + 32, my, mx + xne * 1000, my + yne * 1000, false)
				draw_triangle(mx + 32, my + 32, mx + 32, my, mx + 32 + xso * 1000, my + 32 + yso * 1000, false)
				draw_triangle(mx + 32, my, mx + xne * 1000, my + yne * 1000, mx + 32 + xso * 1000, my + 32 + yso * 1000, false)
			}
			if y - 32 < my{
				draw_triangle(mx + 32, my, mx + 32, my + 32, mx + 32 + xno * 1000, my + yno * 1000, false)
				draw_triangle(mx, my + 32, mx + 32, my + 32, mx + xse * 1000, my + 32 + yse * 1000, false)
				draw_triangle(mx + 32, my + 32, mx + 32 + xno * 1000, my + yno * 1000, mx + xse * 1000, my + 32 + yse * 1000, false)
			}
		}
		if x > mx{
			if y > my{
				draw_triangle(mx, my, mx + 32, my, mx + 32 + xno * 1000, my + yno * 1000, false)
				draw_triangle(mx, my, mx, my + 32, mx + xse * 1000, my + 32 + yse * 1000, false)
				draw_triangle(mx, my, mx + 32 + xno * 1000, my + yno * 1000, mx + xse * 1000, my + 32 + yse * 1000, false)
			}
			if y - 32 < my{
				draw_triangle(mx, my, mx, my + 32, mx + xne * 1000, my + yne * 1000, false)
				draw_triangle(mx, my + 32, mx + 32, my + 32, mx + 32 + xso * 1000, my + 32 + yso * 1000, false)
				draw_triangle(mx, my + 32, mx + xne * 1000, my + yne * 1000, mx + 32 + xso * 1000, my + 32 + yso * 1000, false)
			}
		}
	}
}
//Dibujar neblina a la distancia
for(var b = 0; b < 20; b++){
	var radio = 50 + 5 * b, radio_2 = radio + 5
	if b = 19
		radio_2 = 2000
	draw_set_alpha(b / 19)
	for(var a = 0; a < 32; a++){
		var c = a * pi / 16, cosa = cos(c), sina = sin(c), cosb = cos(c + pi / 16), sinb = sin(c + pi / 16)
		draw_triangle(x + radio * cosa, y + radio * sina, x + radio * cosb, y + radio * sinb, x + radio_2 * cosb, y + radio_2 * sinb, false)
		draw_triangle(x + radio * cosa, y + radio * sina, x + radio_2 * cosa, y + radio_2 * sina, x + radio_2 * cosb, y + radio_2 * sinb, false)
	}
}
draw_set_alpha(1)
draw_self()