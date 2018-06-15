<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Saldos de Prestamos X Empleado</TITLE>
</HEAD>
<%! 
 static final String title = "Saldos de Prestamos X Empleado";  
 %>

<BODY onload="myForm.fDate.focus();">
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/employee.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/mainpayroll.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/searchemployees.js"></SCRIPT>
<%
/* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 ********************************************************************************/

 String employeeId		= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String tDate			= request.getParameter("tDate")==null?"":request.getParameter("tDate");
 String reportType		= request.getParameter("reportType")==null?"SCR":request.getParameter("reportType");
  
 String contextRoot = request.getContextPath(); 
 
 String errMsg 	= null;
 String code 	= "";	
 String descr 	= ""; 
			
%>

<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/deductions/loanrpthtml.jsp">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="4" class="tableheader">Parametros Reporte Prestamos</TD>
    </TR>
        <TR class="pcrinfo">
          <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Empleado</TD>
      <TD>
      	<INPUT type="hidden" name="emplSalQ" value="">    
		<INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
 		<INPUT size="30" name="employeeName" type="text" class="text"	maxlength="50" value="<%=employeeName%>" id="employeeName"  onchange="this.form.employeeId.value='';" onkeypress='if(isEnterPressed()) openSEmployeesDialog("myForm", "employeeId", "employeeName", "", "<%= request.getContextPath()%>","emplSalQ");' autocomplete="off" class="search search-icon">
		<INPUT type="button" class="button" name="searchEmp" value=" v " onclick='openSEmployeesDialog("myForm", "employeeId", "employeeName", "" , "<%= request.getContextPath()%>","emplSalQ");'>            
      </TD> 
    </TR>
	<TR class="pcrinfo1">
      	<TD class="label" nowrap><span class="textRed">*</span>Fecha de Corte</TD>
		<TD><INPUT type="text" name="tDate" value="<%=tDate%>" size="10" maxlength="10" onkeyup="addSlash(myForm.tDate)" onchange="formatDate(myForm.tDate)" onkeypress="OnlyDigits();addSlash(myForm.tDate)" onkeydown="return checkArrows(this, event)"><IMG id="cal" border="0" onclick="popUpCalendar(this, myForm.tDate, 'mm/dd/yyyy', -1, -1);" alt="Calendar" src="../../ERP_COMMON/images/popcalendar/calendar.gif"></TD>
    </TR>
      <TR class="pcrinfo">
		<TD class="label" nowrap><span class="textRed">*</span>Tipo de Reporte</TD>
		<TD class="label">    
	   		<input type="radio" name="reportType" value="SCR" <%=reportType.equals("SCR")?"checked":""%>>Pantalla 
	   		<input type="radio" name="reportType" value="PDF" <%=reportType.equals("PDF")?"checked":""%>>PDF 
			<input type="radio" name="reportType" value="XLS" <%=reportType.equals("XLS")?"checked":""%>>XLS 
	   </TD>
	</TR>
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="go" value="Continuar >>>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="Reset">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="Cancelar" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/deductions/deductionslist.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>