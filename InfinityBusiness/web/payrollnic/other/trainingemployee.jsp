<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css"
	type="text/css">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Configuar Empleados</title>
</head>

<body onload="javascript: document.myForm.employeeName.focus(); document.myForm.bank.disabled=true; document.myForm.accountNum.disabled=true;">
<%@ page errorPage="../../ERP_COMMON/error.jsp" import="java.math.*,com.cap.util.*, java.util.*" %>
<%! 
 static final String title = "Control de Capacitaciones"; 
 %>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_charcounterJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/charcounter.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/employee.js"></SCRIPT>

<%
String contextRoot	= request.getContextPath();

String birthDate		= request.getParameter("birthDate")==null?Format.getSysDate():request.getParameter("birthDate");
String employeeName		= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
%>

<FORM name="myForm" method="post" action="">
<table width="750" class="Border">
	<tbody>
		<tr class="tableheader">
			<td colspan="6">Cursos y Capacitaciones</td>
		</tr>
		<tr class="tableheader">
			<td>Centro de Capacitacion</td>
			<td width="82">Desde</td>
			<td width="89">Hasta</td>
			<td width="140">Nombre de Curso</td>
			<td>Aprobo</td>			
			<td>Observaciones</td>		
		</tr>
		<tr class="pcrinfo1">
			<td class="label"><input type="text" size="25" maxlength="16"
				name="identification010" value="Cap Computer Consultants INC"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="82"><input size="9" name="birthDate" value="07/01/2004"
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate)"
				onchange="formatDate(myForm.birthDate)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar">			
			</td>
			<td class="label" width="89"><input size="10" name="birthDate0"
				value="08/05/2004" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate0)"
				onchange="formatDate(myForm.birthDate0)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate0)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate0, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="140"><input type="text" size="20" maxlength="16"
				name="identification1" value="Websphere and Visual Age for Java"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre01">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>				
			<td><textarea rows="2" cols="20" name="Observacion"></textarea></td>			
		</tr>
		<tr class="pcrinfo">
			<td class="label"><input type="text" size="25" maxlength="16"
				name="identification011" value="Cap Computer Consultants INC"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="82"><input size="8" name="birthDate1"
				value="06/28/2006" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate1)"
				onchange="formatDate(myForm.birthDate1)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate1)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate1, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td class="label" width="89"><input size="8" name="birthDate2"
				value="08/20/2006" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate2)"
				onchange="formatDate(myForm.birthDate2)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate2)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate2, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="140"><input type="text" size="20" maxlength="16"
				name="identification" value="JSP Servlets and webcomponents"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre01">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>				
			<td><textarea rows="2" cols="20" name="Observacion0"></textarea></td>						
		</tr>
		<tr class="pcrinfo1">
			<td class="label"><input type="text" size="25" maxlength="16"
				name="identification012" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="82"><input size="8" name="birthDate3"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate3)"
				onchange="formatDate(myForm.birthDate3)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate3)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate3, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td class="label" width="89"><input size="8" name="birthDate4"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate4)"
				onchange="formatDate(myForm.birthDate4)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate4)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate4, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="140"><input type="text" size="20" maxlength="16"
				name="identification2" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre01">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>				
			<td><textarea rows="2" cols="20" name="Observacion1"></textarea></td>						
		</tr>
		<tr class="pcrinfo">
			<td class="label"><input type="text" size="25" maxlength="16"
				name="identification013" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="82"><input size="8" name="birthDate5"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate5)"
				onchange="formatDate(myForm.birthDate5)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate5)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate5, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td class="label" width="89"><input size="8" name="birthDate6"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate6)"
				onchange="formatDate(myForm.birthDate6)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate6)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate6, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="140"><input type="text" size="20" maxlength="16"
				name="identification3" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre01">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>				
			<td><textarea rows="2" cols="20" name="Observacion2"></textarea></td>						
		</tr>
		<tr class="pcrinfo1">
			<td class="label"><input type="text" size="25" maxlength="16"
				name="identification014" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="82"><input size="8" name="birthDate7"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate7)"
				onchange="formatDate(myForm.birthDate7)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate7)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate7, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td class="label" width="89"><input size="8" name="birthDate9"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate9)"
				onchange="formatDate(myForm.birthDate9)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate9)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate9, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="140"><input type="text" size="20" maxlength="16"
				name="identification4" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre01">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>				
			<td><textarea rows="2" cols="20" name="Observacion3"></textarea></td>						
		</tr>
		<tr>
			<td><INPUT type="button" name="Save" value="Agregar Mas Lineas" class="button"  onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/employee/listconfemployee.jsp';">&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
	</tbody>
</table>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="button" name="Save" value="<%=rb.getString("B00008")%>" class="button"  onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/employee/listconfemployee.jsp';">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/employee/listconfemployee.jsp';">
</TD>
</TR>
</TABLE>

</form>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</body>
</html>