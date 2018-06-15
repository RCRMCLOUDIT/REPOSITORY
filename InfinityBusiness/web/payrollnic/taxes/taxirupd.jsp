<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Actualizar Detalle IR</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.minAmt.focus()">
<%! 
 static final String title = "Actualizar Detalle IR"; 

 static final int IR_CUR = 1;

 static final int IRMINAMT_COLUMN		= 1; 
 static final int IRMAXAMT_COLUMN		= 2; 
 static final int IRPERCENT_COLUMN		= 3; 
 static final int IRBASAMT_COLUMN		= 4; 
 static final int IROVRAMT_COLUMN		= 5;                             
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
 
 String taxId 		= request.getParameter("taxId")==null?"":request.getParameter("taxId");  
 String minAmt 		= request.getParameter("minAmt")==null?"":request.getParameter("minAmt");
 String maxAmt 		= request.getParameter("maxAmt")==null?"":request.getParameter("maxAmt");
 String percentage	= request.getParameter("percentage")==null?"":request.getParameter("percentage");
 String baseAmt 	= request.getParameter("baseAmt")==null?"":request.getParameter("baseAmt");
 String overAmt 	= request.getParameter("overAmt")==null?"":request.getParameter("overAmt");    
 
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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRTAXIRS('" + 
 					companyID + "',0," + Id + "," + taxId + ",0,0,0,0,0,'','','IREDT',?,?)}"; 					 
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
		minAmt 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(IRMINAMT_COLUMN,0,IR_CUR)).toString().trim();
		maxAmt 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(IRMAXAMT_COLUMN,0,IR_CUR)).toString().trim();
		percentage	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(IRPERCENT_COLUMN,0,IR_CUR)).toString().trim();
		baseAmt 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(IRBASAMT_COLUMN,0,IR_CUR)).toString().trim();
		overAmt 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(IROVRAMT_COLUMN,0,IR_CUR)).toString().trim();
			 
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 } 
 %>
<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/taxes/prtaxirs.jsp">
<INPUT type="hidden" name="action" id="action" value="IRUPD">
<INPUT type="hidden" name="Id" id="Id" value="<%=Id%>">
<INPUT type="hidden" name="taxId" id="taxId" value="<%=taxId%>">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR class="tableheader">
    	<TD colspan="2">Actualizar Detalle IR</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Desde</TD>
      <TD width="75%"><input type="text" name="minAmt" size="15" maxlength="15" value="<%=minAmt%>"></TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Hasta</TD>
      <TD width="75%"><input type="text" name="maxAmt" size="15" maxlength="15" value="<%=maxAmt%>"></TD>
    </TR> 
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Porcentaje (%)</TD>
      <TD><input type="text" name="percentage" size="5" maxlength="5" value="<%=percentage%>"></TD>
	</TR> 
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Base</TD>
      <TD width="75%"><input type="text" name="baseAmt" size="15" maxlength="15" value="<%=baseAmt%>"></TD>
    </TR> 	   
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Exceso</TD>
      <TD width="75%"><input type="text" name="overAmt" size="15" maxlength="15" value="<%=overAmt%>"></TD>
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
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/taxes/taxirlist.jsp?taxId=<%=taxId%>';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
