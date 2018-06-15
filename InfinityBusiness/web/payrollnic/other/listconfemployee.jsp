<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<META http-equiv="Cache-Control" content="no-cache">
<META http-equiv="Expires" content="0">
<META http-equiv="Pragma" content="no-cache">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Addition List</TITLE>
</HEAD>
<BODY onload="myForm.search.focus();">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%@ page import="javax.sql.RowSet,com.cap.wdf.action.*,com.cap.util.*,java.util.*, java.net.*, java.math.BigDecimal" errorPage="../../ERP_COMMON/error.jsp"%>
<%! 
 static final String title = "Configuracion de Empleados"; 
 %>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<%
 String anchor1 = "Ver";
 String anchor2 = "Editar";
 String anchor3 = "Configuracion Otros Datos Generales";
 String anchor4 = "Imprimir Hoja Electronica"; 
 String anchor5 = "Capacitaciones"; 
 
 FlowManager flowManager = (FlowManager) request.getAttribute("flowManager");
 
 boolean odd = true;
 int pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
 int rowCount = 0;
 //String rootPath = flowManager.createActionURI(flowManager.getActionName(request),request);

 String search = request.getParameter("search")==null?"":request.getParameter("search"); 

 String link   = "";
 String links1 = "/Ximple/viewconfemployee.jsp";
 String links2 = "/Ximple/erp/payrollnic/employee/confemployee.jsp?employeeName=Roberto C. Romero M.";
 String links3 = "/Ximple/erp/payrollnic/employee/otherdataemployee.jsp?employeeName=Roberto C. Romero M."; 
 String links4 = "/Ximple/erp/payrollnic/employee/ELECTRONICSHEET.xlsx"; 
 String links5 = "/Ximple/erp/payrollnic/employee/trainingemployee.jsp?employeeName=Roberto C. Romero M.";  

		link =  ConstantValue.PRE_TAG + links1 + ConstantValue.MID_TAG + anchor1 + 
				ConstantValue.ENDPRE_TAG + links2 + ConstantValue.MID_TAG + anchor2 + 
				ConstantValue.ENDPRE_TAG + links3 + ConstantValue.MID_TAG + anchor3 +  
				ConstantValue.ENDPRE_TAG + links4 + ConstantValue.MID_TAG + anchor4 + 
				ConstantValue.ENDPRE_TAG + links5 + ConstantValue.MID_TAG + anchor5 + ConstantValue.END_TAG; 				
 
 Object errMsg = request.getAttribute("actionErrors"); 
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= request.getContextPath() %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<TABLE width="650" border="0" class="Border" cellpadding="0" cellspacing="1">
    <TR class="tableheader"> 
      <td colspan="2">Lista de Empleados Configurados</td>
    </TR>
    <TR class="tableheader"> 
      <td width="40%">Nombre del Empleado</td>
      <td width="40%">Estado del Empleado</td>
    </TR>
    <TR class="pcrinfo">
      <TD><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline'; return overlib('<%=link%>', STICKY, WIDTH, 130, BORDER, 1, HAUTO, OFFSETY,-30,OFFSETX,20, TIMEOUT,3000);" onmouseout="this.className='link_alt_underline';return nd();">Meera Kirkiree</A></TD>
      <TD>Activo</TD>
   </TR>
    <TR class="pcrinfo1">
      <TD><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline'; return overlib('<%=link%>', STICKY, WIDTH, 130, BORDER, 1, HAUTO, OFFSETY,-30,OFFSETX,20, TIMEOUT,3000);" onmouseout="this.className='link_alt_underline';return nd();">Yan Wang</A></TD>
      <TD>Activo</TD>
   </TR>
    <TR class="pcrinfo">
      <TD><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline'; return overlib('<%=link%>', STICKY, WIDTH, 130, BORDER, 1, HAUTO, OFFSETY,-30,OFFSETX,20, TIMEOUT,3000);" onmouseout="this.className='link_alt_underline';return nd();">Roberto C. Romero M.</A></TD>
      <TD>Activo</TD>
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
    <TD width="40%"></TD>
    <TD width="20%" align="right">
	</TD>
    </TR>
</TABLE>
</FORM>  
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
