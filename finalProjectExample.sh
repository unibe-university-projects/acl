#!/bin/bash

limpiarDirectorios(){
    cd /
    rm -rf so
    echo "  Directorios limpiados"
}

limpiarUsuariosGrupos(){
    userdel david
    userdel nathy

    groupdel data-scientist
    echo "  Usuarios y grupos limpiados"
}

crearDirectorios(){
    cd /
    mkdir  so
    cd so
    mkdir proyectos
    cd proyectos
    mkdir data
    cd data
    mkdir modelo_sugerencias
    cd modelo_sugerencias
    echo "archivo 1" > archivo1.txt
    echo "archivo 2" > archivo2.txt
    echo "archivo 3" > archivo3.txt

    # Esta función debe retornarnos a HOME
    echo "  Estructura de carpetas creada con exito!"
}

crearUsuariosGrupos(){
    groupadd data-scientist
    useradd -g data-scientist -s /bin/bash david  
    useradd -g data-scientist -s /bin/bash nathy
    echo "nathy:nat" | chpasswd
    echo "david:000" | chpasswd
    
    echo "  Usuarios y grupos creados"
}

asignarGruposPropietarios(){
    cd /so
    chown -R david:data-scientist proyectos/data
} 

asignarPermisos(){
    chmod -R ug=rwx proyectos/data
    chmod -R o=r proyectos/data
}

echo "Iniciando proyecto ..."
limpiarDirectorios
limpiarUsuariosGrupos

crearDirectorios
crearUsuariosGrupos
asignarGruposPropietarios
asignarPermisos