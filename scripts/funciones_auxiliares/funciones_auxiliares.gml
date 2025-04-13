//  BOTON GENERICO
function draw_boton(x, y, text, margen = 10, color_fondo = control.c_relleno, color_borde = control.c_borde, color_texto = c_black, fuente = Font1){
	var color = draw_get_color(), width = string_width(text), height = string_height(text)
	if margen > 0{
	    draw_set_color(color_borde)
	    draw_rectangle(x - margen, y - margen, x + width + margen, y + height + margen, false);
	}
    draw_set_color(color_fondo);
    draw_rectangle(x, y, x + width, y + height, false);

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

//  GENERAR MUROS A PARTIR DEL MAPA
function gen_map(filas){
	for (var yy = 0; yy < array_length(filas); yy++){
	    var fila = filas[yy]
	    for (var xx = 1; xx < string_length(fila); xx++){
	        var caracter = string_char_at(fila, xx)
	        if caracter = "1"
				instance_create_layer( (xx-1)*32 , (yy-0)*32 ,  control.dp2, obj_muro)
	    }
	}
}

//  GENERAR ENEMIGOS A PARTIR DEL MAPA
function gen_enemy(filas){
	var contador = 0
	for (var yy = 0; yy < array_length(filas); yy++){
	    var fila = filas[yy]
	    for (var xx = 1; xx < string_length(fila); xx++){
	        var caracter = string_char_at(fila, xx)
	        if ( caracter == "0" and xx!=0 and yy!=0 ){
				if irandom(40) = 0 and contador < 10{
	                instance_create_layer((xx - 1) * 32 + 16, yy * 32 + 16, control.dp2, obj_enemigo)
	                contador++
				}
			}
	    }
	}
}

// PA LOS PAJEROS
function instance_create(x, y, obj, var_struct = {}){
	return instance_create_layer(x, y, "instances", obj, var_struct)
}


// MENSAJE MECANICAS
function print_msg(){
	draw_set_color(c_black)
	draw_text(100, 80, "CREADORES:\n  Sebastián Cornejo\nAxel Garrido\nTomás Ramdohr\n\nAssets:\n  Ninguno\n\nMecánica : Sigilo y Remordimiento\n ¿Cansado de los típicos HEADSHOOT?... Pues presentamos BACKSHOT!!!\nEl nuevo modo en el que tu personaje siente profunda culpa por avatir a sus enemigos...\nMátalos por la espalda y no los mires a los ojos, cuanto más de frente sean tus tiros tu indicador de culpa\naumentará hasta que te consuman tus remordimeintos\nElimina a todos los enemigos para ganar, estás contra el tiempo y no dejes que te detecten\n\nMANTEN EL SIGILO\nPasar por el campo de vision de los enemigos te hará perder puntos de sigilo gradualmente\nSi te detectan, perderás!!!")
}

//  AREA TRIANGULO
function triangle_area(x1, y1, x2, y2, x3, y3){
	return abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2);
}


//  TAGGEAR DISPAROS
function disparar(home = noone){
	var a = home.x, b = home.y
	if home.object_index = obj_jugador
		angle = arctan2(mouse_y - b, mouse_x - a)
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
	home.bala_step = 8
	//Moverse pixel por pixel hasta colisionar o salir de la pantalla
	repeat(500){
		a += hmove
		b += vmove
		if (position_meeting(a, b, int_solido) and not position_meeting(a, b, home)) or a < 0 or b < 0 or a > room_width or b > room_height{
			home.bala_x = a
			home.bala_y = b
			if position_meeting(a, b, obj_enemigo){
				var inst = instance_place(a, b, obj_enemigo)
				inst.vida--
				var angulo = radtodeg(arctan2(inst.y - obj_jugador.y, inst.x - obj_jugador.x))
				if abs(angle_difference(angulo, inst.dir)) < 60
					control.tranquilidad = control.tranquilidad - (60 - abs(angle_difference(angulo, inst.dir)))
			}
			return
		}
	}
	home.bala_x = a
	home.bala_y = b
}
//  propiedad intelectual de Axel (ADOLF HITLER) dibuja barras variables con fondo en negro
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