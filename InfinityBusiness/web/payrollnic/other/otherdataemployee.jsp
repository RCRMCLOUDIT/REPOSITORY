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
 static final String title = "Datos Generales Empleado"; 
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
			<td colspan="7">Otro Datos del Empleado</td>
		</tr>
		<tr class="tableheader">
			<td colspan="7">Formacion Academica</td>		
		</tr>
		<tr class="tableheader">
			<td>Empleado</td>
			<td align="left" colspan = "6">
				<INPUT type="hidden" name="employeeId" id="employeeId" value=""> 
				<INPUT type="text" class="text" size="57" maxlength="40"
				name="employeeName" id="employeeName" value="<%=employeeName%>"
				onchange="this.form.employeeId.value='';"
				onkeypress='if(isEnterPressed()) receipt_search(myForm, "EMP","<%=contextRoot%>");'>
				<INPUT type="button" name="searchEmp" value=" v " onclick='receipt_search(myForm,"EMP","<%= contextRoot %>");'>			
			</td>
		</tr>
		<tr class="tableheader">
			<td align = "center"></td>
			<td align = "center">Centro de Estudio</td>
			<td align = "center" width="94">Desde</td>
			<td align = "center" width="137">Hasta</td>
			<td align = "center" width="174">Titulo Obtenido</td>
			<td align = "center">Comprobacion</td>
			<td align = "center">Observaciones</td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">PRIMARIA</td>
			<td width="177">
				<input type="text" size="25" maxlength="16" name="identification0"
				value="Lincoln International Academy" onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input size="9" name="birthDate00"
				value="08/15/1991" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate00)"
				onchange="formatDate(myForm.birthDate00)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate00)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate00, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137">			
			<input size="9" name="birthDate01" value="06/30/1995" maxlength="10"
				type="text" onkeyup="addSlash(myForm.birthDate01)"
				onchange="formatDate(myForm.birthDate01)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate01)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate01, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="174"><input type="text" size="19" maxlength="16"
				name="identification09" value="PRIMARIA"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre0">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>
			<td><textarea rows="2" cols="20" name="Observacion4"></textarea></td>				
		</tr>
		<tr class="pcrinfo1">
			<td class="label">SECUNDARIA</td>
			<td width="177"><input type="text" size="25" maxlength="16"
				name="identification04" value="Lincoln International Academy"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input size="9" name="birthDate02"
				value="08/15/1995" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate02)"
				onchange="formatDate(myForm.birthDate02)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate02)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate02, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input size="9" name="birthDate03" value="06/30/2002"
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate03)"
				onchange="formatDate(myForm.birthDate03)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate03)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate03, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="174"><input type="text" size="19" maxlength="16"
				name="identification090" value="BACHILLER"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre00">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>
			<td><textarea rows="2" cols="20" name="Observacion5"></textarea></td>				
		</tr>
		<tr class="pcrinfo">
			<td class="label">SUPERIOR 1</td>
			<td width="177"><input type="text" size="25" maxlength="16"
				name="identification05" value="UCC"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input size="9" name="birthDate04"
				value="02/17/2003" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate04)"
				onchange="formatDate(myForm.birthDate04)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate04)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate04, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input size="9" name="birthDate05" value="12/10/2006"
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate05)"
				onchange="formatDate(myForm.birthDate05)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate05)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate05, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="174"><input type="text" size="19" maxlength="16"
				name="identification091" value="ING. SISTEMAS"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre01">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>
			<td><textarea rows="2" cols="20" name="Observacion6"></textarea></td>			
		</tr>
		<tr class="pcrinfo1">
			<td class="label">SUPERIOR 2</td>
			<td width="177"><input type="text" size="25" maxlength="16"
				name="identification06" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input size="8" name="birthDate06"
				value="" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate06)"
				onchange="formatDate(myForm.birthDate06)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate06)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate06, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input size="8" name="birthDate07" value=""
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate07)"
				onchange="formatDate(myForm.birthDate07)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate07)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate07, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="174"><input type="text" size="19" maxlength="16"
				name="identification092" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre02">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>
			<td><textarea rows="2" cols="20" name="Observacion7"></textarea></td>			
		</tr>
		<tr class="pcrinfo">
			<td class="label">SUPERIOR 3</td>
			<td width="177"><input type="text" size="25" maxlength="16"
				name="identification07" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input size="8" name="birthDate08"
				value="" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate08)"
				onchange="formatDate(myForm.birthDate08)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate08)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate08, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input size="8" name="birthDate09" value=""
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate09)"
				onchange="formatDate(myForm.birthDate09)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate09)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate09, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="174"><input type="text" size="19" maxlength="16"
				name="identification093" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre03">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>
			<td><textarea rows="2" cols="20" name="Observacion8"></textarea></td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label">SUPERIOR 4</td>
			<td width="177"><input type="text" size="25" maxlength="16"
				name="identification08" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input size="8" name="birthDate010"
				value="" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate010)"
				onchange="formatDate(myForm.birthDate010)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate010)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate010, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input size="8" name="birthDate011" value=""
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate011)"
				onchange="formatDate(myForm.birthDate011)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate011)"
				onkeydown="return checkArrows(this, event)"><img
				src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0"
				onclick="popUpCalendar(this, myForm.birthDate011, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="174"><input type="text" size="19" maxlength="16"
				name="identification094" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre04">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>
			<td><textarea rows="2" cols="20" name="Observacion9"></textarea></td>
		</tr>
		<tr class="tableheader">
			<td colspan="7">Experiencia Laboral</td>
		</tr>
		<tr class="tableheader">
			<td>Centro de Trabajo</td>
			<td>Desde</td>
			<td width="94">Hasta</td>
			<td width="137">Cargo</td>
			<td>Remuneracion</td>
			<td>Comprobacion</td>			
			<td>Observaciones</td>		
		</tr>
		<tr class="pcrinfo1">
			<td class="label"><input type="text" size="25" maxlength="16"
				name="identification010" value="CAP COMPUTER CONSULTANTS S.A"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="177"><input size="9" name="birthDate" value="03/15/2003"
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate)"
				onchange="formatDate(myForm.birthDate)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar">			
			</td>
			<td class="label" width="94"><input size="10" name="birthDate0"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate0)"
				onchange="formatDate(myForm.birthDate0)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate0)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate0, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input type="text" size="20" maxlength="16"
				name="identification1" value="Gerente General"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><input type="text" size="19" maxlength="16"
				name="identification0940" value="25,000"
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
				name="identification011" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="177"><input size="8" name="birthDate1"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate1)"
				onchange="formatDate(myForm.birthDate1)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate1)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate1, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td class="label" width="94"><input size="8" name="birthDate2"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate2)"
				onchange="formatDate(myForm.birthDate2)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate2)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate2, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input type="text" size="20" maxlength="16"
				name="identification" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><input type="text" size="19" maxlength="16"
				name="identification0941" value=""
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
			<td width="177"><input size="8" name="birthDate3"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate3)"
				onchange="formatDate(myForm.birthDate3)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate3)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate3, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td class="label" width="94"><input size="8" name="birthDate4"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate4)"
				onchange="formatDate(myForm.birthDate4)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate4)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate4, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input type="text" size="20" maxlength="16"
				name="identification2" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><input type="text" size="19" maxlength="16"
				name="identification0942" value=""
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
			<td width="177"><input size="8" name="birthDate5"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate5)"
				onchange="formatDate(myForm.birthDate5)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate5)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate5, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td class="label" width="94"><input size="8" name="birthDate6"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate6)"
				onchange="formatDate(myForm.birthDate6)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate6)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate6, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input type="text" size="20" maxlength="16"
				name="identification3" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><input type="text" size="19" maxlength="16"
				name="identification0943" value=""
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
			<td width="177"><input size="8" name="birthDate7"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate7)"
				onchange="formatDate(myForm.birthDate7)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate7)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate7, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td class="label" width="94"><input size="8" name="birthDate9"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate9)"
				onchange="formatDate(myForm.birthDate9)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate9)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate9, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
			<td width="137"><input type="text" size="20" maxlength="16"
				name="identification4" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><input type="text" size="19" maxlength="16"
				name="identification0944" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td align="center"><select size="1" name="emplyeeGenre01">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>				
			<td><textarea rows="2" cols="20" name="Observacion3"></textarea></td>						
		</tr>
		<tr class="tableheader">
			<td colspan="7">Referencias Personales</td>
		</tr>
		<tr class="tableheader">
			<td>Nombre</td>
			<td>Empresa</td>
			<td>Cargo</td>
			<td>Direccion</td>
			<td>Email</td>
			<td>Telefono</td>
			<td>Movil</td>

		</tr>
		<tr class="pcrinfo">
			<td class="label"><input type="text" size="25" maxlength="16"
				name="identification0140" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="177">
			<input type="text" size="25" maxlength="16" name="identification0100"
				value="" onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input type="text" size="20"
				maxlength="16" name="identification10" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><input type="text" size="14" maxlength="16"
				name="identification100" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="177" align="center">
			<input type="text" size="14" maxlength="16" name="identification1001"
				value="" onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94" align="center"><input type="text" size="14"
				maxlength="16" name="identification1003" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><input type="text" size="14" maxlength="16"
				name="identification1005" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>			
		</tr>
		<tr class="pcrinfo1">
			<td class="label"><input type="text" size="25" maxlength="16"
				name="identification0141" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="177">
				<input type="text" size="25" maxlength="16"
				name="identification0101" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input type="text" size="20"
				maxlength="16" name="identification11" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><input type="text" size="14" maxlength="16"
				name="identification1000" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="177" align="center">
			<input type="text" size="14" maxlength="16" name="identification1002"
				value="" onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94" align="center"><input type="text" size="14"
				maxlength="16" name="identification1004" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><input type="text" size="14" maxlength="16"
				name="identification1006" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>			
		</tr>
		<tr class="pcrinfo">
			<td class="label"><input type="text" size="25" maxlength="16" name="identification0141" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td class="label" width="177">
				<input type="text" size="25" maxlength="16" name="identification0101" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td class="label" width="94"><input type="text" size="20" maxlength="16" name="identification11" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td width="137" align="center"><input type="text" size="14" maxlength="16" name="identification1000" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td width="177" align="center">
			<input type="text" size="14" maxlength="16" name="identification1002" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td class="label" width="94" align="center"><input type="text" size="14" maxlength="16" name="identification1004" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td width="137" align="center"><input type="text" size="14" maxlength="16" name="identification1006" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td>

		</tr>
		<tr class="pcrinfo1">
			<td class="label"><input type="text" size="25" maxlength="16" name="identification0141" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td class="label" width="177">
				<input type="text" size="25" maxlength="16" name="identification0101" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td class="label" width="94"><input type="text" size="20" maxlength="16" name="identification11" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td width="137" align="center"><input type="text" size="14" maxlength="16" name="identification1000" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td width="177" align="center">
			<input type="text" size="14" maxlength="16" name="identification1002" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td class="label" width="94" align="center"><input type="text" size="14" maxlength="16" name="identification1004" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td><td width="137" align="center"><input type="text" size="14" maxlength="16" name="identification1006" value="" onkeyup="formatCEDID(myForm.identification)" onkeypress="formatCEDID(myForm.identification)"></td>

		</tr>
		<tr class="tableheader">
			<td colspan="7">Familiares</td>
		</tr>
		<tr class="tableheader">
			<td>Parentesco</td>
			<td>Nombre</td>
			<td>Edad</td>
			<td>Direccion</td>
			<td>Email</td>
			<td>Telefono</td>
			<td>Avisar en Caso de Emergencai</td>			
		</tr>
		<tr class="pcrinfo">
			<td class="label"><select size="1" name="frequencyPayment">
				<option value="E" selected>Esposa</option>
				<option value="M">Madre</option>
				<option value="P">Padre</option>
				<option value="H">Hijo</option>				
				<option value="M">Hermano</option>				
				<option value="T">Tio</option>								
			</select></td>
			<td width="177"><input type="text" size="25" maxlength="16"
				name="identification01400" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94" align="center"><input type="text" size="9"
				maxlength="16" name="identification014000" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><input type="text"
				size="14" maxlength="16" name="identification1007" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="177" align="center"><input type="text" size="14" maxlength="16"
				name="identification10010" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input type="text" size="14"
				maxlength="16" name="identification10030" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><select size="1" name="emplyeeGenre090">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>			
		</tr>
		<tr class="pcrinfo1">
			<td class="label"><select size="1" name="frequencyPayment0">
				<option value="E" selected>Esposa</option>
				<option value="M">Madre</option>
				<option value="P">Padre</option>
				<option value="H">Hijo</option>
				<option value="M">Hermano</option>
				<option value="T">Tio</option>
			</select></td>
			<td width="177"><input type="text" size="25" maxlength="16"
				name="identification01401" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94" align="center"><input type="text" size="9"
				maxlength="16" name="identification0140000" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><input type="text" size="14" maxlength="16"
				name="identification10070" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="177" align="center"><input type="text" size="14" maxlength="16"
				name="identification10011" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input type="text" size="14"
				maxlength="16" name="identification10031" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><select size="1" name="emplyeeGenre091">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>			
		</tr>
		<tr class="pcrinfo">
			<td class="label"><select size="1" name="frequencyPayment1">
				<option value="E" selected>Esposa</option>
				<option value="M">Madre</option>
				<option value="P">Padre</option>
				<option value="H">Hijo</option>
				<option value="M">Hermano</option>
				<option value="T">Tio</option>
			</select></td>
			<td width="177"><input type="text" size="25" maxlength="16"
				name="identification01402" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94" align="center"><input type="text" size="9"
				maxlength="16" name="identification0140001" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><input type="text" size="14" maxlength="16"
				name="identification10071" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="177" align="center"><input type="text" size="14" maxlength="16"
				name="identification10012" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="94"><input type="text" size="14"
				maxlength="16" name="identification10032" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td width="137" align="center"><select size="1" name="emplyeeGenre092">
				<option value="S" selected>Si</option>
				<option value="N">No</option>
			</select></td>			
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