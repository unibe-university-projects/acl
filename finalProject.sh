#!/bin/sh

limpiarDirectorios() {
    cd /
    rm -rf so
    echo "  Directorios limpiados"
}

crearDirectorios() {
    local directorio="$1"
    shift
    local subdirectorios="$@"

    cd /
    mkdir -p "so/proyectos/$directorio"
    cd "so/proyectos/$directorio"

    for subdir in $subdirectorios; do
        mkdir -p "$subdir"
        cd "$subdir"
        i=1
        while [ $i -le 3 ]; do
            echo "$subdir $i" >"${subdir}${i}.txt"
            i=$((i + 1))
        done
        cd ..
    done

    cd /
    echo "  Estructura de carpetas creada con exito!"
}

echo "Iniciando proyecto ..."
limpiarDirectorios

crearDirectorios "servicios" "autenticacion ventas inventario perfil_usuario"
crearDirectorios "front" "webapp ios"
crearDirectorios "data" "modelo_sugerencias"
# crearDirectorios "data22" "modelo_sugerencias22"