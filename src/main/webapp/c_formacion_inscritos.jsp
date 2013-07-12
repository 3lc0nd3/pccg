<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    Integer idPremio = (Integer) request.getAttribute("idPremio");
    if (idPremio == null) {
        idPremio = Integer.parseInt(request.getParameter("idPremio"));
    }
    
    PnPremio premio = pnManager.getPnPremio(idPremio);
    
    List<Empleado> formacionEmpresarial = pnManager.getHibernateTemplate().find(
            "from Empleado where participanteByIdParticipante.pnPremioByIdConvocatoria.idPnPremio = ? and " +
                    "(perfilByIdPerfil.id = 10  or perfilByIdPerfil.id = 11 ) " +
                    "order by perfilByIdPerfil.id, personaByIdPersona.nombrePersona, personaByIdPersona.apellido",
            idPremio
    );

    List<Empleado> formacionPersonal = pnManager.getHibernateTemplate().find(
            "from Empleado where participanteByIdParticipante.pnPremioByIdConvocatoria.idPnPremio = ? and " +
                    "(perfilByIdPerfil.id = 9 ) " +
                    "order by perfilByIdPerfil.id, personaByIdPersona.nombrePersona, personaByIdPersona.apellido",
            idPremio
    );

    List<Empleado> formacionEvaluadores = pnManager.getHibernateTemplate().find(
            "from Empleado where participanteByIdParticipante.pnPremioByIdConvocatoria.idPnPremio = ? and " +
                    "(perfilByIdPerfil.id = 8 ) " +
                    "order by perfilByIdPerfil.id, personaByIdPersona.nombrePersona, personaByIdPersona.apellido",
            idPremio
    );

%>
<b>Inscritos en el Premio</b>
<h2><%=premio.getNombrePremio()%></h2>
<br>
<h3>Formaci&oacute;n Empresarial</h3>
<br>
<table border="1" width="90%">
<%
    int lastEmpresarial = 0;
    for (Empleado empleadoEmpresarial : formacionEmpresarial){
        if (lastEmpresarial != empleadoEmpresarial.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getIdEmpresa()) {
            lastEmpresarial = empleadoEmpresarial.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getIdEmpresa();
%>
    <tr>
        <th colspan="8">
            <%=empleadoEmpresarial.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getNombreEmpresa()%>
        </th>

    </tr>
    <tr>
        <th>Ciudad</th>
        <th> Doc. </th>
        <th> Nombre </th>
        <th> Apellido </th>
        <th> Emails</th>
        <%--<th> Email Personal</th>--%>
        <th> Tel&eacute;fonos </th>
        <%--<th> Celular </th>--%>
        <th> Perfil </th>
        <th width="28"> Opciones</th>
    </tr>
    <%

        }
%>
    <tr>
        <td><%=empleadoEmpresarial.getPersonaByIdPersona().getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <td><%=empleadoEmpresarial.getPersonaByIdPersona().getDocumentoIdentidad()%></td>
        <td><%=empleadoEmpresarial.getPersonaByIdPersona().getNombrePersona()%></td>
        <td><%=empleadoEmpresarial.getPersonaByIdPersona().getApellido()%></td>
        <td>
            <%=empleadoEmpresarial.getPersonaByIdPersona().getEmailPersonal()!=null?empleadoEmpresarial.getPersonaByIdPersona().getEmailPersonal():"" %>
            <br>
            <%=empleadoEmpresarial.getPersonaByIdPersona().getEmailCorporativo() %>
        </td>
        <td>
            <%=empleadoEmpresarial.getPersonaByIdPersona().getCelular()!=null?empleadoEmpresarial.getPersonaByIdPersona().getCelular():""%>
            <br>
            <%=empleadoEmpresarial.getPersonaByIdPersona().getTelefonoFijo() %>
        </td>
        <td><%=empleadoEmpresarial.getPerfilByIdPerfil().getPerfil()%></td>
        <td></td>
    </tr>
<%
    }
%>
</table>
<br>
<h3>Formaci&oacute;n Personal</h3>
<br>
<table border="1" width="90%">
    <tr>
        <th>Ciudad</th>
        <th> Doc. </th>
        <th> Nombre </th>
        <th> Apellido </th>
        <th> Emails</th>
        <%--<th> Email Personal</th>--%>
        <th> Tel&eacute;fonos </th>
        <%--<th> Celular </th>--%>
        <th> Perfil </th>
        <th width="28"> Opciones</th>
    </tr>
<%
    for (Empleado empleadoPersonal: formacionPersonal){
%>
    <tr>
        <td><%=empleadoPersonal.getPersonaByIdPersona().getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <td><%=empleadoPersonal.getPersonaByIdPersona().getDocumentoIdentidad()%></td>
        <td><%=empleadoPersonal.getPersonaByIdPersona().getNombrePersona()%></td>
        <td><%=empleadoPersonal.getPersonaByIdPersona().getApellido()%></td>
        <td>
            <%=empleadoPersonal.getPersonaByIdPersona().getEmailPersonal()!=null?empleadoPersonal.getPersonaByIdPersona().getEmailPersonal():"" %>
            <br>
            <%=empleadoPersonal.getPersonaByIdPersona().getEmailCorporativo() %>
        </td>
        <td>
            <%=empleadoPersonal.getPersonaByIdPersona().getCelular()!=null?empleadoPersonal.getPersonaByIdPersona().getCelular():""%>
            <br>
            <%=empleadoPersonal.getPersonaByIdPersona().getTelefonoFijo() %>
        </td>
        <td><%=empleadoPersonal.getPerfilByIdPerfil().getPerfil()%></td>
        <td></td>
    </tr>
<%
    }
%>
</table>
<br>
<h3>Formaci&oacute;n para Evaluadores</h3>
<br>
<table border="1" width="90%">
    <tr>
        <th>Ciudad</th>
        <th> Doc. </th>
        <th> Nombre </th>
        <th> Apellido </th>
        <th> Emails</th>
        <%--<th> Email Personal</th>--%>
        <th> Tel&eacute;fonos </th>
        <%--<th> Celular </th>--%>
        <th> Perfil </th>
        <th width="28"> Opciones</th>
    </tr>
<%
    for (Empleado empleadoPersonal: formacionEvaluadores){
%>
    <tr>
        <td><%=empleadoPersonal.getPersonaByIdPersona().getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <td><%=empleadoPersonal.getPersonaByIdPersona().getDocumentoIdentidad()%></td>
        <td><%=empleadoPersonal.getPersonaByIdPersona().getNombrePersona()%></td>
        <td><%=empleadoPersonal.getPersonaByIdPersona().getApellido()%></td>
        <td>
            <%=empleadoPersonal.getPersonaByIdPersona().getEmailPersonal()!=null?empleadoPersonal.getPersonaByIdPersona().getEmailPersonal():"" %>
            <br>
            <%=empleadoPersonal.getPersonaByIdPersona().getEmailCorporativo() %>
        </td>
        <td>
            <%=empleadoPersonal.getPersonaByIdPersona().getCelular()!=null?empleadoPersonal.getPersonaByIdPersona().getCelular():""%>
            <br>
            <%=empleadoPersonal.getPersonaByIdPersona().getTelefonoFijo() %>
        </td>
        <td><%=empleadoPersonal.getPerfilByIdPerfil().getPerfil()%></td>
        <td></td>
    </tr>
<%
    }
%>
</table>