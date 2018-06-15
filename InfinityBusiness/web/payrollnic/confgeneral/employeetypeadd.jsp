<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Agregar Tipo de Empleado</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.employeetypeadd.name.focus()">
<%@ page errorPage="../../ERP_COMMON/error.jsp" import="com.cap.util.*" %>
<%! 
 static final String title = "Agregar Tipo de Empleado";  
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 *******************************************************************************/
 String name 	= request.getParameter("name")==null?"":request.getParameter("name");
 String abrv 	= request.getParameter("abrv")==null?"":request.getParameter("abrv");
 
 String contextRoot = request.getParameter("contextRoot");

 String errMsg = null;

 /*******************************************************************************
 * In case we are comming from the command page due some error, the addCommandDBBean
 * object already exists from that page. It must be create in request scope
 *******************************************************************************/
 if (returnWithError.equals("Y"))
 {
       errMsg = (String)request.getAttribute("ErrorMessage");
 }
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<FORM method="post" name="employeetypeadd" action="<%=contextRoot%>/erp/payrollnic/confgeneral/prsetuppys.jsp">
<INPUT type="hidden" name="action" id="action" value="EMPTYPADD">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">

<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="2" class="tableheader">Agregar Tipo de Empleado</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Descripción</TD>
      <TD width="75%"><input type="text" name="name" size="50" maxlength="50" value="<%=name%>"></TD>
    </TR>
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Abreviación</TD>
      <TD width="75%"><input type="text" name="abrv" size="2" maxlength="2" value="<%=abrv%>"></TD>
    </TR>    
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/confgeneral/employeetypelist.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
