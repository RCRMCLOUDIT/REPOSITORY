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
 static final String title = "Perfiles de Cargos"; 
 %>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<%
 String anchor1 = "Editar";
 
 FlowManager flowManager = (FlowManager) request.getAttribute("flowManager");
 
 boolean odd = true;
 int pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
 int rowCount = 0;
 //String rootPath = flowManager.createActionURI(flowManager.getActionName(request),request);

 String search = request.getParameter("search")==null?"":request.getParameter("search"); 

 String link   = "";
 String links1 = "/Ximple/erp/payrollnic/employee/jobprofile.jsp?jobname=Director de Sistemas de Informacion";

		link =  ConstantValue.PRE_TAG + links1 + ConstantValue.MID_TAG + anchor1 + ConstantValue.END_TAG; 				
 
 Object errMsg = request.getAttribute("actionErrors"); 
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= request.getContextPath() %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<TABLE width="650" border="0" class="Border" cellpadding="0" cellspacing="1">
    <TR class="tableheader"> 
      <td colspan="2">Lista de Perfil de Cargos</td>
    </TR>
    <TR class="tableheader"> 
      <td width="40%">Area</td>
      <td width="40%">Nombre del Perfil</td>
    </TR>
    <TR class="pcrinfo">
      <TD>Area de Sistemas de Informacion</TD>    
      <TD><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline'; return overlib('<%=link%>', STICKY, WIDTH, 70, BORDER, 1, HAUTO, OFFSETY,-30,OFFSETX,20, TIMEOUT,3000);" onmouseout="this.className='link_alt_underline';return nd();">Director de Sistemas de Informacion</A></TD>
   </TR>
    <TR class="pcrinfo1">
      <TD>Area de Sistemas de Informacion</TD>    
      <TD><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline'; return overlib('<%=link%>', STICKY, WIDTH, 70, BORDER, 1, HAUTO, OFFSETY,-30,OFFSETX,20, TIMEOUT,3000);" onmouseout="this.className='link_alt_underline';return nd();">Analista</A></TD>   </TR>
    <TR class="pcrinfo">
      <TD>Area de Sistemas de Informacion</TD>    
      <TD><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline'; return overlib('<%=link%>', STICKY, WIDTH, 70, BORDER, 1, HAUTO, OFFSETY,-30,OFFSETX,20, TIMEOUT,3000);" onmouseout="this.className='link_alt_underline';return nd();">Programador</A></TD>   </TR>      
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
    <TD width="20%"><INPUT type="button" name="addNew" class="button" value="<%=rb.getString("B00001") %>" onclick="window.location = '/Ximple/erp/payrollnic/employee/listjobprofile.jsp';"></TD>
    <TD width="40%"></TD>
    <TD width="20%" align="right">
	</TD>
    </TR>
</TABLE>
</FORM>  
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
