<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<META http-equiv="Cache-Control" content="no-cache">
<META http-equiv="Expires" content="0">
<META http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Planillas Pagadas</TITLE>
</HEAD>
<BODY onload="myForm.search.focus();">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%@ page import="javax.sql.RowSet,com.cap.wdf.action.*,com.cap.util.*,java.util.*, java.net.*, java.math.BigDecimal" errorPage="../../ERP_COMMON/error.jsp"%>
<%! 
 static final String title = "Pago de Planillas"; 
 %>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<%
 String anchor1 = "Ver";
 String anchor2 = "Colilla de Pago Excel";
 String anchor3 = "Colilla de Pago PDF";  
 
 FlowManager flowManager = (FlowManager) request.getAttribute("flowManager");
 
 boolean odd = true;
 int pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
 int rowCount = 0;
 //String rootPath = flowManager.createActionURI(flowManager.getActionName(request),request);
 String birthDate = Format.getSysDate();

 String search = request.getParameter("search")==null?"":request.getParameter("search"); 

 String link   = "";
 String links1 = "/Ximple/erp/payrollnic/employee/pagoplanilla.jsp?employeeName=Roberto C. Romero M.";
 String links2 = "/Ximple/erp/payrollnic/employee/COLILLADEPAGO.xlsx";
 String links3 = "/Ximple/erp/payrollnic/employee/COLILLADEPAGO.pdf";

		link =  ConstantValue.PRE_TAG + links1 + ConstantValue.MID_TAG + anchor1 + 
				ConstantValue.ENDPRE_TAG + links2 + ConstantValue.MID_TAG + anchor2 +
				ConstantValue.ENDPRE_TAG + links3 + ConstantValue.MID_TAG + anchor3 +ConstantValue.END_TAG; 				
 
 Object errMsg = request.getAttribute("actionErrors"); 
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= request.getContextPath() %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<%
String mensaje=request.getParameter("mensaje")==null?"":request.getParameter("mensaje"); 
if(!mensaje.equals(""))
{
%>
<TABLE width="650" border="0" cellpadding="0" cellspacing="1">
	<TR colspan="13" class="textRed">
		<TD align="left"><%=mensaje%>
		</TD>
	</TR>
</TABLE>
<% }%>
<TABLE width="650" border="0" class="Border" cellpadding="0" cellspacing="1">
    <TR class="tableheader"> 
      <td colspan="13">Datos de Planilla</td>
    </TR>
    <TR class="tableheader"> 
      <td colspan="13"> Desde
			<input size="9" name="birthDate0" value="04/01/2011" maxlength="10"
			type="text" onkeyup="addSlash(myForm.birthDate0)"
			onchange="formatDate(myForm.birthDate0)"
			onkeypress="OnlyDigits();addSlash(myForm.birthDate0)"
			onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate0, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar">
		A
			<input size="10" name="birthDate0" value="04/15/2011" maxlength="10"
			type="text" onkeyup="addSlash(myForm.birthDate0)"
			onchange="formatDate(myForm.birthDate0)"
			onkeypress="OnlyDigits();addSlash(myForm.birthDate0)"
			onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate0, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"><A href="/Ximple/erp/payrollnic/employee/DATOSPLANILLA.xlsx">EXCEL</A> <A href="">PDF</A></td>				      
    </TR>    
    <TR class="tableheader"> 
      <td># del Empleado</td> 
      <td>Nombre del Empleado</td>
      <td>Salario Quincenal</td>      
      <td>Comisiones</td>      
      <td>Antiguedad</td>
      <td>Otras Percepciones</td>
      <td>Total Ingresos</td>
	  <td>INSS</td>
	  <td>IR</td>      
	  <td>Prestamos</td>      
      <td>Otras Deducciones</td>      
      <td>Total Deducciones</td>      
      <td>Neto a Pagar</td>           
    </TR>
    <TR>
     <TD colspan="13" class="label" align="left">Gerencia de Informatica</TD>
    </TR>    
    <TR class="pcrinfo">
      <TD><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline'; return overlib('<%=link%>', STICKY, WIDTH, 120, BORDER, 1, HAUTO, OFFSETY,-30,OFFSETX,20, TIMEOUT,3000);" onmouseout="this.className='link_alt_underline';return nd();">2012</A></TD>
      <TD>Meera Kirkiree</TD>
      <TD align="right">2,000.00</TD>      
      <TD align="right">0.00</TD>      
      <TD align="right">0.00</TD>
      <TD align="right">0.00</TD>            
      <TD align="right"><b>2,000.00</b></TD>            
      <TD align="right">250.00</TD>                   
      <TD align="right">40.00</TD>                  
      <TD align="right">0.00</TD> 
      <TD align="right">0.00</TD>  
      <TD align="right"><b>290.00</b></TD>
      <TD align="right"><b>1,710.00</b></TD>         
   </TR>
    <TR class="pcrinfo1">
      <TD><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline'; return overlib('<%=link%>', STICKY, WIDTH, 120, BORDER, 1, HAUTO, OFFSETY,-30,OFFSETX,20, TIMEOUT,3000);" onmouseout="this.className='link_alt_underline';return nd();">2548</A></TD>
      <TD>Yan Wang</TD>
      <TD align="right">4,000.00</TD>      
      <TD align="right">1,000.00</TD>      
      <TD align="right">0.00</TD>
      <TD align="right">500.00</TD>                  
      <TD align="right"><b>5,500.00</b></TD>
      <TD align="right">500.00</TD>                  
      <TD align="right">80.00</TD>                  
      <TD align="right">0.00</TD>                  
      <TD align="right">0.00</TD>       
      <TD align="right"><b>580.00</b></TD>
      <TD align="right"><b>4,920.00</b></TD>                                                                                          
   </TR>
    <TR>
     <TD colspan="2" class="label" align="left">Tot. Gerencia de Informatica</TD>
      <TD align="right"><b>6,000.00</b></TD>      
      <TD align="right"><b>1,000.00</b></TD>      
      <TD align="right"><b>0.00</b></TD>
      <TD align="right"><b>500.00</b></TD>                  
      <TD align="right"><b>7,500.00</b></TD>
      <TD align="right"><b>750.00</b></TD>                  
      <TD align="right"><b>120.00</b></TD>                  
      <TD align="right"><b>0.00</b></TD>                  
      <TD align="right"><b>0.00</b></TD>       
      <TD align="right"><b>870.00</b></TD>
      <TD align="right"><b>6,630.00</b></TD>       
    </TR>   
    <TR>
     <TD colspan="13" class="label" align="left">Gerencia General</TD>
    </TR>    
    <TR class="pcrinfo">
      <TD><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline'; return overlib('<%=link%>', STICKY, WIDTH, 120, BORDER, 1, HAUTO, OFFSETY,-30,OFFSETX,20, TIMEOUT,3000);" onmouseout="this.className='link_alt_underline';return nd();">1082</A></TD>
      <TD>Roberto C. Romero M.</TD>
      <TD align="right">4,000.00</TD>      
      <TD align="right">1,500.00</TD>      
      <TD align="right">0.00</TD>
      <TD align="right">1,500.00</TD>                  
      <TD align="right"><b>7,000.00</b></TD>
	  <TD align="right">1,000.00</TD>
	  <TD align="right">200.00</TD>
	  <TD align="right">0.00</TD>
	  <TD align="right">0.00</TD>
	  <TD align="right"><b>1,200.00</b></TD>                 
	  <TD align="right"><b>5,800.00</b></TD>                 	  
   </TR>   
    <TR>
     <TD colspan="2" class="label" align="left">Tot. Gerencia General</TD>
      <TD align="right"><b>4,000.00</b></TD>      
      <TD align="right"><b>1,500.00</b></TD>      
      <TD align="right"><b>0.00</b></TD>
      <TD align="right">1,<b>500.00</b></TD>                  
      <TD align="right"><b>7,000.00</b></TD>
      <TD align="right">1,<b>000.00</b></TD>                  
      <TD align="right"><b>200.00</b></TD>                  
      <TD align="right"><b>0.00</b></TD>                  
      <TD align="right"><b>0.00</b></TD>       
      <TD align="right"><b>1,200.00</b></TD>
      <TD align="right"><b>5,800.00</b></TD>       
    </TR>    
    <TR class="tableheader">
     <TD colspan="2" class="label" align="left">Total Planilla</TD>
      <TD align="right"><b>10,000.00</b></TD>      
      <TD align="right"><b>2,500.00</b></TD>      
      <TD align="right"><b>0.00</b></TD>
      <TD align="right"><b>2,000.00</b></TD>                  
      <TD align="right"><b>14,500.00</b></TD>
      <TD align="right">1,<b>750.00</b></TD>                  
      <TD align="right"><b>320.00</b></TD>                  
      <TD align="right"><b>0.00</b></TD>                  
      <TD align="right"><b>0.00</b></TD>       
      <TD align="right">2,<b>070.00</b></TD>
      <TD align="right"><b>12,430.00</b></TD>       
    </TR>            
</TABLE>

<FORM name="myForm" method="post" action="">
<INPUT type="hidden" name="_message" value="list">
<INPUT type="hidden" name="page" value="<%=pag%>">

<TABLE width="650" border="0" cellpadding="0" cellspacing="1">
    <TR class="pcrinfo">
      <TD height="20" valign="middle" class="label" align="center" colspan="4"><%=rb.getString("B00014") %>:
		<INPUT type="text" name="search" value="<%=Format.encodeHTML(search)%>" class="text">
		<INPUT type="submit" name="go" value="Go" class="button" onclick="myForm._message.value='list'; myForm.page.value='1';">
	  </TD>
    </TR>
    <TR>
    <TD width="20%"><INPUT type="button" name="addNew" class="button" value="<%=rb.getString("B00001") %>" onclick="window.location = '/Ximple/erp/payrollnic/employee/confemployee.jsp';"></TD>
<%
String aplicada = request.getParameter("aplicada")==null?"N":request.getParameter("aplicada");
if(aplicada.equals("N"))
{
%>
    <TD width="40%"><INPUT type="button" name="Generar Planilla" value="Generar Planilla" class="button" onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/employee/listpayrollemployee.jsp?aplicada=Y&mensaje=La Planilla ha sido Generada exitosamente';"></TD>
<%}else {%>
    <TD width="40%">
    	<INPUT type="button" name="Desaplicar Planilla" value="Desaplicar Planilla" class="button" onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/employee/listpayrollemployee.jsp?aplicada=N&mensaje=La Planilla ha sido Desaplicada exitosamente';">
    	<A href="/Ximple/erp/payrollnic/employee/PLANILLAGENERADA.xlsx">EXCEL</A> <A href="/Ximple/erp/payrollnic/employee/PLANILLAGENERADA.pdf">PDF</A>
    </TD>
<% }%>    
    </TR>
</TABLE>
</FORM>  
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
