<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Actualizar Detalle Antiguedad</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.years.focus()">
<%! 
 static final String title = "Actualizar Detalle Antiguedad"; 

 static final int IR_CUR = 1;

 static final int AGYEARS_COLUMN		= 1; 
 static final int AGPERCENT_COLUMN		= 2; 
 static final int AGAMOUNT_COLUMN		= 3;                            
%>

<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/taxes.js"></SCRIPT>
<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 ********************************************************************************/

 String Id 			= request.getParameter("Id")==null?"":request.getParameter("Id");  
 
 String wageId 		= request.getParameter("wageId")==null?"":request.getParameter("wageId");  
 String years 		= request.getParameter("years")==null?"":request.getParameter("years");
 String percentage	= request.getParameter("percentage")==null?"":request.getParameter("percentage");
 String amount	 	= request.getParameter("amount")==null?"":request.getParameter("amount");  
 
 String contextRoot = request.getContextPath();

 String errMsg 	= null;

 /*******************************************************************************
 * In case we are comming from the command page due some error, the addCommandDBBean
 * object already exists from that page. It must be create in request scope
 *******************************************************************************/
 if (returnWithError.equals("Y"))
 {
       errMsg = (String)request.getAttribute("ErrorMessage");
 }
 
  /*******************************************************************************
 * build the sqlString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRAGINGS('" + 
 					companyID + "',0," + Id +"," + wageId + ",0,0,0,'','','AGEDT',?,?)}";
 										 
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
		years 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(AGYEARS_COLUMN,0,IR_CUR)).toString().trim();
		percentage	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(AGPERCENT_COLUMN,0,IR_CUR)).toString().trim();
		amount	 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(AGAMOUNT_COLUMN,0,IR_CUR)).toString().trim();
			 
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 } 
 %>
<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/wages/pragings.jsp">
<INPUT type="hidden" name="action" id="action" value="AGUPD">
<INPUT type="hidden" name="Id" id="Id" value="<%=Id%>">
<INPUT type="hidden" name="wageId" id="wageId" value="<%=wageId%>">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR class="tableheader">
    	<TD colspan="2">Actualizar Detalle Antiguedad</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>A�os</TD>
      <TD width="75%"><input type="text" name="years" size="2" maxlength="2" value="<%=years%>"></TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Porcentaje (%)</TD>
      <TD><input type="text" name="percentage" size="5" maxlength="5" value="<%=percentage%>"></TD>
	</TR> 
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Monto</TD>
      <TD width="75%"><input type="text" name="amount" size="15" maxlength="15" value="<%=amount%>"></TD>
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
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/wages/aginglist.jsp?wageId=<%=wageId%>';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
