<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%

    int idParticipante;

    String id = request.getParameter("id");
    if (id == null) { // NO VIENE DE FRONT
        idParticipante = (Integer) request.getAttribute("id");
    } else {
        idParticipante = Integer.parseInt(id);
    }
//    System.out.println("id PArticipante = " + idParticipante);

    Participante participante = pnManager.getParticipante(idParticipante);

    Empresa empresa = participante.getEmpresaByIdEmpresa();

    List<PnRetroalimentacion> retros = pnManager.getPnRetroalimentaciones(
            participante.getIdParticipante()
    );

//    System.out.println("retros.size() = " + retros.size());
%>

                <h2>Informe de Retroalimentaci&oacute;n</h2>
                para <strong><%=empresa.getNombreEmpresa()%></strong>

                <%
                    if(retros.size()==0){
                %>
                <%--<div class="alert">--%>
                    <%--<button type="button" class="close" data-dismiss="alert">&times;</button>--%>
                    <%--no hay valores--%>
                <%--</div>--%>
                <%
                    } else {
                %>

                <%--<div class="alert alert-success">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    Datos ingresados el <%=pnManager.dfDateTime.format(retros.get(0).getFechaCreacion())%>
                </div>--%>
                <br>
                <%
                    }
                %>
                <table border="1" width="100%" align="center">
                <%
                    for (PnRetroalimentacion retro : retros){
                %>
                    <tr>
                        <th>
                            <%=retro.getPnCapituloByIdPnCapitulo().getNombreCapitulo()%>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <strong>Fortalezas</strong>
                            <br>
                            <%=retro.getFortalezas().replace("\n", "<br>")%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Oportunidades</strong>
                            <br>
                            <%=retro.getOportunidades().replace("\n", "<br>")%>
                        </td>
                    </tr>
                <%
                    }
                %>
                </table>



<jsp:include page="c_footer_r.jsp"/>