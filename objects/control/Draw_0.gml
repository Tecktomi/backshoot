//  PARAMETROS COMPARTIDOS
window_set_cursor(cr_default);


//  SI ESTAMOS EN EL INICIO
if (target == inicio)
{
	var run = crear_inicio()
	if ( run == Gsetup ) { target = Gsetup  }
	if ( run == ajuste ) { target = ajuste  }
}

//  SI ESTAMOS EN EL GAME-SETUP
if (target == Gsetup)
{
	var run = crear_Gsetup()
	target = juegos

}

//  SI ESTAMOS EN EL JUEGO
if (target == juegos)
{
	var run = crear_juegos()
	if ( run == cierre ) { target = cierre  }

}

//  SI ESTAMOS EN EL CIERRE
if (target == cierre)
{
	var run = crear_cierre()
	if ( run == inicio ) { target = inicio  }
}

//  SI ESTAMOS EN LOS AJUSTES
if (target == ajuste)
{
	var run = crear_ajuste()
	if ( run == inicio ) { target = inicio  }
}
