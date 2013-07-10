<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%

    Persona persona = (Persona) session.getAttribute("persona");
    Empleado empleo = (Empleado) session.getAttribute("empleo");

    Texto texto = pnManager.getTexto(1);
    PnPremio premioActivo = pnManager.getPnPremioActivo();

    String mensajeLogin = (String) request.getAttribute("mensajeLogin");
    if (mensajeLogin == null) {
        mensajeLogin = "";
    }

    System.out.println("empleo = " + empleo);
    System.out.println("persona = " + persona);
%>

<%
    if (persona == null) {
%>
<%--<jsp:include page="c_slider01.jsp"/>--%>
<%
    }
%>
<%--  LOGIN  --%>
<div class="register">
    <div class="row">
        <div class="span6">
            <%
                if(mensajeLogin.length()!=0){
            %>
            <div class="alert">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                <%=mensajeLogin%>
            </div>
            <%
                }
                if(persona == null){  //  NO HAY PERSONA
            %>
            <jsp:include page="c_login.jsp"/>
            <%
                } else { // SI HAY PERSONA
                    Texto selPerfil = pnManager.getTexto(14);
                    if(empleo==null){ // NO HAY EMPLEO, TOCA SELECCIONAR UNO



            %>
            <h3 class="color"><%=selPerfil.getTexto1()%>:</h3>
            <%
                        List<Empleado> empleos = pnManager.getEmpleosFromPersona(persona.getIdPersona());
                        if(empleos.size()>0){

                            for (Empleado empleado: empleos){
            %>
            <br>
            <span style="margin-top:20px; margin-bottom:10px;">
                <button id="b<%=empleado.getIdEmpleado()%>" type="button" onclick="selEmpleoB(<%=empleado.getIdEmpleado()%>);" class="btn btn-primary">
                    <%=empleado.getPerfilByIdPerfil().getPerfil()%>
                    en
                    <%=empleado.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getNombrePremio()%>
                    -
                    <%=empleado.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getNombreEmpresa()%>
                </button>
            </span>
            <%
                            }
                        } else { // NO TIENE UN EMPLEO
            %>
            <div class="warning">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                No tiene un perfil
            </div>
            <%
                        }
                    } else { // SI TIENE EMPLEO
            %>

            <H3 CLASS="color">
                <%=selPerfil.getTexto2()%>
            </H3>

            <span style="font-size:large;">
                <%=persona.getNombreCompleto()%>
                <br>
                <strong><%=empleo.getPerfilByIdPerfil().getPerfil()%></strong>
                <br>
                en: <%=empleo.getParticipanteByIdParticipante().getPnPremioByIdConvocatoria().getNombrePremio()%>
                <br>
                <%=empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getNombreEmpresa()%>
            </span>
            <br>

            <form id="cambiarPerfilF" action="index.htm" method="post">
                <input type="hidden" name="cambiarPerfil" value="1">
            </form>
            <button type="button" onclick="cambiarPerfil();" class="btn btn-primary">Cambiar el Perfil</button>
            <br>
            <br>
              <%--  ESPACIO PARA PONER INFO DE LA EMPRESA PARTICIPANTE  --%>
            <jsp:include page="c_empresa_admon.jsp"    />

            <%
                    } // FIN SELECCIONA EMPLEO
                } // FIN SI HAY PERSONA
            %>
        </div>

        <div class="span6">
            <h2><%=texto.getTexto1()%></h2>
            <p class="big grey">
                <%=texto.getTexto2()%>
            </p>
            <span style="text-align:justify;">
                <%=texto.getTexto3()%>
            </span>

        </div>
    </div>
</div>

<%--  END LOGIN  --%>


<%--  REGISTER  --%>
<%
    if(premioActivo !=null && persona== null){ // SI HAY UN PnPREMIO ACTIVO
%>


<div class="border"></div>
<%
    }  /* END IF HAY UN PREMIO PN ACTIVO */
%>
<%
    if(persona == null){ // SOLO SI NO HAY PERSONA

%>
<div class="row">
    <div class="span12" style="text-align: center">
        <A name="registro"></A>
        <h2>REGISTRO EN EL SISTEMA</h2>
        <br>
        <br>
    </div>
</div>
<div class="row">
    <div class="span4" style="text-align: center">
        <a href="registroEvaluador.htm" class="btn btn-primary" style="color: #ffffff; font-weight: bold">Registro Aspirante a <br>Evaluador</a>
    </div>
    <div class="span4" style="text-align: center">
        <a href="formacionEmpresa.htm" class="btn btn-primary" style="color: #ffffff; font-weight: bold">Inscripci&oacute;n a Formaci&oacute;n<br>Empresa</a>
    </div>
    <div class="span4" style="text-align: center">
        <a href="formacionPersona.htm" class="btn btn-primary" style="color: #ffffff; font-weight: bold">Inscripci&oacute;n a Formaci&oacute;n<br>Persona</a>
    </div>
</div>

<%
    } // FIN REGISTRA EVALUADOR
%>

<%--  END REGISTER  --%>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function changeEstado(){
        dwr.util.removeAllOptions("locCiudadEmpresa");
        var idEstado = dwr.util.getValue("departamento");
        pnRemoto.getLocCiudadesFromEstado(idEstado, function(data){
            dwr.util.addOptions("locCiudadEmpresa", data, "idCiudad", "nombreCiudad");
        });
    }

    function revisaNit(){
        var nit = dwr.util.getValue("nit");
        pnRemoto.getEmpresaFromNit(nit, function(data){
            if(data!= null){
                dwr.util.setValues(data);
                dwr.util.setValue("departamento", data.locCiudadByIdCiudad.locEstadoByIdEstado.idEstado);
                dwr.util.setValue("locCiudadEmpresa", data.locCiudadByIdCiudad.idCiudad);
                dwr.util.setValue("idEmpresaCategoria",         data.empresaCategoriaByIdCategoriaEmpresa.id);
                dwr.util.setValue("idEmpresaCategoriaTamano",   data.empresaCategoriaTamanoByIdCategoriaTamanoEmpresa.id);
            }
        });
    }

    function registraP(){
//        disableId("b2");
//        alert("Si o no");
        var empresa = {
            nit : null,
            nombreEmpresa : null,
            locCiudadEmpresa : null,
            direccionEmpresa : null,
            telFijoEmpresa : null,
            telMovilEmpresa : null,
            emailEmpresa : null,
            webEmpresa : null,
            actividadPrincipal : null,
            productos : null,
            marcas : null,
            alcanceMercado : null,
            empleados : null,
            valorActivos : null,
            idEmpresaCategoria : null,
            idEmpresaCategoriaTamano : null,
            publicaEmpresa : null/*,
            fileInformePostulacionFile : null,
            fileCertificadoConstitucionFile : null,
            fileEstadoFinancieroFile : null,
            fileConsignacionFile : null*/
        };
        dwr.util.getValues(empresa);

//        alert("empresa.nombre = " + empresa.nombreEmpresa);

        var directivo = {
            documentoDirectivo : null,
            nombreDirectivo : null,
            apellidoDirectivo : null,
            telefonoDirectivo : null,
            telMovilDirectivo : null,
            emailDirectivo : null
        };
        dwr.util.getValues(directivo);

        var encargado = {
            documentoEmpleado : null,
            nombreEmpleado : null,
            apellidoEmpleado : null,
            telefonoEmpleado : null,
            telMovilEmpleado : null,
            emailCorpEmpleado : null,
            emailPersonalEmpleado : null,
            idCargoEmpleado : null
        };
        dwr.util.getValues(encargado);
//        alert("encargado.idCargoEmpleado = " + encargado.idCargoEmpleado);

        var personaDirectivo = {
            documentoIdentidad : directivo.documentoDirectivo,
            nombrePersona : directivo.nombreDirectivo,
            apellido : directivo.apellidoDirectivo,
            telefonoFijo : directivo.telefonoDirectivo,
            celular : directivo.telMovilDirectivo,
            emailCorporativo : directivo.emailDirectivo
        };

        var personaEncargado = {
            documentoIdentidad : encargado.documentoEmpleado,
            nombrePersona : encargado.nombreEmpleado,
            apellido : encargado.apellidoEmpleado,
            telefonoFijo : encargado.telefonoEmpleado,
            celular : encargado.telMovilEmpleado,
            emailCorporativo : encargado.emailCorpEmpleado,
            emailPersonal : encargado.emailPersonalEmpleado,
            idCargoEmpleado : encargado.idCargoEmpleado
        };

        pnRemoto.saveInscrito(empresa, personaDirectivo, personaEncargado,
                function(data){
                    if(data == 1){
                        var formCS = dwr.util.byId("registroP");
                        formCS.reset();
                        alert("Gracias por su registro. Por favor revise su correo: "+
                                personaEncargado.emailPersonal);
                    }
                });

//        alert("personaDirectivo.documentoIdentidad = " + personaDirectivo.documentoIdentidad);
    }

    function cambiarPerfil(){
        dwr.util.byId("cambiarPerfilF").submit();
    }

    function selEmpleoB(idEmpleo){
//        disableId('b'+idEmpleo);
//        var bTmp = dwr.util.byId('b'+idEmpleo);
//        alert("bTmp = " + bTmp);

        pnRemoto.selEmpleo(idEmpleo, function(data){
            if(data!=null){
//                alert("Vamos con: " + data.perfilByIdPerfil.perfil);
//                enableId("b2");
                window.location = "index.htm";
            } else {
                alert('Problemas !');
                enableId("b2");
            }
        });
    }

    jQuery.validator.addMethod("fieldDiff", function(value, element, arg){
        return arg != value;
    }, jQuery.validator.messages.required);

    jQuery.validator.addMethod("selectNoZero", function(value, element, arg){
        return "0" != value;
    }, jQuery.validator.messages.required);

    jQuery.validator.addMethod("money", function (value, element) {
        return this.optional(element) || /^((\d{1,5})+\.\d{2})?$|^\$?[\.]([\d][\d]?)$/.test(value);
    }, 'Moneda' );

    jQuery(document).ready(function() {
        jQuery("#registroP").validate({
            submitHandler: function() {
                registraP();
            },
            rules: {
                locCiudadEmpresa:   "selectNoZero",
                alcanceMercado:     "selectNoZero",
                idEmpresaCategoria: "selectNoZero",
                idEmpresaCategoriaTamano: "selectNoZero",
                publicaEmpresa: "selectNoZero",
                idCargoEmpleado: "selectNoZero"/*,
                valorActivos: "money"*/
            }
        });
    });

    jQuery(document).ready(function() {
        jQuery("#registroEvaluador").validate({
            submitHandler: function() {
                registraEvaluador();
            }
        });
    });

    function registraEvaluador(){
        disableId("b3");
        var aspirante = {
            documentoAspirante : null,
            nombreAspirante : null,
            apellidoAspirante : null,
            telefonoAspirante : null,
            telMovilAspirante : null,
            emailCorpAspirante : null,
            emailPersonalAspirante : null
        };
        dwr.util.getValues(aspirante);

        var personaAspirante = {
            documentoIdentidad : aspirante.documentoAspirante,
            nombrePersona : aspirante.nombreAspirante,
            apellido : aspirante.apellidoAspirante,
            telefonoFijo : aspirante.telefonoAspirante,
            celular : aspirante.telMovilAspirante,
            emailCorporativo : aspirante.emailCorpAspirante,
            emailPersonal : aspirante.emailPersonalAspirante
        };

//        alert("personaAspirante.nombrePersona = " + personaAspirante.nombrePersona);
//        alert("personaAspirante.apellido = " + personaAspirante.apellido);

        pnRemoto.registroAspirante(personaAspirante, function(data){
            if(data==1){
                var formCS = dwr.util.byId("registroEvaluador");
                formCS.reset();
                alert("Gracias por su registro");
                enableId("b3");
            } else {
                alert("Problemas !");
                enableId("b3");
            }
        });

    }

    /*jQuery.validator.setDefaults({
        submitHandler: function() {
            registraP();
        }
    });*/

    $('#username').focus();
</script>