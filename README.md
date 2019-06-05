# Proyecto Digitales-II
Diseño de la interfaz PCIe

# Integrantes:

* Giancarlo Marín Hernández - giancarlo.marin@ucr.ac.cr
* Moisés Campos Zepeda - moiso.camposcr@gmail.com
* Esteban Valverde Hernández - e.valverde95@hotmail.com

# Makefile

Los makefile se distribuyen con 4 reglas
```bash
$ make compile 		# compila el <archivo>.v
$ make synth  		# genera la síntesis del módulo en <archivo>.v
$ make rename		# realiza todo el proceso de renaming del <arhivo_synth>.v
$ make tb 			# visualiza las formas de onda de las pruebas completas con GTKWave del banco de pruebas
$ make clean 		# elimina archivos intermedios generados
$ make all			# ejecuta todos los procesos en el orden correcto
```


# Plan de trabajo propuesto
| Etapa | Actividad | Encargado | Tiempo  estimado (min) | Tiempo  dedicado (min)| Avance (%) | Fecha  de entrega | Comentarios |
|-------|-----------------------------|-----------|------------------------|------------------------|-------------------|-------------|-------------|
| 0 | Plan de trabajo | Esteban | 30 | 40 | 100 | 15/5/19 | Finalizado |
| 1 | Generador de relojes | Moisés | 300 | 330| 100 | 15/5/19 | Finalizado |
| 1 | Lógica muxes y demuxes | Giancarlo | 300 | 270| 100 | 15/5/19 | Finalizado |
| 1 | Paralelo a serial | Esteban | 300 | 320 | 100 | 15/5/19 | Finalizado |
| 2 | Byte striping y un-striping | Esteban |600 |620 |100  | 22/5/19 | Finalizado |
| 2 | Serial a paralelo | Giancarlo | 180 | 180 | 100 | 22/5/19 | Finalizado |
| 2 | Módulo phy_tx.v | Todos | 150 |300 |100 | 22/5/19 | Finalizado |
| 3 | Módulo phy_rx.v | Todos | 150 |360 |100 | 29/5/19 | Finalizado |
| 3 | Módulo phy.v | Todos | 100 | 600 | 100 | 29/5/19 | Finalizado |
| 4 | Reporte | Todos | 120 |300 |100 | 1/6/19 | Finalizado |
| 5 | Presentación | Todos |180 |180 |100  | 5/6/19 | Finalizado |

# Bitácora de trabajo

Se adjunta el link a la bitácora:
* https://docs.google.com/document/d/1xzHUImjI0QSKrw0qv1Gr2Ju_TENDb1Xis8uLT6ndQJ4/edit?usp=sharing
