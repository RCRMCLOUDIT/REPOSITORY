<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Saldos de Prestamos X Empleado</TITLE>
</HEAD>

<BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Estado Cuenta Empleado";
 
static final int LOANS_CUR 	= 1;
static final int LOANDET_CUR 	= 2;
 	
 static final int LNLOANID_COLUMN		= 1;
 static final int PDNAME_COLUMN			= 2;
 static final int EDEMPLNM_COLUMN		= 7;
 static final int LNLOANFDATE_COLUMN	= 6;
 static final int LNLOANTDATE_COLUMN	= 7;
 static final int LNLOANAMT_COLUMN		= 8;
 static final int LNLOANTIM_COLUMN		= 9;
 static final int LNLOANRATE_COLUMN		= 10;
 static final int LNEMPLNUM_COLUMN		= 11;
 static final int LNEMPLNM_COLUMN		= 12;
 	                                  
%>

<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot 	= request.getContextPath(); 
 String employeeId		= request.getParameter("employeeId")==null?"0":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
  String tDate 			= request.getParameter("tDate")==null?"0":request.getParameter("tDate");

 /*String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRLOANS('" + 
 					companyID + "',0,"+ loanId +","+ deductionId +",0,'','',0,0,'','LOANEMP','" + user_ID + "','" 
 					+ Format.getIPAddress(request).trim() + "',0,'',0,0,?,?)}"; */
 
 String sqlString = "SELECT LNLOANID, PDNAME, EDEMPLNM, EDEMPLID, LNLOANFDATE, LNLOANTDATE, LNLOANAMT, LNLOANTIM, LNLOANRATE, COALESCE ((SELECT COALESCE (SUM (LDLODEDAMT), 0) FROM CAPUP_DTA/PRLOANDT";
 										 
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
int startIndex = (request.getParameter("startIndex")==null) ? 0 : Integer.parseInt(request.getParameter("startIndex").trim());
int i = 0;

 String link = "";
 String baseLink = contextRoot + "/erp/payrollnic/deductions/";
 String link1 = baseLink + "prloans.jsp?startIndex=" + startIndex + "&employeeId=";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(LOANDET_CUR);
%>

<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="10">Estado de Cuenta Empleado</TD>    
    </TR>
    <TR class="tableheader">
    	<TD colspan="10">Nombre de Empleado:  <%=(String)listDBBean.valueAtColumnRowResult(LNEMPLNUM_COLUMN,0,LOANS_CUR) + " " + (String)listDBBean.valueAtColumnRowResult(LNEMPLNM_COLUMN,0,LOANS_CUR)%></TD>
	</TR>
    <TR class="tableheader">
      <TD>Id Prestamo</TD>
      <TD>Descr. Prestamo</TD>     
      <TD>Desde</TD>     
      <TD>Hasta</TD>              
      <TD>Monto Total</TD>
      <TD>Plazo Total</TD>
      <TD>Monto Cuota</TD>
      <TD>Monto Total Deducido</TD>
      <TD>Plazo Deducidos</TD>
      <TD>Balance Final</TD>                
    </TR>

</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR>
    	<TD width="30%" height="30">
   		
		</TD>
	    <TD align="center" width="35%" height="30">   
		 <FORM name="Cancel" method="post" action="/Ximple/erp/payrollnic/deductions/deductionslist/loanrptentry.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00010")%>" class="button">
		</FORM>
	    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>