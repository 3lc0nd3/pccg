<%@ page import="co.com.elramireza.pn.model.Texto" %>
<%@ page import="co.com.elramireza.pn.model.Empleado" %>
<%@ page import="co.com.elramireza.pn.model.Participante" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Texto pregunta1 = pnManager.getTexto(25);
    Texto pregunta2 = pnManager.getTexto(26);
    Texto pregunta3 = pnManager.getTexto(27);

    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Participante participante = pnManager.getParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());
%>

<div class="register">
    <div class="row">
        <div class="span6">
            <div class="formy">
                <a name="formPreguntas1"></a><h5>Preguntas</h5>
                <div class="form">
                    <!-- Login form (not working)-->
                    <form id="formPreguntas" class="form-inline">

                        <input id="idPnPremio" type="hidden" >

                        <!-- pregunta 1 -->
                        <div class="control-group">
                            <label class="control-label" for="pregunta1">
                                <%=pregunta1.getTexto1()%>
                            </label>
                            <div class="controls">
                                <%--<input type="text" class="input-large required" name="nombrePremio" id="nombrePremio">--%>
                                <textarea  class="input-xlarge required" id="pregunta1" name="pregunta1"></textarea>
                            </div>
                        </div>
                        <!-- pregunta 2 -->
                        <div class="control-group">
                            <label class="control-label" for="pregunta2">
                                <%=pregunta2.getTexto1()%>
                            </label>
                            <div class="controls">
                                <%--<input type="text" class="input-large required" name="nombrePremio" id="nombrePremio">--%>
                                <textarea  class="input-xlarge required" id="pregunta2" name="pregunta2"></textarea>
                            </div>
                        </div>
                        <!-- pregunta 1 -->
                        <div class="control-group">
                            <label class="control-label" for="pregunta3">
                                <%=pregunta3.getTexto1()%>
                            </label>
                            <div class="controls">
                                <%--<input type="text" class="input-large required" name="nombrePremio" id="nombrePremio">--%>
                                <textarea  class="input-xlarge required" id="pregunta3" name="pregunta3"></textarea>
                            </div>
                        </div>
                        <!-- Buttons -->
                        <div class="form-actions">
                            <!-- Buttons -->
                            <%--<button type="button" class="btn" onclick="registraP();">Registrar</button>--%>
                            <%--<input class="btn" type="submit" value=""/>--%>
                            <button id="b2" type="submit" class="btn">Enviar</button>
                            <%--<button type="reset" class="btn">Reset</button>--%>
                        </div>
                    </form>
                </div>
            </div>
            <br>
            <br>
        </div>
        <div class="span6">
            <h2>
                Respuestas
            </h2>
            <br>
            <b>Respuesta 1:</b>
            <br>
            <%=participante.getPregunta1()==null?"Sin respuesta":participante.getPregunta1()%>
            <br>
            <b>Respuesta 2:</b>
            <br>
            <%=participante.getPregunta2()==null?"Sin respuesta":participante.getPregunta2()%>
            <br>
            <b>Respuesta 3:</b>
            <br>
            <%=participante.getPregunta3()==null||participante.getPregunta3().equals("")?"Sin respuesta":participante.getPregunta3()%>
        </div>
    </div>
</div>

<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function responder(){
        pnRemoto.responderPreguntasP(
                dwr.util.getValue("pregunta1"),
                dwr.util.getValue("pregunta2"),
                dwr.util.getValue("pregunta3"),
                function(data){
                    location.reload(true);
                }
        );
    }

    jQuery(document).ready(function() {
        jQuery("#formPreguntas").validate({
            submitHandler: function() {
                responder();
            }
        });
    });

</script>