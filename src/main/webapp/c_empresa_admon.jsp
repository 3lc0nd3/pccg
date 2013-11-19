<%@ page import="co.com.elramireza.pn.model.Empresa" %>
<%@ page import="co.com.elramireza.pn.model.Empleado" %>
<%@ page import="co.com.elramireza.pn.model.Participante" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="co.com.elramireza.pn.model.Texto" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />
<%

    long ct = System.currentTimeMillis();
    int idPerfil = 0;
    int vieneDeFront = 0;
    String imgSrcRepor;
    imgSrcRepor = "images/document.png";

    Empleado empleo = (Empleado) session.getAttribute("empleo");
    System.out.println("empleo = " + empleo);
    Empresa empresa = (Empresa) request.getAttribute("empresa");
    System.out.println("empresa = " + empresa);
    if(empresa!=null){
        vieneDeFront =1;
    }
        /**
         * RECARGO EL EMPLEADO SOLO SI NO ES ADMON
         */
    if(empresa == null){
        if (empleo!=null) {
            empleo = pnManager.getEmpleado(empleo.getIdEmpleado());
        }
    }

    Participante participante = null;
    if(empresa == null){ // NO VIENE DE FRONTCONTROLLER
        if(empleo != null){ // TIENE QUE ESTAR LOGUEADO
            empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();
            participante = pnManager.getParticipante(empleo.getParticipanteByIdParticipante().getIdParticipante());
        }
    }


    if (empleo == null) {  // SOLO PARA ADMON
        idPerfil = 1;
    } else {
        idPerfil = empleo.getPerfilByIdPerfil().getId();
    }

    Participante participante1Req = (Participante) request.getAttribute("participante");
    if (participante1Req != null) { // SI VIENE DE  FRONTCONTROLLER
        vieneDeFront =1 ;
        participante = participante1Req;
        empresa = participante.getEmpresaByIdEmpresa();
        idPerfil = 7; // PARA QUE VEA TODOS LOS EVALUADORES
        System.out.println("SI VIENE DE  FRONTCONTROLLER "+ empresa.getNombreEmpresa() );
        System.out.println("participante.getIdParticipante() = " + participante.getIdParticipante());
    }

    System.out.println("DEsde ADMON jsp idPerfil = " + idPerfil);
    System.out.println("vieneDeFront = " + vieneDeFront);


//    if (empresa != null) {
//        System.out.println("empresa.getNombreEmpresa() = " + empresa.getNombreEmpresa());
//    }
    if(empresa != null || empresa.getIdEmpresa()!=1){ // HAY EMPRESA

%>

<h2>  <%=empresa.getNombreEmpresa()%></h2>
<span class="color">Direcci&oacute;n</span> <%=empresa.getDireccionEmpresa()%>
<br>
<span class="color">Categor&iacute;a</span> <%=empresa.getEmpresaCategoriaByIdCategoriaEmpresa().getCategoria()%>
<br>
<span class="color">Tama&ntilde;o</span> <%=empresa.getEmpresaCategoriaTamanoByIdCategoriaTamanoEmpresa().getTamano()%>
<%
    if(empleo!=null && empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa().getIdEmpresa()!=0){
        if (participante != null) {

%>
<br>
<span class="color">Etapa</span> <%=participante.getPnEtapaParticipanteByIdEtapaParticipante().getEtapaParticipante()%>
<%
        }
    }

    if (true)  { // SOLO PARA LIDER
%>
<a name="inicioResultados"></a>
<br>
<span class="color">Evaluadores:</span>
<blockquote>
    <%
        //        System.out.println("empleo.getPerfilByIdPerfil().getId() = " + empleo.getPerfilByIdPerfil().getId());
        List<Empleado> evaluadoresFromParticipante = new ArrayList<Empleado>();
        if (idPerfil == 7 ) { // SI ES LIDER
            evaluadoresFromParticipante = pnManager.getEvaluadoresFromParticipante(participante.getIdParticipante());
        } else if(idPerfil == 2 ) {  // SI ES EVALUADOR
            evaluadoresFromParticipante.add(empleo);
        }

        for (Empleado evaluador : evaluadoresFromParticipante){
    %>
    <span class="color"><%=evaluador.getPerfilByIdPerfil().getPerfil()%></span>
    <%=evaluador.getPersonaByIdPersona().getNombreCompleto()%>
    <blockquote><span onclick="cargaResultado(<%=evaluador.getIdEmpleado()%>,'evalGlobalInd', 16);"><img src="<%=imgSrcRepor%>" width="36">
        Ind. Global
        <img width="28" src="img/<%=evaluador.isEvaluaGlobal()?"ok":"stop"%>.png" alt="">
        </span>
        <br>
        <span onclick="cargaResultado(<%=evaluador.getIdEmpleado()%>,'evalCapInd', 17);"><img src="<%=imgSrcRepor%>" width="36">
        Ind. Cap&iacute;tulos
        <img width="28" src="img/<%=evaluador.isEvaluaCapitulos()?"ok":"stop"%>.png" alt="">
        </span>
        <br>
        <span  onclick="cargaResultado(<%=evaluador.getIdEmpleado()%>,'evalItemsInd', 18);"><img src="<%=imgSrcRepor%>" width="36">
        Cuantitativa (&Iacute;tems)
        <img width="28" src="img/<%=evaluador.isEvaluaItems()?"ok":"stop"%>.png" alt="">
        </span>
    </blockquote>
    <br>
    <%
        }
    %>
</blockquote>

<br>
<span class="color">Consenso:</span>
<blockquote>
    <span onclick="cargaResultadoConcenso(<%=participante.getIdParticipante()%>,'evalGlobalConsenso', 16);"><img src="<%=imgSrcRepor%>" width="36">
        Consenso Global
    </span>
    <br>
    <span onclick="cargaResultadoConcenso(<%=participante.getIdParticipante()%>,'evalCapConsenso', 17);"><img src="<%=imgSrcRepor%>" width="36">
        Consenso Cap&iacute;tulos
    </span>
    <br>
    <span  onclick="cargaResultadoConcenso(<%=participante.getIdParticipante()%>,'evalItemsConsenso', 18);"><img src="<%=imgSrcRepor%>" width="36">
        Consenso Cuantitativa (&Iacute;tems)
    </span>
</blockquote>
<br>
<span class="color">Retroalimentaci&oacute;n:</span>
<blockquote>
    <span onclick="cargaResultadoConcenso(<%=participante.getIdParticipante()%>,'informeRetro', 16);"><img src="<%=imgSrcRepor%>" width="36">
        Informe de Retroalimentaci&oacute;n
    </span>
</blockquote>
<%
    }
%>
<%--<jsp:include page="r_evalGlobalInd.jsp?id=8"/>--%>
<a name="aResultado"></a>
<br>
<a onclick="scrollToAnchor('inicioResultados')"><img width="32" src="images/back.png" alt="volver" title="volver">Ir arriba</a>
<div id="resultado">

</div>

<%--HOLA mundo--%>

<div> <%--  PREGUNTAS  --%>

    <%

        if(participante!=null){
            Texto pregunta1 = pnManager.getTexto(25);
            Texto pregunta2 = pnManager.getTexto(26);
            Texto pregunta3 = pnManager.getTexto(27);
            System.out.println("empleo.getpe = " + empleo.getPerfilByIdPerfil().getId());
            if(empleo != null && (empleo.getPerfilByIdPerfil().getId()==3 || empleo.getPerfilByIdPerfil().getId()==1)) {

    %>
    <b>Preguntas</b>
    <br>
    <li>
        <ul><%=pregunta1.getTexto1()%> <br> <%=participante.getPregunta1()!=null?participante.getPregunta1():"Sin respuesta"%></ul>
    </li>
    <li>
        <ul><%=pregunta2.getTexto1()%> <br> <%=participante.getPregunta2()!=null?participante.getPregunta2():"Sin respuesta"%></ul>
    </li>
    <li>
        <ul><%=pregunta3.getTexto1()%> <br> <%=participante.getPregunta3()!=null?participante.getPregunta3():"Sin respuesta"%></ul>
    </li>
    <%
            }
        } // FIN IF HAY PARTICIPANTE
    %>
</div>  <%--  FIN PREGUNTAS  --%>

<b>Archivos</b>
<Br>
<%--
<%
    Texto cartaTexto = pnManager.getTexto(28);
    if(participante!=null && participante.getFileInformePostula()!=null){
%>
<a href="pdfs/ip-<%=empresa.getNit()%>-<%=participante.getIdParticipante()%>.pdf?T=<%=ct%>" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color"><%=cartaTexto.getTexto1()%> PDF</span>
</a>
<%
} else {
    if(participante!=null){
%>
<img src="img/stop.png" alt="abrir" title="abrir" width="48">
No hay <%=cartaTexto.getTexto1()%>
<%
        }
    }
%>
<%
    if (idPerfil == 1 || idPerfil == 3 || vieneDeFront == 1) {
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
<br>
--%>
<%
    if(participante!=null && participante.getFileConsignacion()!=null){
%>
<a href="pdfs/co-<%=empresa.getNit()%>-<%=participante.getIdParticipante()%>.pdf?T=<%=ct%>" target="<%=empresa.getNit()%>">
    <img src="img/pdf.png" alt="abrir" title="abrir" width="48">
    <span class="color">Informe de Postulaci&oacute;n PDF</span>
</a>
<%
} else {
    if(participante!=null){

%>
<img src="img/stop.png" alt="abrir" title="abrir" width="48">
Informe de Postulaci&oacute;n PDF
<%
        }
    }
%>
<%
    //}  /* END MUESTRA ARCHIVOS SEGUN PERFILES  */
%>
<br>
<a onclick="scrollToAnchor('inicioResultados')"><img width="32" src="images/back.png" alt="volver" title="volver">Ir arriba</a>

<br>
<br>
<br>

<%
    } // FIN HAY EMPRESA
%>