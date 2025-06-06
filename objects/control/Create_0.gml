randomize()
//  SELECCION DE ENTORNO
#macro inicio 1
#macro juegos 2
#macro cierre 3
#macro ajuste 4
#macro Gsetup 5
target = inicio

//  MAPA DE MUROS
sigilo = 90
tranquilidad = 90
motivo_perdida = 0
N_interfaz = 20
win = false
xsize = 40
ysize = 20
dark_alpha = 0
cajas = ds_grid_create(xsize, ysize)
ds_grid_clear(cajas, false)
for(var a = 0; a < xsize; a++)
	for(var b = 0; b < ysize; b++)
		if random(1) < 0.2
			ds_grid_set(cajas, a, b, true)
ds_grid_set_region(cajas, 0, 0, 2, 2, false)

//  COLORES Y UBICACIONES
c_fondo   = make_color_rgb( 153,000,045 )
c_relleno = make_color_rgb( 000,255,153 ) 
c_borde   = make_color_rgb( 000,204,122 ) 


//  CAPAS PARA PRIORIDAD DE DIBUJO
dp1 = layer_create(1, "depth-low")
dp2 = layer_create(2, "depth-mid")
dp3 = layer_create(3, "depth-hig")


//  SINCRONIA
tiempo = 0
window_set_fullscreen(true)