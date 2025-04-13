if not alerta
{
	var cx = x;
    var cy = y;
	var ox = x + 150*cos(dir);
    var oy = y + 150*sin(dir);
	
	var angulo = 60*(pi/180)
	
	var angle1 = angulo*(1);
	var xp1 = cx + (ox-cx)*cos(angle1) - (oy-cy)*sin(angle1)
	var yp1 = cy + (ox-cx)*sin(angle1) + (oy-cy)*cos(angle1)
	
	var angle2 = angulo*(-1);
	var xp2 = cx + (ox-cx)*cos(angle2) - (oy-cy)*sin(angle2)
	var yp2 = cy + (ox-cx)*sin(angle2) + (oy-cy)*cos(angle2)
	
	var v1_x = x, v1_y = y;
	var v2_x = xp1, v2_y = yp1;
	var v3_x = xp2, v3_y = yp2;
	
	draw_set_color(c_red);
	draw_set_alpha(0.5);

	draw_primitive_begin(pr_trianglelist);
	draw_vertex(v1_x, v1_y);
	draw_vertex(v2_x, v2_y);
	draw_vertex(v3_x, v3_y);
	draw_primitive_end();

	draw_set_alpha(1);

	var px = obj_jugador.x;
	var py = obj_jugador.y;

	var area_total = triangle_area(v1_x, v1_y, v2_x, v2_y, v3_x, v3_y);

	var area1 = triangle_area(px, py, v2_x, v2_y, v3_x, v3_y);
	var area2 = triangle_area(v1_x, v1_y, px, py, v3_x, v3_y);
	var area3 = triangle_area(v1_x, v1_y, v2_x, v2_y, px, py);

	if (abs(area1 + area2 + area3 - area_total) < 0.01) {
		detecion = true
	} else {
		detecion = false
	}
	
	var magnitud = random_range(0, 0.1);
	dir = dir+magnitud
	
	if ( abs(dir) > 1000 ) { dir = dir%pi }
	
	
}

draw_self()
if (vida <= 0) { instance_destroy() }


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