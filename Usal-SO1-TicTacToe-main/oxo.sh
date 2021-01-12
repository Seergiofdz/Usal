#Ruta del fichero de config.cfg (directorio actual)

	CONFIGURACION="oxo.cfg"
	ESTATS=""

# ---------------------------------------------------------------------------------------------------- #
# ----------------------------------------FUNCIONES AUXILIARES---------------------------------------- #
# ---------------------------------------------------------------------------------------------------- #

  # Funcion pulse para continuar 
        
	function CONTINUAR
 	{
  			echo -n -e "\e[0;37mPulse INTRO para continuar."
     		read
     		echo -e "\n"
	}
	
# ---------------------------------------------------------------------------------------------------- #
# ---------------------------------------COMPROBACION FICHEROS---------------------------------------- #
# ---------------------------------------------------------------------------------------------------- #

	# Funcion: Comprueba si el fichero de configuracion existe
	
	function COMPROBAR
	{
	
                if [ ! -f "oxo.cfg" ];
                then
                echo -e "\e[1;31mError: Si el archivo de configuracion no exite no se puede iniciar el juego"
                sleep 5
                exit
                
			fi
	}
# ---------------------------------------------------------------------------------------------------- #

   # Funcion para convertir cualquier opcion que se introduzca en mayuscula
        
	function MAYUSCULAS
 	{
     		case $OPCION in
     			"c")    OPCION="C";;
     			"j")    OPCION="J";;
     			"e")    OPCION="E";;
     			"s")    OPCION="S";;
     		esac
     	
     		case $RESPUESTA_CONFIG in
     			"c")	RESPUESTA_CONFIG="C";;
     			"ce")	RESPUESTA_CONFIG="CE";;
     			"r") 	RESPUESTA_CONFIG="R";;
     			"s") 	RESPUESTA_CONFIG="S";;
     		esac
   	}

# ---------------------------------------------------------------------------------------------------- #
# -----------------------------------------------JUEGO------------------------------------------------ #
# ---------------------------------------------------------------------------------------------------- #

# -------------------------------------------VARIABLES INICIALES-------------------------------------- #

	# Iniciamos las variables que se van a utilizar durante el juego
	
	SETS=0

	array=( "" "" "" "" "" "" "" "" "")
	FICHAS_J=3
	FICHAS_M=3

# ---------------------------------------------------------------------------------------------------- #

	# Funcion con la que mostramos el tablero principal

	function OXO_BOARD 
	{
		clear 
		echo -e "\t\e[37m[SET-$SETS]"
   	echo -e "\t\e[0;37m========="
		echo -e "\t\e[0;37m${array[0]:-0} | ${array[1]:-1} | ${array[2]:-2}"
		echo -e "\t\e[0;37m---------"
		echo -e "\t\e[0;37m${array[3]:-3} | ${array[4]:-4} | ${array[5]:-5}"
		echo -e "\t\e[0;37m---------"
		echo -e "\t\e[0;37m${array[6]:-6} | ${array[7]:-7} | ${array[8]:-8}"
		echo -e ""
		echo -e "\e[0;37m       -FICHAS-      "
		echo -e "\e[0;37m====================="
		echo -e "\e[0;37m| JUGADOR | MAQUINA |"
		echo -e "\e[0;37m====================="
		echo -e	"\e[0;37m|    $FICHAS_J    |    $FICHAS_M    |"
		echo -e "\e[0;37m====================="
		echo -e ""
	
	}

# ---------------------------------------------------------------------------------------------------- #

	# Función para decidir quien gana en caso de lograr una fila, columna o diagonal
	
	function REGLAS_PARA_GANAR
	{
		if [ $VALOR_CELDA == "${array[0]}" ] && [ $VALOR_CELDA == "${array[1]}" ] && [ $VALOR_CELDA == "${array[2]}" ];
		then
		MENSAJE_GANADOR
		FIN=true
		elif [ $VALOR_CELDA == "${array[3]}" ] && [ $VALOR_CELDA == "${array[4]}" ] && [ $VALOR_CELDA == "${array[5]}" ];
		then
		MENSAJE_GANADOR
		FIN=true
		elif [ $VALOR_CELDA == "${array[6]}" ] && [ $VALOR_CELDA == "${array[7]}" ] && [ $VALOR_CELDA == "${array[8]}" ];
		then
		MENSAJE_GANADOR
		FIN=true
		elif [ $VALOR_CELDA == "${array[0]}" ] && [ $VALOR_CELDA == "${array[3]}" ] && [ $VALOR_CELDA == "${array[6]}" ];
		then
		MENSAJE_GANADOR
		FIN=true
		elif [ $VALOR_CELDA == "${array[1]}" ] && [ $VALOR_CELDA == "${array[4]}" ] && [ $VALOR_CELDA == "${array[7]}" ];
		then
		MENSAJE_GANADOR
		FIN=true
		elif [ $VALOR_CELDA == "${array[2]}" ] && [ $VALOR_CELDA == "${array[5]}" ] && [ $VALOR_CELDA == "${array[8]}" ];
		then
		MENSAJE_GANADOR
		FIN=true
		elif [ $VALOR_CELDA == "${array[0]}" ] && [ $VALOR_CELDA == "${array[4]}" ] && [ $VALOR_CELDA == "${array[8]}" ];
		then
		MENSAJE_GANADOR
		FIN=true
		elif [ $VALOR_CELDA == "${array[6]}" ] && [ $VALOR_CELDA == "${array[4]}" ] && [ $VALOR_CELDA == "${array[2]}" ];
		then
		MENSAJE_GANADOR
		FIN=true
		fi
	}

# ---------------------------------------------------------------------------------------------------- #	

	# Funcion: Mensaje del ganador
	# Esta funcion presenta el mensaje del jugador que ha ganado la partida y
	# las estadisticas de la partida.
	# Ademas se meten los datos de las estadisticas a su fichero correspondiente	

	function MENSAJE_GANADOR 
	{       
		TTIME=$(($SECONDS - $START))
		echo -e "Enhorabuena $JUGADOR_N has ganado!!"
		echo -e "\tESTADISTICAS DE LA PARTIDA"
		echo -e "\n" 
	
		METERENELFICHERO

		tail -1 oxo.log
		echo -e "\n"
		ESTAD	
	
	}

# ---------------------------------------------------------------------------------------------------- #

	# Funcion: Obtener el inicio de las jugadas respectivamente
	# Esta funcion comienza la estadistica de jugada introduciendo previamente que se
	# la ficha central al comenzar el juego
	
	function JUGADA_M
	{
		if [[ $COMIENZO -eq 1 ]];
    then
 			echo -e "1.0.4:2.0.$CELDA" > oxo.log.10

 		else [[ $COMIENZO -eq 2 ]];
   		echo -e "2.0.4:2.0.$CELDA" > oxo.log.10       
   	fi            
	}

# ---------------------------------------------------------------------------------------------------- #

	# Funcion: Obtener el inicio de las jugadas respectivamente
	# Esta funcion comienza la estadistica de jugada introduciendo previamente que se
	# la ficha central al comenzar el juego
	
	function JUGADA_J
	{
 		if [[ $COMIENZO -eq 1 ]];
   	then
 			echo -e "1.0.4:1.0.$CELDA" > oxo.log.10
 			
 		else [[ $COMIENZO -eq 2 ]];
 			echo -e "2.0.4:1.0.$CELDA" > oxo.log.10
 		fi            
	}

# ---------------------------------------------------------------------------------------------------- #
# ---------------------------------------------FUNCIONES IA------------------------------------------- #
# ---------------------------------------------------------------------------------------------------- #

	# Funciones para que nuestra "IA" pueda decidir sus movimientos
	
	function DECISION_MAQUINA 
	{
		CELDA=$(($RANDOM%8))
		ESTA_CELDA_VACIA_M $CELDA
		
		if [ "$ESTADO_CELDA" == "vacia" ];
		then
			array[$CELDA]="$VALOR_CELDA"
	 	if ! [[ -s oxo.log.10 ]];      #si esta vacio NO ponemos \n, porque nos dara error en la lectura
 		then           
 			JUGADA_M
 		else
 			echo ":2.0.$CELDA" >> oxo.log.10
 		fi
		
		else
			MSG="\e[1;34mLa maquina recalcula su posición"
			DECISION_MAQUINA
		fi
	}

# ------------------------------

	function ESTA_CELDA_VACIA_M
	{
		echo -e "\e[1;34mLa maquina ha seleccionado la posicion $1"
		case $1 in
			[0-8]) if [ -z ${array[$1]} ];
			   then
			   ESTADO_CELDA=vacia
			   else
			   ESTADO_CELDA=novacia
			   fi;;
			*) echo -e "\e[1;34mLa maquina recalcula su posición"
				DECISION_MAQUINA;;
		esac
	}

# ------------------------------

	function DECISION_M_MV
	{
		TEMP=$1
		echo -e "\e[1;34mLa máquina calcula que ficha movera\n"
		sleep 5
		FICHA_INI_M=$(($RANDOM%8))
		echo "info: la ficha es $FICHA_INI_M"
	
		if [[ $TEMP -eq 1 ]] && [[ $FICHA_INI_M -eq 4 ]];
		then
			echo -e "\e[1;31mERROR: Ha decido no mover la ficha central, por lo que no la puede mover"
			sleep 3
			OXO_BOARD
			DECISION_M_MV $TEMP
		fi
	
		if [[ "${array[$FICHA_INI_M]}" == "$CAR_JUGADOR_1" ]] && [[ "${array[$FICHA_INI_M]}" != "$CAR_JUGADOR_2" ]];
		then
			echo -e "\e[1;31mNO MUEVA LAS FICHAS DE SU CONTRICANTE. TRAMPOSA"
			sleep 2
			OXO_BOARD
			DECISION_M_MV $TEMP
		elif [[ "${array[$FICHA_INI_M]}" != "$CAR_JUGADOR_1" ]] && [[ "${array[$FICHA_INI_M]}" != "$CAR_JUGADOR_2" ]];
		then
			echo -e "\e[1;31mERROR: Ha seleccionado una celda vacia"
			sleep 2
			OXO_BOARD
			DECISION_M_MV $TEMP
		elif [[ "${array[$FICHA_INI_M]}" == "$CAR_JUGADOR_2" ]];
		then
			echo -e ":2.$FICHA_INI_M." >> oxo.log.10
			array[$FICHA_INI_M]=""
			OXO_BOARD
			COLOCACION_M_MV
		fi
	}

# ------------------------------

	function COLOCACION_M_MV
	{

	echo -e "\e[1;34mLa máquina decide donde poner la ficha... NO TOQUE NADA POR FAVOR\n"
	sleep 3
	FICHA_FIN_M=$(($RANDOM%8))
	echo -e "info: La ficha es $FICHA_FIN_M"
	ESTA_CELDA_VACIA_MV_M $FICHA_FIN_M
	if [ "$ESTADO_CELDA" == "vacia" ];
	then
		array[$FICHA_FIN_M]="$VALOR_CELDA"
	echo  "$FICHA_FIN_M" >> oxo.log.10
	else
		echo -e "\e[1;31mEsta celda no esta vacía\n"
		COLOCACION_M_MV
	fi
	}

# ------------------------------

	function ESTA_CELDA_VACIA_MV_M
	{
	CELDA=$1
	case $CELDA in
		[0-8]) if [ -z ${array[$CELDA]} ];
			   then
			   ESTADO_CELDA=vacia
			   else
			   ESTADO_CELDA=novacia
			   fi;;
		*) 	echo -e "\e[1;34mLa maquina recalcula donde colocar la ficha... NO TOQUE NADA POR FAVOR\n"
				COLOCACION_M_MV;;
	esac
	}

# ---------------------------------------------------------------------------------------------------- #
# ------------------------------------------FUNCIONES JUGADOR----------------------------------------- #
# ---------------------------------------------------------------------------------------------------- #

	# Funciones para que el jugador pueda decidir que movimientos quiere hacer

	function ESTA_CELDA_VACIA 
	{
	read -e -p "Introduce un número (0-8)?: " CELDA
	case $CELDA in
		[0-8]) if [ -z ${array[$CELDA]} ];
			   then
			   ESTADO_CELDA=vacia
			   else
			   ESTADO_CELDA=novacia
			   fi;;
		*) echo -e "Introduce un número (0-8)?: "
		ESTA_CELDA_VACIA;;
	esac
	}

# ------------------------------

	function DECISION 
	{
	ESTA_CELDA_VACIA
	if [ "$ESTADO_CELDA" == "vacia" ];
	then
		array[$CELDA]="$VALOR_CELDA"
 		if ! [[ -s oxo.log.10 ]];      #si esta vacio NO ponemos \n, porque nos dara error en la lectura
   	then           
	 		JUGADA_J                                                     
		else
			echo -e ":1.0.$CELDA" >> oxo.log.10            
		fi
	else
		echo -e "\e[1;31mLa celda no esta vacía, Reintroduzca: "
		DECISION
	fi
	}
	
# ------------------------------

	function DECISION_J_MV 
	{
	TEMP=$1
	echo -e "\e[0;35minfo: la opcion central es $TEMP"
	echo -e "\e[1;32mIntroduzca la posición de la ficha que desea mover?: "
	read FICHA_INI_J
	# Comprobaciones iniciales con CENTRAL
	if [[ $TEMP -eq 1 ]] && [[ $FICHA_INI_J -eq 4 ]];
	then
		echo -e "\e[1;31mERROR: HA DECIDO NO MOVER LA FICHA CENTRAL"
		sleep 3
		OXO_BOARD
		DECISION_J_MV $TEMP
	fi
			
	if [[ "${array[$FICHA_INI_J]}" == "$CAR_JUGADOR_2" ]] && [[ "${array[$FICHA_INI_J]}" != "$CAR_JUGADOR_1" ]];
	then
		echo -e "\e[1;31mNO MUEVA LAS FICHAS DE SU CONTRICANTE. TRAMPOSO"
		sleep 3
		OXO_BOARD
		DECISION_J_MV $TEMP
	elif [[ "${array[$FICHA_INI_J]}" != "$CAR_JUGADOR_2" ]] && [[ "${array[$FICHA_INI_J]}" != "$CAR_JUGADOR_1" ]];
	then
		echo -e "\e[1;31mERROR: Ha seleccionado una celda vacia"
		sleep 2
		OXO_BOARD
		DECISION_J_MV $TEMP
	elif [[ "${array[$FICHA_INI_J]}" == "$CAR_JUGADOR_1" ]];
	then
	echo -e ":1.$FICHA_INI_J." >> oxo.log.10
	 
		array[$FICHA_INI_J]=""
		COLOCACION_J_MV
	fi
	}

# ------------------------------

	function COLOCACION_J_MV
	{
		echo -e "\e[1;32mIntroduzca donde quiere mover esa ficha?: "
		read FICHA_FIN_J 
		ESTA_CELDA_VACIA_MV_J $FICHA_FIN_J
		if [[ "$ESTADO_CELDA" == "vacia" ]];
		then
			array[$FICHA_FIN_J]="$VALOR_CELDA"
			echo $FICHA_FIN_J >> oxo.log.10
		else
			echo -e "\e[1;31mLa celda esta ocupada"
			COLOCACION_J_MV
		fi
	}

# ------------------------------

	function ESTA_CELDA_VACIA_MV_J
	{
	CELDA=$1
	case $CELDA in
		[0-8]) if [ -z ${array[$CELDA]} ];
			   then
			   ESTADO_CELDA=vacia
			   else
			   ESTADO_CELDA=novacia
			   fi;;
		*) echo -e "\e[1;32mIntroduce un número (0-8)?: "
		ESTA_CELDA_VACIA_MV_J;;
	esac
	}


# ---------------------------------------------------------------------------------------------------- #

	function COMENZAR 
	{
	START=$SECONDS
	if [[ $1 -eq 1 ]];
	then
		#echo -e "\e[0;35minfo: El jugador comienza primero"
		echo
	elif [[ $1 -eq 2 ]];
	then
		#echo -e "\e[0;35minfo: La máquina comienza primero"
		echo
	elif [[ $1 -eq 3 ]];
	then 
		COMIENZO=$(shuf -n 1 -e 1 2)
		COMENZAR $COMIENZO2
	fi
	}

# ---------------------------------------------------------------------------------------------------- #

	
 
	# Funcion para elegir quin comenzara la partida

	function COMIENZO1
	{
		clear
  	echo -e "\n\e[0;37mSeleccione quien quieres que empieze la partida:"
		echo ""
		echo -e "\n\t\e[0;37m1) Empieza el jugador"
    echo -e "\n\t\e[0;37m2) Empieza la máquina"
    echo -e "\n\t\e[0;37m3) Se eligirá de forma aleatoria"
                
  	echo -e "\n\e[0;37mIntroduzca una opción?: "
		read READCOMIENZO


		case $READCOMIENZO in
			"1") 	echo -e "info: Empieza el jugador"
				COMIENZO=$READCOMIENZO             
				echo -e "COMIENZO=$COMIENZO\nFICHACENTRAL=$FICHA\nESTADISTICAS=$ESTATS" > $CONFIGURACION
				;;
			"2")	echo -e "info: Empieza la maquina "
				COMIENZO=$READCOMIENZO
				echo -e "COMIENZO=$COMIENZO\nFICHACENTRAL=$FICHA\nESTADISTICAS=$ESTATS" > $CONFIGURACION
				;;
			"3")	
				COMIENZO=$(shuf -n 1 -e 1 2)
				echo -e "COMIENZO=$COMIENZO\nFICHACENTRAL=$FICHA\nESTADISTICAS=$ESTATS" > $CONFIGURACION
				;;
			*) #DEFAULT
				echo -e "\e[1;31mError. Solo puede introducir 1, 2 o 3"
				sleep 4
				COMIENZO1
				;;
		esac


}

# ---------------------------------------------------------------------------------------------------- #

	# Función para elegir si la ficha central se movera o no

	function FICHACENTRAL               
	{

    
	clear	
	echo -e "\e[0;37mIntroduzca si la ficha se podra mover durante la partida"
	echo -e "\e[0;37m1.- Para que no se pueda mover durante la partida"
	echo -e "\e[0;37m2.- Para que se pueda mover durante la partida"
	echo -e "\e[0;37mOpcion?: "

	read READFICHA
	
	case $READFICHA in
		"1")	
				FICHA=$READFICHA
				echo -e "COMIENZO=$COMIENZO\nFICHACENTRAL=$FICHA\nESTADISTICAS=$ESTATS" > $CONFIGURACION
				;;
		"2")
				FICHA=$READFICHA
				echo -e "COMIENZO=$COMIENZO\nFICHACENTRAL=$FICHA\nESTADISTICAS=$ESTATS" > $CONFIGURACION
				;;
		*) #DEFAULT
				echo -e "\e[1;31mError: Solo puede introducir 1 o 2"
				sleep 3
				FICHACENTRAL
				;;
		esac
	}


# ---------------------------------------------------------------------------------------------------- #   

	# Funcion: Cargar configuracion
	# Esta funcion carga los datos de oxo.cfg para poder utilizarlos
	# mas tarde durante la partida
	
	function CARGARCONFIG
	{
		COMENZAR_TEMP=$(grep "^COMIENZO=" < $CONFIGURACION |cut -f 2 -d "=")

		FICHA_TEMP=$(grep "^FICHACENTRAL=" < $CONFIGURACION |cut -f 2 -d "=")

		NUEVARUTA_TEMP=$(grep "^ESTADISTICAS=" < $CONFIGURACION |cut -f 2 -d "=")

		if [ $COMENZAR_TEMP -gt 2 ];
		then
			echo -e "\e[1;31mError: Has usado datos erroneos para el fichero cfg"
			sleep 3
			exit
		elif [ $FICHA_TEMP -gt 2 ];
		then
			echo -e "\e[1;31mError: Has usado datos erroneos para el fichero cfg"
			sleep 3
			exit
		fi
		
		COMIENZO=$COMENZAR_TEMP
		FICHA=$FICHA_TEMP
		ESTATS=$NUEVARUTA_TEMP

	}


# ---------------------------------------------------------------------------------------------------- # 

	# Funcion: Cambiar la ruta del fichero de estadisticas
	# Esta funcion cambia la ruta del fichero de estadisticas, poniendo
	# otro nombre que hace referencia a otro archivo

	function CAMBIARRUTA
	{
 	
	clear	
	echo ""
	echo -e "\e[0;37mIntroduzca una nueva ruta para su archivo de ESTADISTICAS?:"
	read NUEVARUTA
	if  ! [[ -r $NUEVARUTA ]] || ! [[ -w $NUEVARUTA ]] && ! [[ -a $NUEVARUTA ]];
	then
		echo -e "\n\e[1;31mERROR: Nueva ruta Incorrecta \e"                                                           
		CONTINUAR 
	else
		ESTATS=$NUEVARUTA
		echo -e "COMIENZO=$COMIENZO\nFICHACENTRAL=$FICHA\nESTADISTICAS=$ESTATS" > $CONFIGURACION
 	fi
	}

# ---------------------------------------------------------------------------------------------------- #  
# ---------------------------------------MENU DE CONFIGURACION---------------------------------------- #  
# ---------------------------------------------------------------------------------------------------- #  

	# funcion que lee los datos de oxo.cfg

	function CONFIG
	{
		CARGARCONFIG
		SALIR_CONFIG=false
		#Pediremos un valor
		until test $SALIR_CONFIG = true
		do
		# Nos disponemos a mostrar el menu
			
			clear
			
			echo -e "\n\t\e[1;37mCONFIGURACION"
			echo -e "\n\t\e[0;37mC) COMIENZO"
           	echo -e "\n\t\e[0;37mCE) FICHACENTRAL"
         	echo -e "\n\t\e[0;37mR) ESTADISTICAS"
	       	echo -e "\n\t\e[0;37mS) SALIR"  
	       	
	       	echo ""
                    
            echo -n -e "\e[0;37mIntroduzca una opcion >> "
            read RESPUESTA_CONFIG


			# De nuevo utilizamos la funcion MAYUSCULAS para transformar lo introducido
			
			MAYUSCULAS

            case $RESPUESTA_CONFIG in
            	"C") #COMIENZO 
                	COMIENZO1
                   	;;
                "CE") #CENTRAL =Si la ficha central 
                   	FICHACENTRAL
           			;;
				"R") # Nos permite cambiar la ruta 
                    CAMBIARRUTA 
                    ;;
               	"S") #SALIR: salir del juego
        			SALIR_CONFIG=true
                 	;;
            	*) #DEFAULT
					SALIR_CONFIG=true
					;;
			esac
     	done
 }

# ---------------------------------------------------------------------------------------------------- #

	# Función Principal (donde se desarolla todo el funcionamiento del juego)
	
function JUGAR 
{
	CARGARCONFIG
	CAR_1=X
	CAR_2=O
	array=("" "" "" "" "" "" "" "" "")
	
	#echo -e "\e[0;37mIntroduce quien sera el primero en jugar(1,2,3)?: "
	#echo -e "$COMIENZO"
	#echo ""
	#echo -e "\e[0;37mIntroduzca si la ficha se podra mover durante la partida"
	#echo -e "\e[0;37m1.- Para que no se pueda mover durante la partida"
	#echo -e "\e[0;37m2.- Para que se pueda mover durante la partida"
	#echo -e "\e[0;37mOpcion?: "
	#echo -e "$FICHA"
	#echo ""
	echo -e "\e[0;37mIntroduzca su nombre para poder jugar: "
	read NOMBRE
	echo ""
	
	COMENZAR $COMIENZO
	
	((SETS+=1))
	
	echo ""
	if [[ $COMIENZO -eq 1 ]];
	then
		array[4]=$CAR_1
		CAR_JUGADOR_1=$CAR_1
		CAR_JUGADOR_2=$CAR_2
		JUGADOR_1=$NOMBRE
		JUGADOR_2="maquina"
		((FICHAS_J-=1))
	
	elif [[ $COMIENZO -eq 2 ]];
	then
		array[4]=$CAR_1
		CAR_JUGADOR_1=$CAR_2
		CAR_JUGADOR_2=$CAR_1
		JUGADOR_1=$NOMBRE
		JUGADOR_2="maquina"
		((FICHAS_M-=1))
	fi
	sleep 5
	OXO_BOARD
	
		if [[ $COMIENZO -eq 1 ]];
		then
			i=0
		else [[ $COMIENZO -eq 2 ]];
			i=1
		fi		
	FIN=false	
	
	
#-----------------------------

	while [ "$FIN" != true ]
	do
	((i++))
	VALOR=`expr $i % 2`
	if [ "$VALOR" == "0" ];
	then
		JUGADOR=1
		VALOR_CELDA=$CAR_JUGADOR_1
		JUGADOR_N=$JUGADOR_1
		((SETS+=1))
		echo -e "\e[1;32mTurno del jugador >> $JUGADOR_N << ($VALOR_CELDA)"
		sleep 2
		
		if [[ $FICHAS_J -eq 0 ]] && [[ $FICHAS_M -eq 0 ]];
		then
			DECISION_J_MV $CENTRAL
		else
			DECISION
			((FICHAS_J-=1))
		fi
		
	else
		JUGADOR=2
		VALOR_CELDA=$CAR_JUGADOR_2
		JUGADOR_N=$JUGADOR_2
		((SETS+=1))
		echo -e "\e[1;34mTurno de la $JUGADOR_N ($VALOR_CELDA)"
		echo ""
		sleep 2
		echo -e "\e[1;34mEsperando a que la máquina calcule su posición... NO TOQUE NADA POR FAVOR"
		sleep 3
		
		if [[ $FICHAS_M -eq 0 ]] && [[ $FICHAS_J -eq 0 ]];
		then
			DECISION_M_MV $CENTRAL
		else
			DECISION_MAQUINA
			((FICHAS_M-=1))
		fi
		
	fi
	
		OXO_BOARD
		REGLAS_PARA_GANAR
done
	
}

# ---------------------------------------------------------------------------------------------------- #

	# Funcion para meter los datos en el fichero, que posteriormente se usara para las estadisticas
	
	function METERENELFICHERO
	{
		FECHA=$(date +"%d/%m/%Y")
		PARTIDA=$$
		COMIENZOP=$COMIENZO
		GANADOR=$JUGADOR
		TIEMPO=$TTIME
		MOVIMIENTOS=$SETS
		CENTRAL=$FICHA

		fmt -w 1000 oxo.log.10 > oxo.log.20

		sed 's/ //g' oxo.log.20 > oxo.log.30

		JUGADA=$(< oxo.log.30)

		echo -e "\n\t"

		if ! [[ -s $ESTATS ]];      #si esta vacio NO ponemos \n, porque nos dara error en la lectura
		then          
			echo -e  "$PARTIDA|$FECHA|$COMIENZOP|$FICHA|$GANADOR|$TIEMPO|$MOVIMIENTOS|$JUGADA" > $ESTATS
		else
			echo -e  "$PARTIDA|$FECHA|$COMIENZOP|$FICHA|$GANADOR|$TIEMPO|$MOVIMIENTOS|$JUGADA" >> $ESTATS
		fi

		rm oxo.log.10
		rm oxo.log.20
		rm oxo.log.30
	}


# ---------------------------------------------------------------------------------------------------- #

	# Funcion para leer las estadisticas

	function ESTAD
	{

		if ! [[ -s $ESTATS ]] || ! [[ -r $ESTATS ]] ;
   	then
   		echo -e "\t\t\nNo se tienen registros de estadisticas todavia\n\n"
   	else
   		
   		#Calculo el numero de jugadas
     	NUM_JUGADAS=$(($(wc -l < $ESTATS)))
     	
			declare -a JUGADAC               #Jugada mas corta
			declare -a JUGADAL      
			declare -a MOVCORTO              #Jugada mas corta
			declare -a MOVLARGO  
			            
			JUGADAC[1]=$(head -1 $ESTATS | cut -f 6 -d "|" )
			JUGADAC[2]=$(head -1 $ESTATS)                                    

			JUGADAL[1]=$(head -1 $ESTATS | cut -f 6 -d "|" )
			JUGADAL[2]=$(head -1 $ESTATS)    

			MOVCORTO[1]=$(head -1 $ESTATS | cut -f 7 -d "|" )
			MOVCORTO[2]=$(head -1 $ESTATS)                                    

			MOVLARGO[1]=$(head -1 $ESTATS | cut -f 7 -d "|" )
			MOVLARGO[2]=$(head -1 $ESTATS)
			
			# Informacion Debug sobre las estadisticas
      #echo "info: JUGADA CORTA_T > ${JUGADAC[1]}"
    	#echo "info: JUGADA CORTA > ${JUGADAC[2]}"
   		#echo "info: JUGADA LARGA_T > ${JUGADAL[1]}"
 			#echo "info: JUGADA LARGA > ${JUGADAL[2]}"
			#echo "info: MOV CORTO_T > ${MOVCORTO[1]}"
			#echo "info: MOV CORTO > ${MOVCORTO[2]}"
			#echo "info: MOV LARGO_T > ${MOVLARGO[1]}"
  		#echo "info: MOV LARGO > ${MOVLARGO[2]}"
		

		SUMA_TIEMPO=0
		SUMA_MOVIMIENTOS=0
		RESULTADO=0

		while IFS='|' read PID FECHA COMIENZOE FICHAE GANADOR TIEMPO TURNOS MOVIMIENTOS
		do
			echo -e "\n	PID: $PID
                 	FECHA: $FECHA
                    COMIENZO: $COMIENZOE
                    FICHA: $FICHAE
                    GANADOR: $GANADOR
                    TIEMPO DE LA PARTIDA: $TIEMPO
                    SETS: $TURNOS
                    MOVIMIENTOS: $MOVIMIENTOS
                	"
			# Calculos inciales para las medias
			((SUMA_TIEMPO+=TIEMPO))
			((SUMA_MOVIMIENTOS+=TURNOS))

			# Calculos Jugadas Escpeciales

			# Jugada mas corta
			if [ $TIEMPO -lt ${JUGADAC[1]} ]
			then
				JUGADAC[1]=$TIEMPO      #Tiempo
				JUGADAC[2]=$PID'|'$FECHA'|'$COMIENZOE'|'$FICHAE'|'$GANADOR'|'$TIEMPO'|'$TURNOS'|'$MOVIMIENTOS       #Informacion de la linea
			fi
			
			# Jugada mas larga
			if test $TIEMPO -gt ${JUGADAL[1]}
			then
				JUGADAL[1]=$TIEMPO      #Tiempo
				JUGADAL[2]=$PID'|'$FECHA'|'$COMIENZOE'|'$FICHAE'|'$GANADOR'|'$TIEMPO'|'$TURNOS'|'$MOVIMIENTOS          #Informacion de la linea
			fi
			
			# Movimiento mas pequeño
			if test  $TURNOS -lt ${MOVCORTO[1]}
			then
				MOVCORTO[1]=$TURNOS      #Tiempo
				MOVCORTO[2]=$PID'|'$FECHA'|'$COMIENZOE'|'$FICHAE'|'$GANADOR'|'$TIEMPO'|'$TURNOS'|'$MOVIMIENTOS          #Informacion de la linea                                        
			fi
			
			# Movimiento mas largo
			if test  $TURNOS -gt ${MOVLARGO[1]}
			then
				MOVLARGO[1]=$TURNOS      #Tiempo
				MOVLARGO[2]=$PID'|'$FECHA'|'$COMIENZOE'|'$FICHAE'|'$GANADOR'|'$TIEMPO'|'$TURNOS'|'$MOVIMIENTOS         #Informacion de la linea
			fi
		done < $ESTATS > borrar  

		echo -e "\n\e[1;37m JUGADAS GENERALES \n"

		# Calculo de las medias
		MEDIA_TIEMPO=$(($SUMA_TIEMPO/$NUM_JUGADAS))
		MEDIA_MOVIMIENTOS=$(($SUMA_MOVIMIENTOS/$NUM_JUGADAS))


		echo -e "\e[0;37mNumero total de partidas jugadas: $NUM_JUGADAS"
		echo -e "\e[0;37mMedia de las longitudes de los movimientos de todas las partidas: $MEDIA_MOVIMIENTOS"
		echo -e "\e[0;37mMedia del tiempo de todas las partidas: $MEDIA_TIEMPO"
		echo -e "\e[0;37mTiempo total en todas las partidas: $SUMA_TIEMPO"

		echo -e "\n\e[1;37m JUGADAS ESPECIALES \n"
		
		echo -e "\e[0;37mJugada mas corta en tiempo: ${JUGADAC[1]} ${JUGADAC[2]}"
		echo -e "\e[0;37mJugada mas larga en tiempo: ${JUGADAL[1]} ${JUGADAL[2]}"
		echo -e "\e[0;37mJugada con menos movimientos: ${MOVCORTO[1]} ${MOVCORTO[2]}"
		echo -e "\e[0;37mJugada con mas movimientos:${MOVLARGO[1]} ${MOVLARGO[2]}"
		echo -e "${MOVCORTO[2]}" > tmp1

		while IFS='|' read PID FECHA COMIENZOE FICHAE GANADOR TIEMPO TURNOS MOVIMIENTOS
		do	
			echo $PID
			echo $FECHA
			echo $COMIENZOE
			echo $FICHAE
			echo $GANADOR
			echo $TIEMPO
			echo $TURNOS
			echo $MOVIMIENTOS
		done < tmp1 > tmp2

		tail -1 < tmp2 > tmp3

		IFS=':' read -a var < tmp3

		for element in "${var[@]}"
		do
			echo "$element."
		done > tmp5

		fmt -w 1000 tmp5 > tmp6
		
		IFS='.' read -a var1 < tmp6

		for element in "${var1[@]}"
		do
   		echo "$element"
		done > tmp7

		FLAG=desactivo
		
		if [ "${var1[2]}" == 4 ];
		then
		FLAG=activo
		fi
		
		#echo "info:$FLAG"
		i=0
		RESULTADO=0
		LINEAS=$(wc -l<tmp7)
		#echo "lineas: $LINEAS"
		
		while [[ "$FLAG" == "activo" ]] && [[ "${var1[i]}" != 4 ]];
		do
			((RESULTADO+=1))
			((i+=4))
			#echo "var1: ${var1[i]} i: $i"
			if [[ "${var1[i]}" == 4 ]] || [[ "$i" -gt "$LINEAS" ]];
			then
				FLAG=desactivo
				((RESULTADO+=1))
			fi
			#echo "FLAG: $FLAG"
		done
		
		echo -e "\e[0;37mNumero de veces que ha sido ocupada la FICHA CENTRAL: $RESULTADO\n"

		# Borro todos los archivos temporales
		rm borrar
		rm tmp1
		rm tmp2
		rm tmp3
		rm tmp5
		rm tmp6
		rm tmp7

    fi 

}

# ---------------------------------------------------------------------------------------------------- #
# -----------------------------------------INICIO DEL PROGRAMA---------------------------------------- #
# ---------------------------------------------------------------------------------------------------- #


	# Función: Lectura de los argumentos de la terminal
	# Se decide segun los argumentos que reciba el programa si se muestran o
	# no los nombres de los integrantes del grupo

 	function LEER_ARGUMENTOS 
	{
		if test "$1" != "-g";
		then
			ERROR=true
			echo arg: $#
			echo argn: $*
			echo -e "\e[1;31mERROR: debe utilizar oxo.sh [-g]"
		elif test "$1" = "-g";
		then
			echo -e "\n\e[1;33mLos integrantes del grupo son:\n"
			echo -e "\t\e[1;33mSergio Fernández Marcos"
			echo -e "\t\e[1;33mSergio García González"
			sleep 3
			exit
		
		fi
	}

# ---------------------------------------------------------------------------------------------------- #
# ------------------------------------------------MENU------------------------------------------------ #
# ---------------------------------------------------------------------------------------------------- #

  COMPROBAR      
	CARGARCONFIG
  ERROR=false
        
  # Comprobación de los argumentos que se le pasan al programa
  
  if test $# -gt 1;
  then
  	ERROR=true          
   	echo -e "\e[1;31mERROR. Solo se puede pasar un argumento"
  fi

	if test $# -eq 1;
  then
  	LEER_ARGUMENTOS $1
  fi

	SALIR=$ERROR    
	
	# Iniciamos el menu del juego
	        
  until test $SALIR = true
  do 
		clear
  	#echo -e "\e[0;35minfo: Los parametros son: $*"
    #echo -e "\e[0;35minfo: Numeros son: $#"
    
    echo -e ""
 		echo -e "\e[1;36m  / _ \  __  __   ___     __   __   / |      / _ \  "
		echo -e "\e[1;36m | | | | \ \/ /  / _ \    \ \ / /   | |     | | | | "
 		echo -e "\e[1;36m | |_| |  >  <  | (_) |    \ V /    | |  _  | |_| | "
 		echo -e "\e[1;36m  \___/  /_/\_\  \___/      \_/     |_| (_)  \___/  "
    
    echo ""
    
    echo -e "\n\t\e[0;37mC) CONFIGURACION"
    echo -e "\n\t\e[0;37mJ) JUGAR"
    echo -e "\n\t\e[0;37mE) ESTADISTICAS"
    echo -e "\n\t\e[0;37mS) SALIR"
    echo ""
	echo -n -e "\n\n\t\e[0;37mOXO.Introduzca una opción >>"
    read OPCION

    # Utilizamos la función MAYUSCULA para que si el usuario teclee la opcion
    # minuscula se pueda leer correctamente
    
    MAYUSCULAS

		case $OPCION in
			"C") #CONFIGURACION
				CONFIG
				CARGARCONFIG
				CONTINUAR
        		;;  
       		"J") #JUGAR
       			OXO_BOARD
			JUGAR
			array=("" "" "" "" "" "" "" "" "")
			FICHAS_J=3
			FICHAS_M=3
			SETS=0

			CONTINUAR
				;;
			"E") #ESTADISTICAS
       			ESTAD
       			CONTINUAR
       			;;
      		"S") #SAlIR                      
      			SALIR=true
      			CONTINUAR
      			clear
      			;;
      		*) #DEFAULT
      			echo -e "\n\e[1;31mERROR: Introduzca una opción valida (c,j,e,s)"
      			CONTINUAR
      			;;
      esac
      
	done
