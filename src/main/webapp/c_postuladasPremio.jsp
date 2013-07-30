<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Integer idPremio = (Integer) request.getAttribute("idPremio");
    boolean excel = false;
    if (idPremio == null) {
        idPremio = Integer.parseInt(request.getParameter("idPremio"));
        excel = true;
    }

    PnPremio premio = pnManager.getPnPremio(idPremio);
    if (excel) {

        SimpleDateFormat dfL = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String nombre = "postuladas_"+premio.getNombrePremio()+"_"+dfL.format(new Date())+".xls";

        response.setContentType( "application/x-download" );
        response.setHeader("Content-type","application/vnd.ms-excel");
        response.setHeader("Content-Disposition","attachment; filename=\""+ nombre + "\"");
    } else {
%>
<A href="http://www.pccg.com.co/app/c_postuladasPremio.jsp?idPremio=<%=idPremio%>">
    Exportar a Excel <img src="img/excel.png" width="36" alt="Exportar">
</A>
<br>

<%
    }



    List<Participante> participantes = pnManager.getParticipantesFromPremio(idPremio);



%>
<b>Premio</b>
<h2><%=premio.getNombrePremio()%></h2>
<br>
<h3>Empresas Postuladas</h3>
<br>
<table border="1" width="90%">
    <tr>
        <th>Ciudad</th>
        <th> Nit. </th>
        <th> Nombre </th>
        <th> Direcci&oacute;n </th>
        <th> Emails</th>
        <%--<th> Email Personal</th>--%>
        <th> Tel&eacute;fonos </th>
        <%--<th> Celular </th>--%>
        <th> Fecha de Registro</th>
        <th width="28"> Opciones</th>
    </tr>
<%
    for (Participante participante : participantes){
        Empresa empresa = participante.getEmpresaByIdEmpresa();
%>
    <tr>
        <td><%=empresa.getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <td><%=empresa.getNit()%></td>
        <td><%=empresa.getNombreEmpresa()%></td>
        <td><%=empresa.getDireccionEmpresa()%></td>
        <td>
            <%=empresa.getEmailEmpresa()%>
        </td>
        <td>
            <%=empresa.getTelMovilEmpresa()%>
            <br>
            <%=empresa.getTelFijoEmpresa() %>
        </td>
        <td><%=empresa.getFechaCreacion()%></td>
        <td></td>
    </tr>
<%
    }
%>
</table>
<br>