<%@ page import="co.com.elramireza.pn.model.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%
    long ct = System.currentTimeMillis();
    Texto pregunta1 = pnManager.getTexto(25);
    Texto pregunta2 = pnManager.getTexto(26);
    Texto pregunta3 = pnManager.getTexto(27);
    Texto cartaTexto = pnManager.getTexto(28);

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
<A href="http://www.pccg.com.co/app/c_postuladasPremio.jsp?idPremio=<%=idPremio%>&d=<%=System.currentTimeMillis()%>">
    Exportar a Excel <img src="img/excel.png" width="36" alt="Exportar">
</A>
<br>

<%
    }



    List<Participante> participantes = pnManager.getHibernateTemplate().find(
            "from Participante where idParticipante in (select participanteByIdParticipante.idParticipante from Empleado where perfilByIdPerfil.id = 3 and participanteByIdParticipante.pnPremioByIdConvocatoria.idPnPremio = ?)",
            idPremio
    );



%>
<b>Premio</b>
<h2><%=premio.getNombrePremio()%></h2>
<br>
<h3>Empresas Postuladas.</h3>
<br>
<table border="1" width="90%">
    <tr>
        <th>Nombre</th>
        <th>Ciudad</th>
        <th>Nit.</th>
        <th>Nombre</th>
        <th>Direcci&oacute;n</th>
        <th>Emails</th>
        <th>Tel&eacute;fonos</th>
        <th>Fecha de Registro</th>
        <th width="28"> Opciones</th>
    </tr>
<%
    for (Participante participante : participantes){
        Empresa empresa = participante.getEmpresaByIdEmpresa();
        List<Empleado> empleados = pnManager.getEmpleadosFromParticipante(participante.getIdParticipante());
%>
    <tr>
        <td><b><%=empresa.getNombreEmpresa()%></b></td>
        <td><%=empresa.getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <td><%=empresa.getNit()%></td>
        <td><b><%=empresa.getNombreEmpresa()%></b></td>
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
    <tr>
        <td><b><%=empresa.getNombreEmpresa()%></b></td>
        <td><%=empresa.getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <%--<th>&nbsp;</th>--%>
        <th colspan="6">
            Personas de <%=empresa.getNombreEmpresa()%>
        </th>
    </tr>
    <tr>
        <%--<td><b><%=empresa.getNombreEmpresa()%></b></td>--%>
        <%--<td><%=empresa.getLocCiudadByIdCiudad().getNombreCiudad()%></td>--%>
        <th>&nbsp;</th>
        <th>Ciudad</th>
        <th>Perfil</th>
        <th>Nombre</th>
        <th>Correo Corp.</th>
        <th>Correo Personal</th>
        <th>Tel. Celular</th>
        <th>Tel. Fijo</th>
        <th>&nbsp;</th>
    </tr>
    <%
        for (Empleado empleado: empleados){
            Persona persona = empleado.getPersonaByIdPersona();
    %>
    <tr>
        <td><b><%=empresa.getNombreEmpresa()%></b></td>
        <td><%=empresa.getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <%--<th>&nbsp;</th>--%>
        <td><%=empleado.getPerfilByIdPerfil().getPerfil()%></td>
        <td><%=persona.getNombreCompleto()%></td>
        <td><%=persona.getEmailCorporativo()%></td>
        <td><%=persona.getEmailPersonal()%></td>
        <td><%=persona.getCelular()%></td>
        <td><%=persona.getTelefonoFijo()%></td>
        <td></td>
    </tr>
    <%
        }
    %>
    <tr>
        <td><b><%=empresa.getNombreEmpresa()%></b></td>
        <td><%=empresa.getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <Td>
            Pregunta 1
        </Td>
        <td colspan="2">
            <%=pregunta1.getTexto1()%>
        </td>
        <td colspan="2">
            <%=participante.getPregunta1()==null?"Sin respuesta":participante.getPregunta1()%>
        </td>

        <td colspan="2" rowspan="3">
            <%
                if(participante!=null && participante.getFileInformePostula()!=null){
            %>
            <a href="pdfs/ip-<%=empresa.getNit()%>-<%=participante.getIdParticipante()%>.pdf?T=<%=ct%>" target="<%=empresa.getNit()%>">
                <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
                <span class="color"><%=cartaTexto.getTexto1()%> PDF</span>
            </a>
            <%
            } else {
            %>
            <img src="img/stop.png" alt="abrir" title="abrir" width="48">
            No hay <%=cartaTexto.getTexto1()%>
            <%
                }
            %>

            <br>
            <%
                if(empresa.getFileCertificadoConstitucion()!=null){
            %>
            <a href="pdfs/cc-<%=empresa.getNit()%>.pdf?T=<%=ct%>" target="<%=empresa.getNit()%>">
                <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
                <span class="color">Certificado Constituci&oacute;n Legal PDF</span>
            </a>
            <%
            } else {
            %>
            <img src="img/stop.png" alt="abrir" title="abrir" width="48">
            Certificado Constituci&oacute;n Legal
            <%
                }
            %>
            <br>
            <%
                if(empresa.getFileEstadoFinanciero()!=null){
            %>
            <a href="pdfs/ef-<%=empresa.getNit()%>.pdf?T=<%=ct%>" target="<%=empresa.getNit()%>">
                <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
                <span class="color">Estados Financieros (3 a&ntilde;os) PDF</span>
            </a>
            <%
            } else {
            %>
            <img src="img/stop.png" alt="abrir" title="abrir" width="48">
            Estados Financieros (3 a&ntilde;os)
            <%
                }
            %>
        </td>
    </tr>
    <tr>
        <td><b><%=empresa.getNombreEmpresa()%></b></td>
        <td><%=empresa.getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <Td>
            Pregunta 2
        </Td>
        <td colspan="2">
            <%=pregunta2.getTexto1()%>
        </td>
        <td colspan="2">
            <%=participante.getPregunta2()==null?"Sin respuesta":participante.getPregunta2()%>
        </td>
    </tr>
    <tr>
        <td><b><%=empresa.getNombreEmpresa()%></b></td>
        <td><%=empresa.getLocCiudadByIdCiudad().getNombreCiudad()%></td>
        <Td>
            Pregunta 3
        </Td>
        <td colspan="2">
            <%=pregunta3.getTexto1()%>
        </td>
        <td colspan="2">
            <%=participante.getPregunta3()==null?"Sin respuesta":participante.getPregunta3()%>
        </td>
    </tr>
    <tr>
        <td colspan="9">
            &nbsp;
            <br>
            <br>
        </td>
    </tr>
<%
    }
%>
</table>
<br>
