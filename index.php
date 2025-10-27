<?php
    include 'config/conexion.php';
?>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8" />
    <title>Desis</title>
    <link rel="stylesheet" href="css/styles.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
    <form>

        <div class="tarjeta">
            <div class="titulo">Formulario de Producto</div>
            <div class="cuerpo">
                <div class="formulario-inline">
                    <div class="campo">
                        <label for="codigo">Codigo</label>
                        <input type="text" id="codigo" name="codigo" style="width: 300px;">


                    </div>
                    <div class="campo">
                        <label for="nombre">Nombre</label>
                        <input type="text" id="nombre" name="nombre" style="width: 300px;">
                    </div>
                </div>
                <div class="formulario-inline">
                    <div class="campo">
                        <label for="bodega">Bodega</label>
                        <select name="bodega" id="bodega" style="width: 318px;">
                            <option value=""></option>
                            <?php
                                $sql = "SELECT codigo, nombre FROM bodega";
                                $result = mysqli_query($conexion, $sql);

                                if (mysqli_num_rows($result) > 0) {
                                    while($row = mysqli_fetch_assoc($result)) {
                                        echo "<option value='" . $row["codigo"] . "'>" . $row["nombre"] . "</option>";
                                    }
                                }

                            ?>
                        </select>
                    </div>
                    <div class="campo">
                        <label for="sucursal">Sucursal</label>
                        <select name="sucursal" id="sucursal" style="width: 318px;">
                        </select>
                    </div>
                </div>

                <div class="formulario-inline">
                    <div class="campo">
                        <label for="modeda">Modeda</label>
                        <select name="modeda" id="modeda" style="width: 318px;">
                            <?php
                                $sql = "SELECT codigo, nombre FROM moneda";
                                $result = mysqli_query($conexion, $sql);
                                echo "<option value=''></option>";
                                if (mysqli_num_rows($result) > 0) {
                                    while($row = mysqli_fetch_assoc($result)) {
                                        echo "<option value='" . $row["codigo"] . "'>" . $row["nombre"] . "</option>";
                                    }
                                }

                            ?>
                        </select>
                    </div>

                    <div class="campo">
                        <label for="precio">Precio</label>
                        <input type="text" id="precio" name="precio" style="width: 300px;">
                    </div>
                </div>

                <div class="materiales-section">
                    <label for="materiales-section" style="font-weight: bold">Material del Producto</label><br>
                    <?php
                        $sql = "SELECT codigo, nombre FROM materiales";
                        $result = mysqli_query($conexion, $sql);

                        if (mysqli_num_rows($result) > 0) {
                            while($row = mysqli_fetch_assoc($result)) {
                                echo "<input type='checkbox' id='" . $row["codigo"] . "' name='" . $row["codigo"] . "' value='" . $row["codigo"] . "'>";
                                echo "<label for='" . $row["codigo"] . "'> " . ucfirst($row["nombre"]) . "</label>";
                                
                            }
                        }
                    ?>
                </div>



                <div class="campo">

                    <label for="descripcion">Descripción</label>
                    <textarea name="descripcion" id="descripcion" cols="30" rows="10"></textarea>
                </div>


            </div>
            <div class="pie">
                <div class="campo">
                    <button type="submit" class="btn-guardar">Guardar Producto</button>
                </div>
            </div>
        </div>
    </form>
    <!-- Incluyendo el archivo de validaciones con eventos 'blur' -->
    <!-- <script src="js/validaciones.js"></script> -->

    <!-- Incluyendo el archivo de validaciones con eventos 'change' -->
    <script src="js/validacionesChange.js"></script>
</body>

</html>
   
