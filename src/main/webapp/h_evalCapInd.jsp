<%@ page import="java.util.List" %>
<%@ page import="co.com.elramireza.pn.model.*" %>
<jsp:useBean id="pnManager" class="co.com.elramireza.pn.dao.PnDAO" scope="application" />

<%
    Texto texto16 = pnManager.getTexto(17);
    Texto texto19 = pnManager.getTexto(19);
    Texto texto20 = pnManager.getTexto(21);
    Texto texto23 = pnManager.getTexto(23);
    Empleado empleo = (Empleado) session.getAttribute("empleo");
    Empresa empresa = empleo.getParticipanteByIdParticipante().getEmpresaByIdEmpresa();

    List<PnCategoriaCriterio> categoriasCriterio = pnManager.getCategoriasCriterio();
//    categoriasCriterio.remove(categoriasCriterio.size()-1);

%>

<individual>
    <div id="contenedor" class="container">
        <div class="row">
            <div class="span8">
                <h2><%=texto16.getTexto1()%></h2>
                para <strong><%=empresa.getNombreEmpresa()%></strong>
                <br>
                <br>
                <%
                    List<PnValoracion> fromParticipante = pnManager.getValoracionIndividualCapitulosFromEmpleado(
                            empleo.getIdEmpleado());

                    List<PnCualitativa> cualitativas = pnManager.getPnCualitativasFromEmpleadoTipoFormato(
                            empleo.getIdEmpleado(), 2 // FORMATO 2 INDIVIDUALPOR CAPITULO
                    );
                    System.out.println("fromParticipante.size() = " + fromParticipante.size());
                    if(fromParticipante.size()==0){
                %>

                <div class="alert">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    no hay valores
                </div>
                <%
                    } else {
                %>

                <div class="alert alert-success">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    Datos ingresados el <%=pnManager.dfDateTime.format(cualitativas.get(0).getFechaCreacion())%>
                    <%
                        if (empleo.isEvaluaCapitulos()) {
                    %>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    Datos Finales
                    <img width="100" src="images/flag.png" alt="Final" title="Final">

                    <%
                        }
                    %>
                </div>
                <%
                    }

                    //MEGA FOR DE CAPITULOS
                    List<PnCapitulo> pnCapitulos = pnManager.getPnCapitulos();
                    for (PnCapitulo capitulo: pnCapitulos){
                        String bg;
                        if(capitulo.getId()%2 == 1){
                            bg = "#dad9d9";
                        } else {
                            bg = "#eeeded";
                        }

                        PnCualitativa cualitativa = pnManager.getPnCualitativa(2, capitulo.getId(), empleo);
                %>
                <br>
                <div class="esquinasRedondas" style="background-color:<%=bg%>; text-align:center;">
                    <br>
                    <h4 class="color"><%=capitulo.getNombreCapitulo()%></h4>
                    <br>
                <table border="1" width="70%" align="center">

                    <tr><th class="alert-info">
                        <img src="images/help.png" onclick="muestraAyudaCualitativa('v','<%=capitulo.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
                        <%=texto20.getTexto1()%></th></tr>
                    <tr>
                        <td class="contenido" bgcolor="white">
                            <span id="vision-<%=capitulo.getId()%>">
                                <%=cualitativa.getVision()%>
                            </span>
                            <br>
                            <br>
                            <a onclick="editarCualitativa('vision', <%=capitulo.getId()%>);">
                                <img src="images/edit.png" alt="Editar">
                                Editar
                            </a>
                        </td>
                     </tr>
                    <tr id="vision-tr-<%=capitulo.getId()%>" style="display:none;"><td>
                        <textarea id="vision-text-<%=capitulo.getId()%>" class="field span6" placeholder="" rows="4" cols="10"></textarea>
                        <img  style="margin-bottom: 12px;" src="img/atencion.gif" width="25" height="25" alt="">
                        <a style="margin-bottom: 15px;" class="btn btn-danger" onclick="guardaCualitativa('vision', <%=capitulo.getId()%>);">Guardar</a>
                        <%--<br>&nbsp;--%>
                    </td></tr>
                    <tr id="v-<%=capitulo.getId()%>-contenido" style="display:none;">
                        <td  class="contenido">
                            <%=texto20.getTexto2()%>
                        </td>
                    </tr>

                    <tr><th class="alert-info">
                        <img src="images/help.png" onclick="muestraAyudaCualitativa('f','<%=capitulo.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
                        Fortalezas</th></tr>
                    <tr>
                        <td class="contenido" bgcolor="white">
                            <span id="fortalezas-<%=capitulo.getId()%>">
                                <%=cualitativa.getFortalezas()%>
                            </span>
                            <br>
                            <br>
                            <a onclick="editarCualitativa('fortalezas', <%=capitulo.getId()%>);">
                                <img src="images/edit.png" alt="Editar">
                                Editar
                            </a>
                        </td>
                    </tr>
                    <tr id="fortalezas-tr-<%=capitulo.getId()%>" style="display:none;"><td>
                        <textarea id="fortalezas-text-<%=capitulo.getId()%>" class="field span6" placeholder="" rows="4" cols="10"></textarea>
                        <img  style="margin-bottom: 12px;" src="img/atencion.gif" width="25" height="25" alt="">
                        <a style="margin-bottom: 15px;" class="btn btn-danger" onclick="guardaCualitativa('fortalezas', <%=capitulo.getId()%>);">Guardar</a>
                    </td></tr>
                    <tr id="f-<%=capitulo.getId()%>-contenido" style="display:none;">
                        <td class="contenido">
                            <%=texto19.getTexto1()%>
                        </td>
                    </tr>

                    <tr><th class="alert-info">
                        <img src="images/help.png" onclick="muestraAyudaCualitativa('o','<%=capitulo.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
                        Oportunidades de Mejora</th></tr>
                    <tr>
                        <td class="contenido" bgcolor="white">
                            <span id="oportunidades-<%=capitulo.getId()%>">
                                <%=cualitativa.getOportunidades()%>
                            </span>
                            <br>
                            <br>
                            <a onclick="editarCualitativa('oportunidades', <%=capitulo.getId()%>);">
                                <img src="images/edit.png" alt="Editar">
                                Editar
                            </a>
                        </td>
                    </tr>
                    <tr id="oportunidades-tr-<%=capitulo.getId()%>" style="display:none;"><td>
                        <textarea id="oportunidades-text-<%=capitulo.getId()%>" class="field span6" placeholder="" rows="4" cols="10"></textarea>
                        <img  style="margin-bottom: 12px;" src="img/atencion.gif" width="25" height="25" alt="">
                        <a style="margin-bottom: 15px;" class="btn btn-danger" onclick="guardaCualitativa('oportunidades', <%=capitulo.getId()%>);">Guardar</a>
                    </td></tr>
                    <tr id="o-<%=capitulo.getId()%>-contenido" style="display:none;">
                        <td colspan="2" class="contenido">
                            <%=texto19.getTexto2()%>
                        </td>
                    </tr>

                    <tr><th class="alert-info">
                        <img src="images/help.png" onclick="muestraAyudaCualitativa('p','<%=capitulo.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
                        Puntos Pendientes Visita de Campo</th></tr>
                    <tr>
                        <td class="contenido" bgcolor="white">
                            <span id="pendientesVisita-<%=capitulo.getId()%>">
                                <%=cualitativa.getPendientesVisita()%>
                            </span>
                            <br>
                            <br>
                            <a onclick="editarCualitativa('pendientesVisita', <%=capitulo.getId()%>);">
                                <img src="images/edit.png" alt="Editar">
                                Editar
                            </a>
                        </td>
                    </tr>
                    <tr id="pendientesVisita-tr-<%=capitulo.getId()%>" style="display:none;"><td>
                        <textarea id="pendientesVisita-text-<%=capitulo.getId()%>" class="field span6" placeholder="" rows="4" cols="10"></textarea>
                        <img  style="margin-bottom: 12px;" src="img/atencion.gif" width="25" height="25" alt="">
                        <a style="margin-bottom: 15px;" class="btn btn-danger" onclick="guardaCualitativa('pendientesVisita', <%=capitulo.getId()%>);">Guardar</a>
                    </td></tr>
                    <tr id="p-<%=capitulo.getId()%>-contenido" style="display:none;">
                        <td colspan="2" class="contenido">
                            Puntos para tener en cuenta
                        </td>
                    </tr>


                </table>
                <br>
                <table border="1" align="center" width="90%">
                    <%
                        for (PnCategoriaCriterio categoriaCriterio:  categoriasCriterio){
                    %>
                    <tr>
                        <th colspan="2" class="btn-inverse"><%=categoriaCriterio.getCategoriaCriterio()%></th>
                    </tr>
                    <%
                            for (PnCriterio criterio: pnManager.getPnCriteriosFromCategoria(categoriaCriterio.getId())){
                    %>
                    <tr>
                        <td class=" btn-primary">
                            <img src="images/help.png" onclick="muestraAyudaCriterio('<%=criterio.getId()%>','<%=capitulo.getId()%>', true);" width="24" alt="Contenido" title="Contenido">
                            <%
                                if (criterio.getId()!=15){
                            %>
                            <%=criterio.getCriterio()%>
                            <%
                            } else {
                            %>
                            <%=texto23.getTexto2()%>
                            <%
                                }
                            %>
                        </td>
                        <td class="btn-primary">
                            <%
                                if (criterio.getId() != 15) {
                            %>
                            <select name="<%=capitulo.getId()%>-<%=criterio.getId()%>" id="<%=criterio.getId()%>" onchange="muestraAyudaCriterio(<%=criterio.getId()%>, '<%=capitulo.getId()%>', false)" class="selEval">
                            <%
                                for (Integer v: pnManager.getValoresValoracion()){
                            %>
                                <option <%=v==50?"selected":""%> class="selEval" value="<%=v%>"><%=v%></option>
                            <%
                                }
                            %>
                            </select>
                            <%
                                } else {
                            %>
                            <span id="<%=capitulo.getId()%>-15" class="btn-primary selEval"></span>
                            <%
                                }
                            %>
                        </td>
                    </tr>
                    <tr id="<%=capitulo.getId()%>-contenido<%=criterio.getId()%>" style="display:none;">
                        <td colspan="2">
                            <table cellpadding="0" cellspacing="0" border="1" width="100%">
                                <tr>
                                    <td width="50%" class="contenido">
                                        <span id="<%=capitulo.getId()%>-evalua<%=criterio.getId()%>"></span>
                                        <%--<%=item.getEvalua()%>--%>
                                    </td>
                                    <td width="50%" class="contenido">
                                        <span id="<%=capitulo.getId()%>-ayuda<%=criterio.getId()%>"></span>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </table>
                    <br>&nbsp;  <button id="b1" class="btn  btn-primary" onclick="guardaIndividualCapitulos(false);">Guardar Avance</button>
                    </div>
                <%
                    } //  END DEL MEGA FOR DE CAPITULOS
                %>
                <%
                    if (!empleo.isEvaluaCapitulos()) {
                %>
                                         <br>
                
                <%--<button id="b1" class="btn  btn-primary" onclick="guardaIndividualCapitulos(false);">Guardar Avance</button>--%>
                <button id="b2" class="btn  btn-primary" onclick="guardaIndividualCapitulos(true);">Guardar Final</button>
                <%
                    }
                %>
            </div><%--  FIN SPAN8 --%>
            <div class="span4">
                <jsp:include page="c_empresa_admon.jsp"    />
            </div>
        </div>
    </div>
</individual>


<jsp:include page="c_footer_r.jsp"/>

<script type="text/javascript">

    function guardaIndividualCapitulos(definitivo){

        var dataValores = new Array();

    <%

                        int total=0;
        for (PnCapitulo capitulo : pnCapitulos) {
    %>
    <%
            for (PnCriterio criterio : pnManager.getPnCriterios()){
    %>
        dataValores.push    ({id:<%=capitulo.getId()%>, criterio:<%=criterio.getId()%>,
            value: dwr.util.getValue("<%=capitulo.getId()%>-<%=criterio.getId()%>")});
    <%
            }
        }
    %>
//        alert(dwr.util.toDescriptiveString(dataValores, 2));

        if (definitivo) {
            disableId("b2");
        } else {
            disableId("b1");
        }

        pnRemoto.saveValoracionIndividualCapitulos(definitivo,
                dataValores, function(data){
            if(data == 1){
                alert("Registro Correcto");
                window.location = "evalCapInd.htm";
            } else {
                alert("Problemas !");
            }

                    if (definitivo) {
                        enableId("b2");
                    } else {
                        enableId("b1");
                    }
        });

    }

    <%

//                       System.out.println("fromParticipante.size() = " + fromParticipante.size());
                    if(fromParticipante.size()>0){  // SOLO SI HAY VALORACION
                        for (PnValoracion valoracion : fromParticipante){
//                        System.out.println("valoracion.getPnCapituloByIdCapitulo().getId() = " + valoracion.getPnCapituloByIdCapitulo().getId());
//                        System.out.println("\tvaloracion.getPnCriterioByIdPnCriterio().getId() = " + valoracion.getPnCriterioByIdPnCriterio().getId());
                            if(valoracion.getPnCriterioByIdPnCriterio().getId()==1){ // CUANDO REINICIA EL CAPITULO
                                total = 0;
                            }
                           if (valoracion.getPnCriterioByIdPnCriterio().getId()!= 15){
                                total += valoracion.getValor();
                            }
    %>
    dwr.util.setValue("<%=valoracion.getPnCapituloByIdCapitulo().getId()%>-<%=valoracion.getPnCriterioByIdPnCriterio().getId()%>", <%=valoracion.getValor()%>);
    <%

                            if(valoracion.getPnCriterioByIdPnCriterio().getId() ==15){
    %>
    dwr.util.setValue("<%=valoracion.getPnCapituloByIdCapitulo().getId()%>-15", "<%=total/14%>");
    <%
                            }
    %>
    <%
                        }
                    } else { // aca
                            System.out.println("NO HAY DATOS IND. CAPITULO");
                            }
                    if(cualitativas != null){
                        for (PnCualitativa cualitativa: cualitativas){
    %>
//    try{
    <%--dwr.util.setValue(          "vision-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getVision().replaceAll("\n", "<br>").replaceAll("\r", "").replace("'","\"")%>'));--%>
    <%--dwr.util.setValue(      "fortalezas-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getFortalezas().replaceAll("\n", "<br>").replaceAll("\r", "").replace("'","\"")%>'));--%>
    <%--dwr.util.setValue(   "oportunidades-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getOportunidades().replaceAll("\n", "<br>").replaceAll("\r", "").replace("'","\"")%>'));--%>
    <%--dwr.util.setValue("pendientesVisita-<%=cualitativa.getPnCapituloByIdCapitulo().getId()%>",  poneSaltosDeLinea('<%=cualitativa.getPendientesVisita().replaceAll("\n", "<br>").replaceAll("\r", "").replace("'","\"")%>'));--%>
//    } catch(err){

//    }
    <%
                        } // FOR CUALITATIVAS
                    } // IF NULL
    %>

    <%
    if(empleo.isEvaluaCapitulos()){
    %>
    $('#contenedor').find('select, textarea').attr('disabled','disabled');
    <%
    }
    %>

    /**
     fortalezas oportunidades pendientesVisita vision
     */
    function editarCualitativa(campo, idCapitulo) {
        pnRemoto.getPnCualitativa(2, idCapitulo, null, function(data){
//            alert("data = " + data[campo]);
            $("#"+campo+"-tr-"+idCapitulo).show();
            dwr.util.setValue(campo+"-text-"+idCapitulo, data[campo]);
        });
    }
    
    function guardaCualitativa(campo, idCapitulo){
        var txt = dwr.util.getValue(campo+"-text-"+idCapitulo);
//        alert("txt = " + txt);
        pnRemoto.actualizaCualitativa(2, idCapitulo, txt, campo, function(data){
//            alert("data = " + data);
            dwr.util.setValue(campo+"-"+idCapitulo, data[campo]);
            dwr.util.setValue(campo+"-text-"+idCapitulo, "");
            $("#"+campo+"-tr-"+idCapitulo).hide();
        });
    }
</script>