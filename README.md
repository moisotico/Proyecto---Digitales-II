# Proyecto Digitales-II 
Diseño de la interfaz PCIe

# Integrantes:

* Giancarlo Marín Hernández - giancarlo.marin@ucr.ac.cr
* Moisés Campos Zepeda - moiso.camposcr@gmail.com
* Esteban Valverde Hernández - e.valverde95@hotmail.com

# Makefile

Los makefile se distribuyen con 4 reglas
```bash
$ make compilar # compila el archivo.v
$ make sintetizar # sintetiza la descripción conductual con Yosys
$ make visualizar # visualiza las formas de onda con GTKWave
$ make limpiar # elimina archivos intermedios generados
```


# Plan de trabajo propuesto
| Etapa | Actividad | Encargado | Tiempo  estimado (min) | Tiempo  dedicado (min)| Avance (%) | Fecha  de entrega | Comentarios |
|-------|-----------------------------|-----------|------------------------|------------------------|-------------------|-------------|-------------|
| 0 | Plan de trabajo | Esteban | 30 | 40 | 100 | 15/5/19 | Finalizado |
| 1 | Generador de relojes | Moisés | 300 | 330| 100 | 15/5/19 | Finalizado |
| 1 | Lógica muxes y demuxes | Giancarlo | 300 | 270| 100 | 15/5/19 | Finalizado |
| 1 | Paralelo a serial | Esteban | 300 | 320 | 100 | 15/5/19 | Finalizado |
| 2 | Byte striping y un-striping | - |- |- |-  | 22/5/19 | En progreso |
| 2 | Serial a paralelo | Giancarlo | - | - | - | 22/5/19 | En progreso |
| 2 | Módulo phy_tx.v | Todos | - |- |- | 22/5/19 | - |
| 3 | Módulo phy_rx.v | Todos | - |- |- | 29/5/19 | - |
| 3 | Módulo phy.v | Todos | - | - | - | 29/5/19 | - |
| 4 | Reporte | Todos | - |- |- | 1/6/19 | - |
| 5 | Presentación | Todos |- |- |-  | 5/6/19 | - |

# Bitácora de trabajo

Se adjunta el link a la bitácora:
* https://docs.google.com/document/d/1xzHUImjI0QSKrw0qv1Gr2Ju_TENDb1Xis8uLT6ndQJ4/edit?usp=sharing
