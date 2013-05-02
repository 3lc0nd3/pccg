<html>

<head>
    <script type='text/javascript' src='dwr/engine.js'></script>
    <script type='text/javascript' src='dwr/interface/pnRemoto.js'></script>
    <script type='text/javascript' src='dwr/interface/frontController.js'></script>
    <script type='text/javascript' src='dwr/util.js'></script>


    <script type="text/javascript">
        function subeArchivoInformePostula(){

//        pnRemoto.test("Hola");
            /*var o = jQuery("#fileInformePostulacionFile").val();
             if (o == '') {
             alert("Por favor seleccione un archivo");
             } else {
             var empresa = {
             fileInformePostulacionFile : null
             };
             dwr.util.getValues(empresa);*/
            var filee = dwr.util.getValue('fileInformePostulacionFile');
            alert("filee = " + filee);
            pnRemoto.subeArchivoPostula(filee);
            /*}*/
        }

    </script>
</head>
<body>

<%--<form id="registroP" class="form-horizontal" autocomplete="off">--%>
    <!-- informe de postulacion-->
    <label class="control-label" for="fileInformePostulacionFile">Informe de Postulaci&oacute;n PDF</label>

    <input type="file" id="fileInformePostulacionFile">
    <br>
    <input onclick="subeArchivoInformePostula();" type="button" value="enviar">
<%--</form>--%>
</body>
</html>