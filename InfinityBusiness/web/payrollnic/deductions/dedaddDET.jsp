<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Agregar Deduccion</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.employeeName.focus()">	
<%! 
 static final String title = "Agregar Prestamo/Deduccion"; 
%>

<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_charcounterJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/charcounter.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/mainpayroll.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/searchemployees.js"></SCRIPT>

<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 ********************************************************************************/
 String employeeId 		= request.getParameter("employeeId")==null?"0":request.getParameter("employeeId");
 String employeeName    = request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String loanId	 		= request.getParameter("loanId")==null?"0":request.getParameter("loanId");
 String deductionId		= request.getParameter("deductionId")==null?"0":request.getParameter("deductionId");
 String fpayDate		= request.getParameter("fpayDate")==null?Format.getSysDate():request.getParameter("fpayDate");
 String dedName		 	= request.getParameter("dedName")==null?"":request.getParameter("dedName");
 
 String payrollId		= request.getParameter("payrollId")==null?"":request.getParameter("payrollId");
 
 String payAmt     	= request.getParameter("payAmt")==null?"0.00":request.getParameter("payAmt");
 String numDue	 	= request.getParameter("numDue")==null?"0":request.getParameter("numDue");
     
 String contextRoot = request.getParameter("contextRoot");

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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRLOANS('" + 
 					companyID + "',0,0,"+ deductionId +",0,'','',0,0,'','LOANDTN','" + user_ID + "','" + Format.getIPAddress(request).trim() + "',0,'',0,0,?,?)}"; 
 					 
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="addDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="addDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="addDBBean" />
</jsp:useBean>
<%
 addDBBean.execute(); 
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />

<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/deductions/prloans.jsp">
<INPUT type="hidden" name="action" id="action" value="LOANDTA">
<INPUT type="hidden" name="deductionId" id="deductionId" value="<%=deductionId%>">
<INPUT type="hidden" name="loanId" id="loanId" value="<%=loanId%>">
<INPUT type="hidden" name="dedName" id="dedName" value="<%=dedName%>">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="4" class="tableheader">Agregar Detalle de Cuota</TD>
    </TR>   
    <TR>
      <TD colspan="4" class="tableheader"><%=dedName%></TD>
    </TR>   
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Id Nomina</TD>
      <TD>
      	<input type="text" name="payrollId" value="<%=payrollId%>" size="5" maxlength="9">
      </TD> 
    </TR>    
   <TR class="pcrinfo1"> 
   	  <TD class="label">Fecha de Pago</TD>	
      <TD>
       <INPUT size="12" maxlength="10" type="text" name="fpayDate" class="pcrInfo" value="<%=fpayDate%>" onKeyUp="addSlash(myForm.fpayDate)" onChange="formatDate(myForm.fpayDate)" onKeyPress="OnlyDigits();addSlash(myForm.fpayDate)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.fpayDate, 'mm/dd/yyyy', 350, -1);" alt="Calendar">            
      </TD>
   </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Monto de Pago</TD>
      <TD width="75%">
      	<input type="text" name="payAmt" value="<%=payAmt%>" size="21" maxlength="10">
      </TD>			
    </TR>
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Cuota #</TD>
      <TD><input type="text" name="numDue" size="2" maxlength="4" value="<%=numDue%>"></TD>			
    </TR>        	        
<%
  addDBBean.closeResultSet();
%>		
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/deductions/dedlistDET.jsp?deductionId=<%=deductionId%>&loanId=<%=loanId%>&dedName=<%=dedName%>';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
