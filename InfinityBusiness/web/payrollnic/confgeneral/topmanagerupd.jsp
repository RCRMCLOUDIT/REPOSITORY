<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Editar Gerencia</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.topmanagerupd.name.focus()">
<%@ page errorPage="../../ERP_COMMON/error.jsp" import="com.cap.util.*" %>
<%! 
 static final String title = "Editar Gerencia";  
 
 static final int TOPMNGR_CUR = 1;

 static final int NM_COLUMN	= 1;

%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 *******************************************************************************/
 String name 		= request.getParameter("name")==null?"":request.getParameter("name");
 String Id			= request.getParameter("Id")==null?"0":request.getParameter("Id");
 String startIndex 	= request.getParameter("startIndex")==null?"0":request.getParameter("startIndex");
 
 String contextRoot = request.getContextPath();

 String errMsg = null;

 /*******************************************************************************
 * In case we are comming from the command page due some error, the updateDBBean
 * object already exists from that page. It must be create in request scope
 *******************************************************************************/
 if (returnWithError.equals("Y"))
 {
       errMsg = (String)request.getAttribute("ErrorMessage");
 }

 /*******************************************************************************
 * build the sqlString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRSETUPPYS('" + 
 					companyID + "',0," + Id + ",'','',0,'','','',0,0,'','','TPMNGREDT',?,?)}"; 
 System.out.println("sqlString = " + sqlString);  	
%>
<jsp:useBean id="updateDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="updateDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="updateDBBean" />
</jsp:useBean>
<%
 updateDBBean.execute();
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<%
 if (returnWithError.equals("N"))
 { 
	 try
	 {
		name = (String)updateDBBean.valueAtColumnRowResult(NM_COLUMN,0,TOPMNGR_CUR).toString().trim(); 
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 }
%>
<FORM method="post" name="topmanagerupd" action="<%=contextRoot%>/erp/payrollnic/confgeneral/prsetuppys.jsp">
<INPUT type="hidden" name="action" id="action" value="TPMNGRUPD">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<INPUT type="hidden" name="startIndex" id="startIndex" value="<%=startIndex%>">
<INPUT type="hidden" name="Id" id="Id" value="<%=Id%>">

<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="2" class="tableheader">Editar Gerencia</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Nombre</TD>
      <TD width="75%"><input type="text" name="name" size="50" maxlength="50" value="<%=name%>"></TD>
    </TR>     
<%
  updateDBBean.closeResultSet();
%>
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/confgeneral/topmanagerlist.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
