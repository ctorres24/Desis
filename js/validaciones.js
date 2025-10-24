$(document).ready(function () {
    //Inicio 
    // Se Crear flags para prevenir loops en validaciones Debido a que en navegadores como Safari
    // el evento 'blur' puede dispararse múltiples veces si se generan alertas consecutivas.
    
    var validacionFlags = {
        enProceso: false,          
        alertaActiva: false,      
        ultimaValidacion: 0,       
        tiempoMinimo: 1000,         
        validacionesActivas: {}   
    };
    
    function puedeValidar(campo) {
        var ahora = Date.now();
        
        if (validacionFlags.enProceso || validacionFlags.alertaActiva) {
            return false;
        }
        
        if ((ahora - validacionFlags.ultimaValidacion) < validacionFlags.tiempoMinimo) {
            return false;
        }
        
        if (validacionFlags.validacionesActivas[campo]) {
            return false;
        }
        
        return true;
    }
    
    function iniciarValidacion(campo) {
        validacionFlags.enProceso = true;
        validacionFlags.validacionesActivas[campo] = true;
        validacionFlags.ultimaValidacion = Date.now();
    }
    
    function finalizarValidacion(campo, huboAlerta = false) {
        validacionFlags.enProceso = false;
        validacionFlags.validacionesActivas[campo] = false;
        
        if (huboAlerta) {
            validacionFlags.alertaActiva = true;
            setTimeout(function() {
                validacionFlags.alertaActiva = false;
            }, 2000);
        }
    }
    
    function resetearFlags() {
        validacionFlags.enProceso = false;
        validacionFlags.alertaActiva = false;
        validacionFlags.validacionesActivas = {};
        validacionFlags.ultimaValidacion = 0;
    }


    // Fin de las Flags Preventivas

    $('#bodega').change(function () {
        cambioSucursal();
    });

    $('#codigo').blur(function () {
        if (puedeValidar('codigo')) {
            iniciarValidacion('codigo');
            var resultado = validarCodigo();
            finalizarValidacion('codigo', !resultado);
        }
    });

    $('#nombre').blur(function () {
        if (puedeValidar('nombre')) {
            iniciarValidacion('nombre');
            var resultado = validarNombre();
            finalizarValidacion('nombre', !resultado);
        }
    });

    $('#precio').blur(function () {
        if (puedeValidar('precio')) {
            iniciarValidacion('precio');
            var resultado = validarPrecio();
            finalizarValidacion('precio', !resultado);
        }
    });

    $('#bodega').blur(function () {
        if (puedeValidar('bodega')) {
            iniciarValidacion('bodega');
            var resultado = validarBodega();
            finalizarValidacion('bodega', !resultado);
        }
    });

    $('#sucursal').blur(function () {
        if (puedeValidar('sucursal')) {
            iniciarValidacion('sucursal');
            var resultado = validarSucursal();
            finalizarValidacion('sucursal', !resultado);
        }
    });

    $('#modeda').blur(function () {
        if (puedeValidar('moneda')) {
            iniciarValidacion('moneda');
            var resultado = validarMoneda();
            finalizarValidacion('moneda', !resultado);
        }
    });

    $('#descripcion').blur(function () {
        if (puedeValidar('descripcion')) {
            iniciarValidacion('descripcion');
            var resultado = validarDescripcion();
            finalizarValidacion('descripcion', !resultado);
        }
    });

    $('form').submit(function (e) {
        resetearFlags();
        var codigoValido = validarCodigo();
        var nombreValido = validarNombre();
        var precioValido = validarPrecio();
        var materialesValidos = validarMateriales();
        var bodegaValida = validarBodega();
        var sucursalValida = validarSucursal();
        var monedaValida = validarMoneda();
        var descripcionValida = validarDescripcion();

        if (codigoValido && nombreValido && precioValido && materialesValidos && bodegaValida &&
            sucursalValida && monedaValida && descripcionValida) {
            enviarFormulario();
        }

        return false;
    });
});

function validarCodigo() {
    var codigo = $('#codigo').val().trim();

    if (codigo === '') {
        alert("El código del producto no puede estar en blanco.");
        return false;
    }

    if (codigo.length < 5 || codigo.length > 15) {
        alert("El código del producto debe tener entre 5 y 15 caracteres.");
        return false;
    }

    var regexCodigo = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$/;

    if (!regexCodigo.test(codigo)) {
        alert("El código del producto debe contener letras y números");
        return false;
    }

    var esUnico = true;
    $.ajax({
        type: 'POST',
        url: 'ajax/verificarCodigo.php',
        data: {
            codigo: codigo
        },
        async: false,
        success: function (response) {
            if (response.trim() === 'existe') {
                alert("El código del producto ya está registrado.");
                esUnico = false;
            }
        },
        error: function () {
            alert("Error al verificar el código. Intente nuevamente.");
            esUnico = false;
        }
    });

    return esUnico;
}

function validarNombre() {
    var nombre = $('#nombre').val().trim();

    if (nombre === '') {
        alert("El nombre del producto no puede estar en blanco.");
        return false;
    }

    if (nombre.length < 2 || nombre.length > 50) {
        alert("El nombre del producto debe tener entre 2 y 50 caracteres.");
        return false;
    }

    return true;
}

function validarPrecio() {
    var precio = $('#precio').val().trim();

    if (precio === '') {
        alert("El precio del producto no puede estar en blanco.");
        return false;
    }

    var regexPrecio = /^\d+(\.\d{1,2})?$/;

    if (!regexPrecio.test(precio) || parseFloat(precio) <= 0) {
        alert("El precio del producto debe ser un número positivo con hasta dos decimales.");
        return false;
    }

    return true;
}

function validarMateriales() {
    if ($('input[type="checkbox"]:checked').length < 2) {
        alert("Debe seleccionar al menos dos materiales para el producto.");
        return false;
    }

    return true;
}

function validarBodega() {
    var bodega = $('#bodega').val();

    if (bodega === '' || bodega === null) {
        alert("Debe seleccionar una bodega.");
        return false;
    }

    return true;
}

function validarSucursal() {
    var sucursal = $('#sucursal').val();

    if (sucursal === '' || sucursal === null) {
        alert("Debe seleccionar una sucursal para la bodega seleccionada.");
        return false;
    }

    return true;
}

function validarMoneda() {
    var moneda = $('#modeda').val();

    if (moneda === '' || moneda === null) {
        alert("Debe seleccionar una moneda para el producto.");
        return false;
    }

    return true;
}

function validarDescripcion() {
    var descripcion = $('#descripcion').val().trim();

    if (descripcion === '') {
        alert("La descripción del producto no puede estar en blanco.");
        return false;
    }

    if (descripcion.length < 10 || descripcion.length > 1000) {
        alert("La descripción del producto debe tener entre 10 y 1000 caracteres.");
        return false;
    }

    return true;
}

function enviarFormulario() {
    var materialesSeleccionados = [];
    $('input[type="checkbox"]:checked').each(function () {
        materialesSeleccionados.push($(this).val());
    });

    var datosFormulario = {
        codigo: $('#codigo').val().trim(),
        nombre: $('#nombre').val().trim(),
        bodega: $('#bodega').val(),
        sucursal: $('#sucursal').val(),
        moneda: $('#modeda').val(),
        precio: $('#precio').val().trim(),
        materiales: materialesSeleccionados,
        descripcion: $('#descripcion').val().trim()
    };

    $('.btn-guardar').prop('disabled', true).text('Guardando...');

    $.ajax({
        type: 'POST',
        url: 'ajax/guardarProducto.php',
        data: datosFormulario,
        dataType: 'json',
        success: function (response) {
            if (response.success) {
                alert("Producto guardado exitosamente.");
                limpiarFormulario();
            } else {
                alert("Error al guardar el producto: " + response.message);
            }
        },
        error: function (xhr, status, error) {
            alert("Error de conexión al servidor. Intente nuevamente.");
            console.log("Error AJAX: " + error);
        },
        complete: function () {
            $('.btn-guardar').prop('disabled', false).text('Guardar Producto');
        }
    });
}

function limpiarFormulario() {
    $('#codigo').val('');
    $('#nombre').val('');
    $('#bodega').val('');
    $('#sucursal').empty();
    $('#modeda').val('');
    $('#precio').val('');
    $('#descripcion').val('');
    $('input[type="checkbox"]').prop('checked', false);
}

function cambioSucursal() {
    var codigoBodega = $('#bodega').val();
    $.ajax({
        type: 'POST',
        url: 'ajax/consultarSucursal.php',
        data: {
            codigo: codigoBodega
        },
        success: function (response) {
            $('#sucursal').html(response);
        }
    });
}