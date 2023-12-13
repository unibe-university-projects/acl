#!/bin/sh

limpiarDirectorios() {
    cd /
    rm -rf so
    echo "  Directorios limpiados"
}

limpiarUsuariosGrupos(){
    userdel juan
    userdel pedro
    userdel lucas
    userdel lizz

    userdel claire
    userdel andres

    userdel jimmy

    userdel nathy
    userdel david

    groupdel backend-dev
    groupdel web-dev
    groupdel ios-dev
    groupdel data-scientist
    echo "  Usuarios y grupos limpiados"
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

crearGrupo() {
    local nombre_grupo="$1"
    groupadd "$nombre_grupo"
    echo "  Grupo '$nombre_grupo' creado"
}

crearUsuario() {
    local nombre_usuario="$1"
    local grupo="$2"
    local password="$3"
    
    useradd -g "$grupo" -s /bin/bash "$nombre_usuario"
    
    # Verificar si se proporciona una contraseña antes de ejecutar chpasswd
    if [ -n "$password" ]; then
        echo "$nombre_usuario:$password" | chpasswd
        echo "  Usuario '$nombre_usuario' creado en el grupo '$grupo' con contraseña"
    else
        echo "  Usuario '$nombre_usuario' creado en el grupo '$grupo' sin contraseña"
    fi
}

crearUsuariosGrupos() {
    crearGrupo "backend-dev"
    crearGrupo "web-dev"
    crearGrupo "ios-dev"
    crearGrupo "data-scientist"

    crearUsuario "juan" "backend-dev" "12345"
    crearUsuario "pedro" "backend-dev" "12345"
    crearUsuario "lucas" "backend-dev" "12345"
    crearUsuario "lizz" "backend-dev" "12345"

    crearUsuario "claire" "web-dev" "12345"
    crearUsuario "andres" "web-dev" "12345"

    crearUsuario "jimmy" "ios-dev" "12345"

    crearUsuario "david" "data-scientist" "12345"
    crearUsuario "nathy" "data-scientist" "12345"
}

asignarGruposPropietarios(){
    cd /so
    chown -R juan:backend-dev proyectos/servicios
    chown -R claire:web-dev proyectos/front/webapp
    chown -R jimmy:ios-dev proyectos/front/ios
    chown -R david:data-scientist proyectos/data
} 

asignarPermisos(){
    chmod -R ug=rwx proyectos/servicios
    chmod -R o=rx proyectos/servicios

    chmod -R ug=rwx proyectos/front/webapp
    chmod -R o=rx proyectos/front/webapp

    chmod -R ug=rwx proyectos/front/ios
    chmod -R o=rx proyectos/front/ios

    chmod -R ug=rwx proyectos/data
    chmod -R o=r proyectos/data
}

echo "Iniciando proyecto ..."
limpiarDirectorios
limpiarUsuariosGrupos

crearDirectorios "servicios" "autenticacion ventas inventario perfil_usuario"
crearDirectorios "front" "webapp ios"
crearDirectorios "data" "modelo_sugerencias"
echo "Iniciando creación de usuarios y grupos ..."
crearUsuariosGrupos
asignarGruposPropietarios
asignarPermisos
# crearUsuariosGrupos
# crearDirectorios "data22" "modelo_sugerencias22"