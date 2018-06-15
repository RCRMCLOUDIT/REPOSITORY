<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<%@ page import="com.cap.util.*,java.net.InetAddress,java.net.URL,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<TITLE>Nueva Liquidacion</TITLE>
</HEAD>
<%! 
 static final String title = "Nueva Liquidacion";  
 
 static final int EMPLTYP_CUR 	= 1; //EMPLOYEE TYPES CURSOR
 static final int CONCEPTS_CUR  = 2; //CONCEPTS CURSOR
%>
<BODY onload="myForm.intDate.focus();">
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/searchemployees.js"></SCRIPT>
<%
 String intDate			= request.getParameter("intDate")==null?Format.getSysDate():request.getParameter("intDate");
 String endDate			= request.getParameter("endDate")==null?Format.getSysDate():request.getParameter("endDate");
 String employeeId 		= request.getParameter("employeeId")==null?"0":request.getParameter("employeeId"); 
 String employeeName	= request.getParameter("employeeNanme")==null?"":request.getParameter("employeeNanme"); 
 
 String reazonId 		= request.getParameter("reazonId")==null?"":request.getParameter("reazonId"); 
 
 String contextRoot = request.getContextPath(); 
 
  String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLLIQS('" + 
 					companyID + "',0,0,'','',0,'','','','','','EMPLIQENT','','','',0,?,?)}";

 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="entryDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="entryDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="entryDBBean" />
</jsp:useBean>
<%
 entryDBBean.execute(); 
%>
<FORM name="myForm" method="post" action="<%=request.getContextPath()%>/erp/payrollnic/liquidation/premplliqs.jsp" onsubmit='return oid_lookup(myForm);'>
<INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
<INPUT type="hidden" name="action" value="EMPLIQPRL">

<TABLE width="600" border="0" class="Border" cellpadding="0" cellspacing="1">
    <TR class="pcrinfo">
		<TD class="label" nowrap><span class="textRed">*</span>Fecha de Liquidacion</TD>
		<TD>
			<INPUT type="text" name="intDate" value="<%=intDate%>" size="10" maxlength="10" onkeyup="addSlash(myForm.intDate)" onchange="formatDate(myForm.intDate)" onkeypress="OnlyDigits();addSlash(myForm.intDate)" onkeydown="return checkArrows(this, event)">
			<IMG id="cal" border="0" onclick="popUpCalendar(this, myForm.intDate, 'mm/dd/yyyy', -1, -1);" alt="Calendar" src="../../ERP_COMMON/images/popcalendar/calendar.gif">
		</TD>
    </TR>
    <TR class="pcrinfo1">
      	<TD class="label" nowrap><span class="textRed">*</span>Fecha Final Empleado</TD>
		<TD><INPUT type="text" name="endDate" value="<%=endDate%>" size="10" maxlength="10" onkeyup="addSlash(myForm.endDate)" onchange="formatDate(myForm.endDate)" onkeypress="OnlyDigits();addSlash(myForm.endDate)" onkeydown="return checkArrows(this, event)">
		<IMG id="cal" border="0" onclick="popUpCalendar(this, myForm.endDate, 'mm/dd/yyyy', -1, -1);" alt="Calendar" src="../../ERP_COMMON/images/popcalendar/calendar.gif">
	</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Empleado</TD>
      <TD nowrap align="left" colspan="3">
		<INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
 		<INPUT type="text" class="text"	size="50" maxlength="40" name="employeeName" id="employeeName" value="<%=employeeName%>" onchange="this.form.employeeId.value='';" onkeypress='if(isEnterPressed()) openSEmployeesDialog((myForm, "employeeId", "employeeName", 0, "<%= request.getContextPath()%>","","");'>
		<INPUT type="button" name="searchEmp" value=" v " onclick='openSEmployeesDialog(myForm, "employeeId", "employeeName", 0, "<%= request.getContextPath()%>","","");'>      
      </TD>    
     </TR>     
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Empleado</TD>
	  <TD>
		  <SELECT size="1" name="reazonId" class="text">
	    	  <OPTION value="RD" <%=reazonId.equals("RD")?"selected": ""%>>RENUNCIA CON 15 DIAS</OPTION>
	    	  <OPTION value="RI" <%=reazonId.equals("RI")?"selected": ""%>>RENUNCIA INMEDIATA</OPTION>
	    	  <OPTION value="AT" <%=reazonId.equals("AT")?"selected": ""%>>ABANDONO TRABAJO</OPTION>
	    	  <OPTION value="MA" <%=reazonId.equals("MA")?"selected": ""%>>MUTUO ACUERDO</OPTION>
	    	  <OPTION value="EC" <%=reazonId.equals("EC")?"selected": ""%>>EXPIRACION DE CONTRATO DETERMINADO</OPTION>
	    	  <OPTION value="RC" <%=reazonId.equals("RC")?"selected": ""%>>RESCICIÓN DE CONTRATO ART.45 CT</OPTION>
	    	  <OPTION value="RJ" <%=reazonId.equals("RJ")?"selected": ""%>>RESCICIÓN DE CONTRATO-JUBILACIÓN</OPTION>
	    	  <OPTION value="RI" <%=reazonId.equals("RI")?"selected": ""%>>RESCICIÓN DE CONTRATO-INVALIDEZ TOTAL</OPTION>
	    	  <OPTION value="RM" <%=reazonId.equals("RM")?"selected": ""%>>RESCICIÓN DE CONTRATO-MUERTE</OPTION>
	    	  <OPTION value="RP" <%=reazonId.equals("RP")?"selected": ""%>>RESCICIÓN DE CONTRATO-PENA CONDENATORIA</OPTION>
	    	  <OPTION value="NP" <%=reazonId.equals("NP")?"selected": ""%>>NO PASA PERIODO DE PRUEBA ART.28</OPTION>
	  	</SELECT>
	  </TD>	 	
  </TABLE>
<%
  entryDBBean.closeResultSet();
%>		
  
 <TABLE width="600" border="0" cellpadding="0" cellspacing="1">
    <TR>
      <TD align="center">
      	<INPUT name="submit" type="submit" class="button" value="<%=rb.getString("B00013")%> >>">&nbsp;&nbsp;&nbsp;&nbsp; 
       	<INPUT name="Reset" type="reset" class="button" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
       	<INPUT name="Cancel" type="button" class="button" value="<%=rb.getString("B00010")%>" onclick="window.location='<%=contextRoot%>/erp/payrollnic/liquidation/liquidationlist.jsp';">&nbsp;&nbsp;&nbsp;&nbsp;
		<INPUT type="button" name="exit" value="<%=rb.getString("B00029")%>" class="button" onclick="window.close();">
    </TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
