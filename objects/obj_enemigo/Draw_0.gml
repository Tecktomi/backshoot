draw_set_color(c_red)
draw_set_alpha(0.3)
var angle = 60, radio = 150, radio_escucha_pasos = 60
//Triángulo de visión
for(var a = -angle / 10; a < angle / 10; a++){
	var cosa = cos(degtorad(dir + a * 10)), sina = sin(degtorad(dir + a * 10))
	var cosb = cos(degtorad(dir + a * 10 + 10)), sinb = sin(degtorad(dir + a * 10 + 10))
	draw_triangle(x, y, x + cosa * radio, y - sina * radio, x + cosb * radio, y - sinb * radio, false)
}
draw_set_color(c_black)
draw_set_alpha(1)
//Ver al jugador
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
				control.sigilo--
				alerta = 60
				break
			}
		}
	}
	if (obj_jugador.hmove != 0 or obj_jugador.vmove != 0) and distance_to_object(obj_jugador) < radio_escucha_pasos / (1 + 2 * keyboard_check(vk_lshift))
		alerta = 30
}
draw_self()
if alerta > 0{
	alerta--
	var a = point_direction(x, y, obj_jugador.x, obj_jugador.y), b = angle_difference(a, dir)
	dir += b / 20
	draw_text(x, y - 20, "!!")
	if abs(obj_jugador.x - x) > abs(obj_jugador.y - y) and not place_meeting(x + sign(obj_jugador.x - x), y, int_solido)
		hmove = sign(obj_jugador.x - x)
	else
		vmove = sign(obj_jugador.y - y)
}
else{
	dir = (dir + dir_spd + 360) mod 360
	dir_step--
	if dir_step = 0{
		dir_step = irandom_range(120, 420)
		dir_spd = random_range(-1, 1)
	}
	if hmove = 0 and hmove = 0 and random(1) < 0.01{
		var a = irandom(3)
		hmove = (a mod 2) - 0.5
		vmove = floor(a / 2) - 0.5
	}
}


if random(1) < 0.001{
	hmove = 0
	vmove = 0
}
if place_meeting(x + hmove, y, int_solido){
	while not place_meeting(x + sign(hmove), y, int_solido)
		x += sign(hmove)
	hmove = 0
}
if x + hmove < 0{
	x = 0
	hmove = 0
}
if x + hmove > room_width - 32{
	x = room_width - 32
	hmove = 0
}
x += hmove

if place_meeting(x, y + vmove, int_solido){
	while not place_meeting(x, y + sign(vmove), int_solido)
		y += sign(vmove)
	vmove = 0
}
if y + vmove < 0{
	y = 0
	vmove = 0
}
if y + vmove > 32 * (control.N_interfaz - 1){
	y = 32 * (control.N_interfaz - 1)
	vmove = 0
}
y += vmove
if vida <= 0
	instance_destroy()