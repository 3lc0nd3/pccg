<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();
    Texto texto = pnManager.getTexto(1);
%>

<individual>
    <div id="contenedor" class="container">
        <div class="row">
            <div class="span6">
                <h2>Equipo asistente a Formaci&oacute;n Empresarial</h2>
                <h4><%=texto.getTexto1()%></h4>
                <p class="big grey">
                    <%=texto.getTexto2()%>
                </p>
            <span style="text-align:justify;">
                <%=texto.getTexto3()%>
            </span>

            </div>
            <div class="span6">
                <div class="formy">
                    <div class="form">
                        <!-- Register form (not working)-->
                        <form id="registroEvaluador" class="form-horizontal" autocomplete="off">
                            <h5>Desea agregar personas a su equipo?</h5>

                            <!-- Documento de Identidad Aspirante-->
                            <div class="control-group">
                                <label class="control-label" for="documentoAspirante">Documento Identidad</label>
                                <div class="controls">
                                    <input type="text" class="input-large required" id="documentoAspirante" name="documentoAspirante">
                                </div>
                            </div>

                            <!-- Nombre Aspirante-->
                            <div class="control-group">
                                <label class="control-label" for="nombreAspirante">Nombre</label>
                                <div class="controls">
                                    <input type="text" class="input-large required" id="nombreAspirante" name="nombreAspirante">
                                </div>
                            </div>

                            <!-- Apellido Aspirante-->
                            <div class="control-group">
                                <label class="control-label" for="apellidoAspirante">Apellido</label>
                                <div class="controls">
                                    <input type="text" class="input-large required" id="apellidoAspirante" name="apellidoAspirante">
                                </div>
                            </div>

                            <!-- departamento -->
                            <div class="control-group">
                                <label class="control-label" for="departamento">Departamento</label>
                                <div class="controls">
                                    <select id="departamento" onchange="changeEstado();">
                                        <%
                                            for (LocEstado estado: pnManager.getLocEstados()){
                                        %>
                                        <option value="<%=estado.getIdEstado()%>"><%=estado.getNombreEstado()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>

                            <!-- Ciudad -->
                            <div class="control-group">
                                <label class="control-label" for="locCiudadPersona">Ciudad</label>
                                <div class="controls">
                                    <select id="locCiudadPersona"  name="locCiudadPersona" ><%--***********--%>
                                        <option value="0">Seleccione...</option>
                                    </select>
                                </div>
                            </div>

                            <!-- TElefono Aspirante-->
                            <div class="control-group">
                                <label class="control-label" for="telefonoAspirante">Tel&eacute;fono Directo</label>
                                <div class="controls">
                                    <input type="text" class="input-large required" id="telefonoAspirante" name="telefonoAspirante">
                                </div>
                            </div>

                            <!-- telMovilAspirante-->
                            <div class="control-group">
                                <label class="control-label" for="telMovilAspirante">Tel&eacute;fono M&oacute;vil</label>
                                <div class="controls">
                                    <input type="text" class="input-large required digits" id="telMovilAspirante" name="telMovilAspirante" maxlength="10" min="3000000000">
                                </div>
                            </div>

                            <!-- Email Aspirante-->
                            <div class="control-group">
                                <label class="control-label" for="emailCorpAspirante">Email Corporativo</label>
                                <div class="controls">
                                    <input type="text" class="input-large required email" id="emailCorpAspirante" name="emailCorpAspirante">
                                </div>
                            </div>

                            <!-- Email Personal Aspirante-->
                            <div class="control-group">
                                <label class="control-label" for="emailPersonalAspirante">Email Personal</label>
                                <div class="controls">
                                    <input type="text" class="input-large required email" id="emailPersonalAspirante" name="email-Personal-Aspirante">
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="form-actions">
                                <!-- Buttons -->
                                <%--<button type="button" class="btn" onclick="registraP();">Registrar</button>--%>
                                <%--<input class="btn" type="submit" value=""/>--%>
                                <button id="b3" type="submit" class="btn">Registrar</button>
                                <%--<button type="reset" class="btn">Reset</button>--%>
                            </div>
                        </form>
                        <%--Already have an Account? <a href="login.html">Login</a>--%>
                    </div> <%--  END DIV FORM  --%>
                </div><%--  END FORMY  --%>
            </div>
        </div>  <%--  END ROW  --%>
        <div class="row">
            <div class="span12">
                <table cellpadding="0" cellspacing="0" border="0" class="display" id="miembros">
                    <thead>
                    <tr>
                        <th> Doc. </th>
                        <th> Nombre </th>
                        <th> Apellido </th>
                        <th> Emails</th>
                        <%--<th> Email Personal</th>--%>
                        <th> Tel&eacute;fonos </th>
                        <%--<th> Celular </th>--%>
                        <th> Perfil </th>
                        <th width="28"> Eliminar</th>
                    </tr>
                    </thead>
                    <%

                        List<Empleado> empleadosEquipo = pnManager.getEmpleadosFormacionEquipo(
                                empleo.getParticipanteByIdParticipante().getIdParticipante());

                        String imageActive;
                        String messaActive;
                        for (Empleado empleadoEquipo: empleadosEquipo){
                            Persona persona = empleadoEquipo.getPersonaByIdPersona();
                            if(persona.getEstado()){
                                imageActive = "img/positive.png";
                                messaActive = "Desactivar?";
                            } else {
                                imageActive = "img/negative.png";
                                messaActive = "Activar?";
                            }
                    %>
                    <tr>
                        <td> <%=persona.getDocumentoIdentidad() %></td>
                        <td> <%=persona.getNombrePersona() %></td>
                        <td> <%=persona.getApellido() %></td>
                        <td>
                            <%=persona.getEmailPersonal()!=null?persona.getEmailPersonal():"" %>
                            <br>
                            <%=persona.getEmailCorporativo() %>
                        </td>
                        <td>
                            <%=persona.getCelular()!=null?persona.getCelular():""%>
                            <br>
                            <%=persona.getTelefonoFijo() %>
                        </td>
                        <%--<td><img id="imgActivePersona<%=persona.getIdPersona()%>" width="28" onclick="activaDesactiva(<%=persona.getIdPersona()%>);" src="<%=imageActive%>" alt="<%=messaActive%>" title="<%=messaActive%>"></td>--%>
                        <td>
                            <%=empleadoEquipo.getPerfilByIdPerfil().getPerfil()%>
                        </td>
                        <td>
                            <%
                                if(persona.getIdPersona() != empleo.getPersonaByIdPersona().getIdPersona()){
                            %>
                            <img width="36" onclick="desvincule(<%=empleadoEquipo.getIdEmpleado()%>);" src="img/stop.png" alt="edita" title="edita">
                            <%
                                }
                            %>
                        </td>
                        <%--<td> <%=persona.getLocCiudadByIdCiudad().getNombreCiudad() %></td>--%>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </div>
    </div>
</individual>








<jsp:include page="c_footer_r.jsp"/>


<script type="text/javascript">
    jQuery.validator.addMethod("selectNoZero", function(value, element, arg){
        return "0" != value;
    }, jQuery.validator.messages.required);

    jQuery(document).ready(function() {
        jQuery("#registroEvaluador").validate({
            submitHandler: function() {
                registraEvaluador();
            },
            rules: {
                locCiudadPersona:   "selectNoZero"
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
            emailPersonalAspirante : null,
            locCiudadPersona : null
        };
        dwr.util.getValues(aspirante);
//        alert("aspirante.locCiudadPersona = " + aspirante.locCiudadPersona);
        var personaAspirante = {
            documentoIdentidad : aspirante.documentoAspirante,
            nombrePersona : aspirante.nombreAspirante,
            apellido : aspirante.apellidoAspirante,
            telefonoFijo : aspirante.telefonoAspirante,
            celular : aspirante.telMovilAspirante,
            emailCorporativo : aspirante.emailCorpAspirante,
            emailPersonal : aspirante.emailPersonalAspirante,
            locCiudadPersona : aspirante.locCiudadPersona
        };

        pnRemoto.registroAspirante(personaAspirante, 11, <%=empleo.getParticipanteByIdParticipante().getIdParticipante()%>, function(data){
            if(data==1){
                alert("Gracias por su registro");
                window.location = "equipoFormacionEmpresa.htm";
                enableId("b3");
            } else {
                alert("Problemas !");
                enableId("b3");
            }
        });

    }

    function desvincule(idEmpleado){
        if(confirm("Desea eliminar este miembro del equipo?")){
            pnRemoto.desvinculaEmpleado(idEmpleado, function(data){
                if(data == ''){
                    alert("Desvinculado Completo");
                    window.location = "equipoFormacionEmpresa.htm";
                } else {
                    alert("Problemas ! " + data);
                }
            });
        }
    }


    function changeEstado(){
        dwr.util.removeAllOptions("locCiudadPersona");
        var idEstado = dwr.util.getValue("departamento");
        pnRemoto.getLocCiudadesFromEstado(idEstado, function(data){
            dwr.util.addOptions("locCiudadPersona", data, "idCiudad", "nombreCiudad");
        });
    }
</script>