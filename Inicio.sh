#!/bin/bash

# ROOT

bienvenida="Buenos días Midas, son las $(date +%I:%M), encantado de volver a verte. ¿Qué es lo que quieres hacer hoy?"
espeak="espeak -v mb/mb-es1 -s150"


# Comandos
if rfkill list bluetooth | grep -q "Soft blocked: yes"; then
    # echo "Bluetooth está deshabilitado. Habilitando Bluetooth..."
    rfkill unblock bluetooth
    sleep 3 # Pausa de 3 segundos
fi

# echo "Conectando al dispositivo Bluetooth con ID: 00:F6:20:E7:B0:88..."
sleep 3
bluetoothctl connect 00:F6:20:E7:B0:88
nohup keepassxc &
sleep 2 

# Comando para hablar
$espeak "$bienvenida"

# Función para crear ventana pop up
function popup {
    zenity --forms --title="$1" --text="Elige una opción:" --add-combo="Opciones" --combo-values="Youtube|Programación|IA"
}

# Crear ventana pop up con 3 botones
function popup {
    respuesta=$(zenity --forms --title="$1" --text="Elige una opción:" --add-combo="Opciones" --combo-values="Youtube|Programación|IA")

    if [[ "$respuesta" == "Youtube" ]]; then
        $espeak "Has elegido la opción Youtube"
    elif [[ "$respuesta" == "Programación" ]]; then
        $espeak "Así que vamos a programar... vale, abriré todo lo necesario"
        
        nohup code &
	    nohup vivaldi https://chat.openai.com/chat &

    elif [[ "$respuesta" == "IA" ]]; then
        $espeak "Has elegido la opción IA"
    else
        $espeak "Has cancelado la operación"
    fi
}

popup "Elige entre las opciones"
sleep 5

