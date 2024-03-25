*************************************************
********* Plan Nacional de Fibra Optica *********
************************************************* 
/*
Autor: Daniel Lasso 
LAST MODIFIED: 21/03/2024
Comments: El codigo se desarrolla de la siguiente forma: 
	1. Cargar las bases de datos, procesarlas y juntarlas
	2. Creacion y definicion de variables de interes
	3. Metodologia de estudio de eventos escalonado con diferentes metodos de estimacion
	4. Creacion de graficos. 
*/



**************************************
********* Definir directorio *********
**************************************


******* CAMBIAR EL DIRECTORIO DE TRABAJO 

if "`c(username)'"=="danie"{
	cd "D:\noveno semestre\Econometria\Taller de datos"
	}
	

log using "\log\lasso_do_file.txt", text replace

*********** Importar los datos 
********* hasta el 20052 el delimitador es | , luego es ¬


***** juntar las bases del 2005 al 2009 pq tienen el puntaje recalificado

forvalues i=5(1)9{
	
	if `i'==5 { 
		
		import delimited "SB11_200`i'1.txt", delimiter("|") clear
		save "SB11_200`i'1.dta", replace

		import delimited "SB11_200`i'2.txt", delimiter("|") clear
		save "SB11_200`i'2.dta", replace
		
		
	}
	
	else{
		import delimited "SB11_200`i'1.txt", delimiter("¬") clear
		save "SB11_200`i'1.dta", replace

		import delimited "SB11_200`i'2.txt", delimiter("¬") clear
		save "SB11_200`i'2.dta", replace
	}

}

		import delimited "SB11_20102.txt", delimiter("¬") clear
		save "SB11_20102.dta", replace

***** juntar las bases desde el 2012


**************************************
********* Cambio a formato .dta *********
**************************************


forvalues i=2(1)9{
	
	if `i'==9 { 
		
		import delimited "SB11_201`i'1.txt", delimiter("|") clear
		save "SB11_201`i'1.dta", replace

		import delimited "SB11_201`i'2.txt", delimiter("¬") clear
		save "SB11_201`i'2.dta", replace
		
		
	}
	
	else{
		import delimited "SB11_201`i'1.txt", delimiter("¬") clear
		save "SB11_201`i'1.dta", replace

		import delimited "SB11_201`i'2.txt", delimiter("¬") clear
		save "SB11_201`i'2.dta", replace
	}

}



************************************************
********* Preprocesamiento hasta 2014-1 *********
************************************************
*Mantener algunas variables relevantes y estandarizar los nombres


forvalues i=2(1)3{
use "SB11_201`i'2.dta", clear
drop punt_ingles
drop punt_matematicas
rename recaf_punt_sociales_ciudadanas punt_sociales_ciudadanas
rename recaf_punt_matematicas punt_matematicas
rename recaf_punt_ingles punt_ingles
rename recaf_punt_lectura_critica punt_lectura_critica
rename recaf_punt_c_naturales punt_c_naturales
keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador punt_c_naturales cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_sociales_ciudadanas punt_matematicas punt_lectura_critica punt_ingles
save "SB11_201`i'2.dta", replace


use "SB11_201`i'1.dta", clear
drop punt_ingles
drop punt_matematicas
rename recaf_punt_sociales_ciudadanas punt_sociales_ciudadanas
rename recaf_punt_matematicas punt_matematicas
rename recaf_punt_ingles punt_ingles
rename recaf_punt_lectura_critica punt_lectura_critica
rename recaf_punt_c_naturales punt_c_naturales
keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador fami_tiene_celular punt_c_naturales cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_sociales_ciudadanas punt_matematicas punt_lectura_critica punt_ingles
save "SB11_201`i'1.dta", replace
}

use "SB11_20141.dta", clear
drop punt_ingles
drop punt_matematicas
rename recaf_punt_sociales_ciudadanas punt_sociales_ciudadanas
rename recaf_punt_matematicas punt_matematicas
rename recaf_punt_ingles punt_ingles
rename recaf_punt_lectura_critica punt_lectura_critica
rename recaf_punt_c_naturales punt_c_naturales
keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador punt_c_naturales cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_sociales_ciudadanas punt_matematicas punt_lectura_critica punt_ingles
save "SB11_20141.dta", replace

******************************************************
********* Preprocesamiento despues del 2014-1 *******
******************************************************
*Mantener algunas variables relevantes y estandarizar los nombres

use "SB11_20142.dta", clear
keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador punt_c_naturales cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_sociales_ciudadanas punt_matematicas punt_lectura_critica punt_ingles punt_global
save "SB11_20142.dta", replace

forvalues i=5(1)6{
use "SB11_201`i'2.dta", clear
keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador punt_c_naturales cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_sociales_ciudadanas punt_matematicas punt_lectura_critica punt_ingles punt_global
save "SB11_201`i'2.dta", replace


use "SB11_201`i'1.dta", clear
keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador punt_c_naturales cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_sociales_ciudadanas punt_matematicas punt_lectura_critica punt_ingles punt_global
save "SB11_201`i'1.dta", replace
}

		
**************************************************************************
************************************************************************
******************* Anadir datos de antes del 2012  ******************
************************************************************************
************************************************************************
************************************************************************
	use "SB11_20092.dta", clear
		
		forvalues i=9(1)9{
		
			import delimited "SB11_200`i'1.txt", delimiter("¬") clear
			save "SB11_200`i'1.dta", replace

			import delimited "SB11_200`i'2.txt", delimiter("¬") clear
			save "SB11_200`i'2.dta", replace


	}
		
		forvalues i=0(1)1{
		
			import delimited "SB11_201`i'1.txt", delimiter("¬") clear
			save "SB11_201`i'1.dta", replace

			import delimited "SB11_201`i'2.txt", delimiter("¬") clear
			save "SB11_201`i'2.dta", replace


	}

		forvalues i=0(1)0{
	use "SB11_201`i'2.dta", clear
	rename punt_lenguaje punt_lectura_critica


	keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_matematicas punt_lectura_critica punt_ingles
	save "SB11_201`i'2.dta", replace


	use "SB11_201`i'1.dta", clear
	rename punt_lenguaje punt_lectura_critica
	keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_matematicas punt_lectura_critica punt_ingles
	save "SB11_201`i'1.dta", replace
	}

	
	
	
	use "SB11_20092.dta", clear
	rename punt_lenguaje punt_lectura_critica


		keep periodo estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_matematicas punt_lectura_critica punt_ingles
		save "SB11_20092.dta", replace


		
** cambiar los caracteres del string de "," a "."		
	use "SB11_20112.dta", clear
	rename punt_lenguaje punt_lectura_critica
	replace punt_matematicas= subinstr(punt_matematicas, ",", ".",.)
	replace punt_lectura_critica= subinstr(punt_lectura_critica, ",", ".",.)
	replace punt_ingles= subinstr(punt_ingles, ",", ".",.)
	destring punt_lectura_critica, replace
	destring punt_ingles, replace
	destring punt_matematicas, replace
	keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_matematicas punt_lectura_critica punt_ingles
	save "SB11_20112.dta", replace


	use "SB11_20111.dta", clear
	rename punt_lenguaje punt_lectura_critica
	keep periodo estu_cod_reside_mcpio estu_areareside estu_genero estu_valorpensioncolegio fami_estratovivienda fami_tieneinternet fami_tienecomputador cole_codigo_icfes cole_cod_dane_establecimiento cole_nombre_establecimiento cole_genero cole_naturaleza cole_calendario cole_bilingue cole_cod_dane_sede cole_nombre_sede cole_jornada cole_cod_mcpio_ubicacion punt_matematicas punt_lectura_critica punt_ingles
	save "SB11_20111.dta", replace

	******************************************************
	********* juntar las bases *********
	******************************************************

	use "SB11_20092.dta", clear
	
	* Juntar las bases de datos de ambos semestres
	forvalues i=0(1)6{
	append using "SB11_201`i'2.dta", force
	append using "SB11_201`i'1.dta", force
	}


	* generar variable de ano con respecto al periodo 
	gen ano = floor(periodo/10)

	* generar identificador del semestre de la observacion
	gen semestre=real(substr(string(periodo),5,1))
	tostring semestre, replace
	
	** crear la codificacion de la variable semestre como factor
	encode semestre, gen(semestre_str) 
	label define semestre_str 1 "Primero" 2 "Segundo", modify 
	drop semestre
	drop periodo

	* guardar la base completa
	save SB11.dta, replace

	******************************************************
	********* Asignar individuos tratados        *********
	******************************************************

	* importar la lista de municipios que fueron asignados al PNFO
	import delimited "Proyecto_Nacional_de_Fibra__ptica.csv", clear 
	keep municipio_cod fechaoperacion

	* generar variable del ano de tratamiento
	gen ano_trat= substr(fechaoperacion,1,4)
	drop if missing(ano_trat)	

	* cambiar nombre y guardar
	rename municipio_cod cole_cod_mcpio_ubicacion
	save "tratados.dta", replace



	******************************************************
	********* Pegar tratamiento a puntajes saber *********
	******************************************************
	use SB11.dta, replace


	merge m:1 cole_cod_mcpio_ubicacion using "tratados.dta"
	drop _merge
	drop fechaoperacion

	destring ano_trat, replace

	save SB11.dta, replace


	*****************************************************************
	********* Pegar municipios que tenian Alta conectividad *********
	****************************************************************

	import delimited "Conectividad_de_Alta_Velocidad.csv", clear 
	keep municipio_cod fechainiciooperacion	


	gen ano_trat_alta_vel= substr(fechainiciooperacion,1,4)
	drop fechainiciooperacion
	rename municipio_cod cole_cod_mcpio_ubicacion


	sort cole_cod_mcpio_ubicacion
	quietly by cole_cod_mcpio_ubicacion:  gen dup = cond(_N==1,0,_n)

	drop if dup==2

	drop dup
	save "alta_vel.dta", replace

	************************************************************************
	*********   juntar  Alta conectividad con los puntajes  ******************
	************************************************************************
	use SB11.dta, replace

	merge m:1 cole_cod_mcpio_ubicacion using "alta_vel.dta"
	drop if _merge ==2

	destring ano_trat_alta_vel, replace


	gen fueron_tratados = ano_trat

	replace fueron_tratados= ano_trat_alta_vel if missing(fueron_tratados)

	************************************************************************
	*********   Eliminar lo siempre tratados   ******************
	************************************************************************

	drop if missing(fueron_tratados)

	************************************************************************
	*********   construccion de la variable de tratamiento   ******************
	************************************************************************

	* crear la variable toma 1 para los años posteriores a recibir el tratamiento
	gen tratado = (ano >= ano_trat & ano_trat!=0)
	drop _merge



	ssc install ereplace

		*) Estimación
		
	* generar cohortes de tratamiento de estudio de eventos	
	by cole_cod_mcpio_ubicacion, sort: egen firsttime = min(cond(tratado==1, ano,.))
	replace firsttime=0 if firsttime==.

	
	gen cohorts= firsttime
	replace cohorts=. if firsttime==0





	net install csdid, from ("https://raw.githubusercontent.com/friosavila/csdid_drdid/main/code/") replace


	************************************************************************
	*********   Colapsar a nivel sede de la institucion  ******************
	************************************************************************

	**egen id_colegio = concat(cole_codigo_icfes cole_cod_mcpio_ubicacion)
	**tostring id_colegio, gen(id_col) format("%12.0f")
	***egen id_unico_col = group(cole_codigo_icfes)
	***tostring id_unico_col, replace

	
	******** Añadir variables por cada valor del factor. 
 	
	tab cole_jornada, g(cole_jornada_)
	levelsof cole_jornada, local(NAMES)
	foreach name of local NAMES {	
	gen tipo_jornada_`name' = (cole_jornada == "`name'") 
	}
	drop cole_jornada_*

	******** Añadir variables por cada valor del factor del colegio

	tab cole_bilingue, g(cole_bilingue_)
	levelsof cole_bilingue, local(NAMES)
	foreach name of local NAMES {	
	gen colegio_bilinue_`name' = (cole_bilingue == "`name'") 
	}
	drop cole_bilingue_*


	******** Añadir variables por cada valor del factor del calendario

	tab cole_calendario, g(cole_calendario_)
	levelsof cole_calendario, local(NAMES)
	foreach name of local NAMES {	
	gen colegio_calendario_`name' = (cole_calendario == "`name'") 
	}
	drop cole_calendario_*


	tab cole_naturaleza, g(cole_naturaleza_)

	tab cole_genero, g(cole_genero_) 
	levelsof cole_genero, local(NAMES)
	foreach name of local NAMES {	
	gen colegio_genero_`name' = (cole_genero == "`name'") 
	}
	drop cole_genero_*

	
	******** Añadir variables por cada valor del factor si la familia tiene internet

	tab fami_tieneinternet, g(fami_tieneinternet_) 
	levelsof fami_tieneinternet, local(NAMES)
	foreach name of local NAMES {	
	gen internet_`name' = (fami_tieneinternet == "`name'") 
	}
	drop fami_tieneinternet_*

	******** Añadir variables por cada valor del factor si la familia tiene Computador

	tab fami_tienecomputador, g(fami_tienecomputador_) 
	levelsof fami_tienecomputador, local(NAMES)
	foreach name of local NAMES {	
	gen computador_`name' = (fami_tienecomputador == "`name'") 
	}
	drop fami_tienecomputador_*
	
	
	******** Collapsar las observaciones a unidad de Colegio. 

	*** por codigo dane 
	collapse (mean) tipo_jornada_* colegio_bilinue_* colegio_calendario_* cole_naturaleza_* colegio_genero_* internet_* computador_* firsttime punt_*, by(cole_cod_dane_establecimiento ano)

	** por codigo unico 
	*** collapse (mean) tipo_jornada_* colegio_bilinue_* colegio_calendario_* cole_naturaleza_* colegio_genero_* internet_* computador_* firsttime punt_*, by(id_col ano)

	********* identificador unico de colegio 

	destring ano, replace
	destring cole_cod_dane_establecimiento, replace


	**** calculod el puntaje global con la formula del icfes **********
	replace punt_global= 5*(3*punt_sociales_ciudadanas+ 3*punt_c_naturales+ 3*punt_lectura_critica+ 3*punt_matematicas+ punt_ingles)/13 if missing(punt_global) & ano>2011
		
		
	* Eliminar códigos del dane no reportados	
	drop if cole_cod_dane_establecimiento==0
	drop if cole_cod_dane_establecimiento== .
	
	

********************************	
*** estadisticas descriptivas ***
*********************************


asdoc sum punt_* tipo_jornada_COMPLETA cole_naturaleza_2 internet_Si computador_Si if firsttime!=0 , stat(N mean sd min max) replace
	
	
*********************************************
*********   estimaciones   ******************
*********************************************

** exploración inicial Callaway Sant Anna.

***** punt matematicas 		
csdid punt_ingles, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime)  
estat event
csdid_plot

***** tiene internet 
csdid internet_Si, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime)  
estat event
csdid_plot

***** tiene internet 
csdid internet_Si, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime)  
estat event
csdid_plot
	


* 1.2. Modelo dinámico - TWFE
*-------------------------------------------------------------------------------*
*) Creamos una variable que nos indique el tiempo relativo

	gen rel_time=ano-firsttime

*El tiempo relativo no está definido para nunca tratados
replace rel_time=. if firsttime==0 

*) Generamos dummies para cada categoría posible de tiempos relativos

tab rel_time, gen(evt)


*) Cambiamos los labels y los nombres para no confundirnos

*Generar los Leads

forvalues x = 1/7 {
    
    local j= 8-`x'
	ren evt`x' evt_l`j'
	cap label var evt_l`j' "-`j'" 
}


*Generar los Lags

forvalues x = 0/3 {
    
    local j= 8+`x'
	ren evt`j' evt_f`x'
	cap label var evt_f`x' "`x'"  
}


*) Periodo base - Omitir por multicolinealidad

replace evt_l1=0
	
*) Estimación
***** posibles controles tipo_jornada_COMPLETA tipo_jornada_MAÑANA tipo_jornada_NOCHE colegio_bilinue_S colegio_calendario_A cole_naturaleza_1 colegio_genero_MIXTO
* Estimación sin controles
reghdfe punt_ingles evt_l* evt_f* , absorb(cole_cod_dane_establecimiento ano) cluster(cole_cod_dane_establecimiento) 

estimates store coefs_i
	
*) Gráfica del modelo TWFE  
coefplot coefs_i, keep(evt_l* evt_f*) omitted														///
	vertical 																	///
	label drop(_cons)															///
	yline(0, lpattern(dash) lwidth(*0.5))   							 		///
	ytitle("Puntaje de matemáticas")                                     ///
	xtitle("Tiempo relativo al tratamiento", size(medsmall))			 		///
	xlabel(, labsize(small) nogextend labc(black)) 	 				 			///
	ylabel(,nogrid nogextend labc(black) format(%9.2f)) 				 		///
	msymbol(O) 														 			///
	mlcolor(black) 													 			///
	mfcolor(black) 													 			///
	msize(vsmall) 													 			///
	levels(95) 														 			///
	xline(7, lpattern(dash) lwidth(*0.5))										///
	ciopts(lcol(black) recast(rcap) lwidth(*0.8)) 					 			///
	plotregion(lcolor(black) fcolor(white))  							 		///
	graphregion(lcolor(black) fcolor(white))  						 			///
	yscale(lc(black)) 												 			///
	xscale(lc(black)) 												 			///
	name(Salario_3, replace)
	/*	Note que no hay IC para la dummy del tiempo -1 (no tiene error
		estándar), esto se debe a que es nuestro periodo de referencia. 
		Es decir, los coeficientes se interpretan con respecto a dicho periodo. */	
		
*) Pruebas de hipótesis
estimates restore coefs_i
test evt_l1 evt_l2 evt_l3  /* No hay efectos anticipatorios 			*/
test evt_f0 evt_f1 evt_f2 evt_f3 /* Hay efectos dinámicos				*/

****************************************
* 2.2. Estimación por callaway Santa Ana (2020)	con el comando CSDID
*-------------------------------------------------------------------------------*
************************ efecto promedio *******************************
** puntaje de matematicas
csdid punt_matematicas tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(group)
estat group, estore(cs1) 
*** estimación del puntaje de inglés. 
csdid punt_ingles tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime)  
estat group, estore(cs2) 

*** crear tabla de resultados usando ESTSTO
eststo matematicas: csdid punt_matematicas tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(group)
eststo ingles: csdid punt_ingles tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(group)
eststo lectura: csdid punt_lectura_critica tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(group)
** esttab
esttab matematicas ingles lectura using "tabla_efe_dinamicos.tex", se replace

*****************************
csdid punt_global tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime)  
estat event
csdid_plot


****************************************************************
****************** tendencias paralelas ************************

** verificación del supuesto de tendencias paralelas. 
eststo pl_matematicas: csdid punt_matematicas tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(event)
eststo pl_ingles: csdid punt_ingles tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(event)

** exportar tabla de tendencias paralelas. 
esttab pl_matematicas pl_ingles using "tabla_tparalelas.tex", se replace


***************** Gráficas
**************************
***** punt matematicas 		
csdid punt_matematicas tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(event) 
estat event
csdid_plot
graph save "Graph" "D:\noveno semestre\Econometria\Taller de datos\cs_matematicas.gph"
***** punt lectura 		
csdid punt_lectura_critica , ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime)  
estat event
csdid_plot

***** punt ingles 		
csdid punt_ingles tipo_jornada_COMPLETA cole_naturaleza_1, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime)  
estat event
csdid_plot
graph save "Graph" "D:\noveno semestre\Econometria\Taller de datos\cs_ingles.gph"


ssc install grc1leg

grc1leg cs_ingles.gph cs_matematicas.gph

********** Exploración de efectos heterogéneos. 
*********************
eststo privado: csdid punt_matematicas if cole_naturaleza_1==1 , ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(simple)
eststo publico: csdid punt_matematicas if cole_naturaleza_1==0 , ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(simple)
eststo bilingue: csdid punt_matematicas if colegio_bilinue_S==1 , ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(simple)
eststo nobilingue: csdid punt_matematicas if colegio_bilinue_S==0 , ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime) agg(simple)



esttab bilingue nobilingue privado publico using "publicovsprivado.tex", se replace

*************************
***** Pruebas de robustez
**************************

** pruebas con distintos estimadores de estudio de eventos:


{		
	* Globals importantes

		global post 3	 /* Número de periodos post sin contar el 0*/
		global pre 6 /* Número de periodos pre*/
		global ep event_plot
		global g0 "default_look"
		global g1 xla(-$pre (1) $post) /*global g1 xla(-5(1)5)*/
		global g2 xt("Periodos relativos al evento")
		global g3 yt("Efecto causal")
		global g  $g1 $g2 $g3
		global t "together"


		// Estimación con did_multiplegt of de Chaisemartin and D'Haultfoeuille (2020)

		did_multiplegt punt_ingles cole_cod_dane_establecimiento ano tratado, robust_dynamic dynamic($post) placebo(3) breps(20) cluster(cole_cod_dane_establecimiento) 
		event_plot e(estimates)#e(variances), stub_lag(Effect_#) stub_lead(Placebo_#) $t $g0 graph_opt($g ti("CD 20") name(gCD, replace))
		matrix dcdh_b = e(estimates) // storing the estimates for later
		matrix dcdh_v = e(variances)

		// Estimación con csdid of Callaway and Sant'Anna (2020)
		csdid punt_ingles, ivar(cole_cod_dane_establecimiento) time(ano) gvar(firsttime)  		
		estat event, estore(cs) // this produces and stores the estimates at the same time
		$ep cs, stub_lag(Tp#) stub_lead(Tm#) $t $g0 graph_opt($g ti("CS 20") name(gCS, replace))

		// Estimación con eventstudyinteract of Sun and Abraham (2020)


		eventstudyinteract punt_ingles evt_l* ref evt_f*, 	                 ///
			absorb(cole_cod_dane_establecimiento) cohort(firsttime) 				///
			control_cohort(never) vce(cluster i.cole_cod_dane_establecimiento)
		$ep e(b_iw)#e(V_iw), stub_lag(evt_f#) stub_lead(evt_l#) $t $g0 graph_opt($g ti("SA 20")  name(gSA, replace)) 
		matrix sa_b = e(b_iw) // storing the estimates for later
		matrix sa_v = e(V_iw)

		// Estimación por TWFE

		reghdfe punt_ingles evt_l* ref evt_f*, nocon absorb(cole_cod_dane_establecimiento ano) cluster(cole_cod_dane_establecimiento) 
		estimates store ols // saving the estimates for later
		$ep ols,  stub_lag(evt_f#) stub_lead(evt_l#) $t $g0 graph_opt($g ti("OLS") name(gOLS, replace))  




		/* gY gBJS gCD gCS gSA gOLS gGB gG gCDLZ */
		graph combine gOLS gCD gCS gSA, ycommon name(combined, replace)	


		// Combine all plots using the stored estimates
		event_plot dcdh_b#dcdh_v cs sa_b#sa_v  ols, ///
			stub_lag( Effect_# Tp# evt_f#  evt_f#) ///
			stub_lead( Placebo_#  Tm# evt_l# evt_l# ) ///
			plottype(scatter) ciplottype(rcap) ///
			together perturb(-0.325(0.1)0.325) trimlead(5) noautolegend ///
			graph_opt(  ///
			xtitle("Periodos relativos al evento", size(small)) ///
			ytitle("Efecto causal promedio en el puntaje global estimado", size(small)) xlabel(-$pre(1)$post)  ///
			legend(order( 1 "D'Haultfoeuille" ///
						3 "CS" 5 "SA" 7 "TWFE") rows(2) position(6) region(style(none))) ///
			/// the following lines replace default_look with something more elaborate
				xline(-0.5, lcolor(gs8) lpattern(dash)) yline(0, lcolor(gs8)) graphregion(color(white)) bgcolor(white) ylabel(, angle(horizontal)) ///
			) 	///
			lag_opt1(msymbol(+) color(black)) lag_ci_opt1(color(black)) ///
			lag_opt2(msymbol(O) color(cranberry)) lag_ci_opt2(color(cranberry)) ///
			lag_opt3(msymbol(Dh) color(navy)) lag_ci_opt3(color(navy)) ///
			lag_opt4(msymbol(Th) color(forest_green)) lag_ci_opt4(color(forest_green)) ///			
	
}		



