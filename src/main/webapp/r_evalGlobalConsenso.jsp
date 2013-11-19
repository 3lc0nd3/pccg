<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />


<%
//    System.out.println("Dentro del jsp");

    int idParticipante;

    String id = request.getParameter("id");
//    System.out.println("id Parameter = " + id);
    String nombre = "";
    if (id == null) { // NO VIENE DE FRONT
        idParticipante = (Integer) request.getAttribute("id");
    } else {
        idParticipante = Integer.parseInt(id);
    }
    nombre      = (String)  request.getAttribute("nombre");
//    System.out.println("nombre2222 = " + nombre);

//    System.out.println("idParticipante = " + idParticipante);

    Empleado empleado = pnManager.getLiderFromParticipante(idParticipante);

    List<PnValoracion> fromParticipante = pnManager.getValoracionConsensoGlobalFromEmpleado(
            empleado.getIdEmpleado());
//    System.out.println("fromParticipante.size() = " + fromParticipante.size());
//    System.out.println("empleado.getIdEmpleado() = " + empleado.getIdEmpleado());

    PnCualitativa cualitativa = pnManager.getPnCualitativaFromEmpleadoTipoFormato(
            empleado.getIdEmpleado(), 4 // FORMATO 1 INDIVIDUAL
    );
//    System.out.println("cualitativa = " + cualitativa);
    if (cualitativa!= null) {
%>
<br>
<b>Evaluaci&oacute;n</b>
<br>
<h3><%=nombre%></h3>
<b>de</b>
<br>
<h3><%=empleado.getPersonaByIdPersona().getNombreCompleto()%></h3>
<table border="1" width="100%">
    <tr><th class="alert-info">Valoraci&oacute;n Global de la Organizaci&oacute;n</th></tr>
    <tr><td><%=cualitativa.getVision()%></td></tr>
    <tr><th class="alert-info">Pendientes Vista de Campo</th></tr>
    <tr><td><%=cualitativa.getPendientesVisita()%></td></tr>
</table>
<%
    }
%>
<br>
<table border="1" width="100%">
    <%
        int oldCategoriaCriterio = 0;
        int total = 0;
        for (PnValoracion v: fromParticipante){
            if(v.getPnCriterioByIdPnCriterio().getId()!=15){
                total +=v.getValor();
            }
            if (oldCategoriaCriterio != v.getPnCriterioByIdPnCriterio().getPnCategoriaCriterioByIdCategoriaCriterio().getId() ) { //DIFERENTES
                oldCategoriaCriterio = v.getPnCriterioByIdPnCriterio().getPnCategoriaCriterioByIdCategoriaCriterio().getId();
    %>
    <tr>
        <th align="center" colspan="2" class="btn-inverse"><%=v.getPnCriterioByIdPnCriterio().getPnCategoriaCriterioByIdCategoriaCriterio().getCategoriaCriterio()%></th>
    </tr>
    <%
            }
    %>
    <tr>
        <%--<td><%=v.getPnCapituloByIdCapitulo().getNombreCapitulo()%></td>--%>
        <td><%=v.getPnCriterioByIdPnCriterio().getCriterio()%></td>
        <td align="right">
            <%=v.getPnCriterioByIdPnCriterio().getId()!=15? v.getValor() : total/14%>
        </td>
    </tr>
    <%
        }
    %>
</table>


