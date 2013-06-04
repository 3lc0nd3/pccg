<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%

    Persona persona = (Persona) session.getAttribute("persona");
    Empleado empleo = (Empleado) session.getAttribute("empleo");

    Texto texto = pnManager.getTexto(1);
%>

<div class="register">
    <div class="row">
        <div class="span6">
            <h2>Registro Formaci&oacute; para Persona</h2>
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
                        <h5>Datos de la Persona a Formar</h5>

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

                        <div class="control-group">
                            <div class="controls">
                                <label class="checkbox inline">
                                    <input type="checkbox" id="inlineCheckboxEval" name="inlineCheckboxEval" class="required" value="agree">
                                    Acepto T&eacute;rminos y Condiciones
                                </label>
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
    </div>
</div>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

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
</script>