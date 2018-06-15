<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css"
	type="text/css">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Perfil de Cargo</title>
</head>

<body onload="javascript: document.myForm.employeeName.focus(); document.myForm.bank.disabled=true; document.myForm.accountNum.disabled=true;">
<%@ page errorPage="../../ERP_COMMON/error.jsp" import="java.math.*,com.cap.util.*, java.util.*" %>
<%! 
 static final String title = "Perfil de Cargo"; 
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
			<td colspan="4">Perfil de Cargo</td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label" width="141">Nombre del Cargo</td>
			<td width="364"><%=request.getParameter("jobname")==null?"":request.getParameter("jobname")%></td>
			<td class="label" width="89">Jefe Inmediato</td>
			<td width="140"></td>
		</tr>
		<tr class="pcrinfo">
			<td class="label" width="141">Mision del Cargo</td>
			<td width="364" colspan="3"><textarea rows="4" cols="74"
				name="misionCargo">Para que haya una gestión eficaz de la compañía deberá elaborar, planificar, implementar y mantener los sistemas, procesos, circuitos y procedimientos de información necesarios.
Gestionar la política de tecnologías de la comunicación para que sea adecuada a los objetivos y necesidades de la empresa.
</textarea></td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label" width="141" height="60">Funciones Principales</td>
			<td width="364" colspan="3" height="60"><textarea rows="3" cols="74"
				name="funcionePrincipales">Para que haya una gestión eficaz de la compañía deberá elaborar, planificar, implementar y mantener los sistemas, procesos, circuitos y procedimientos de información necesarios.
Gestionar la política de tecnologías de la comunicación para que sea adecuada a los objetivos y necesidades de la empresa.
</textarea></td>
		</tr>
		<tr class="pcrinfo">
			<td class="label" width="141" height="4">Tareas Relacionadas</td>
			<td width="364" colspan="3" height="4"><textarea rows="4" cols="74"
				name="Tareas Relcionadas">Desarrollo y mantenimiento de sistemas
Análisis y programación de aplicaciones
Ofimática
Gestión de redes
Telecomunicaciones
A veces, en grandes compañías puede hacerse cargo de la creación y mantenimiento de intranets
</textarea></td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label" width="141">Educacion Minima Requerida</td>
			<td width="364" colspan="3"><textarea rows="3" cols="74"
				name="educacionMinima">Titulación universitaria Superior preferentemente Informática o Telecomunicaciones. Estudios de especialización en Gestión Empresarial.
Conocimientos de planificación estratégica de sistemas de información, tecnologías informáticas, mercado de hardware y software.
</textarea></td>
		</tr>
		<tr class="tableheader">
			<td>Idiomas</td>
			<td>Habla</td>
			<td>Lee</td>
			<td>Escribe</td>									
		</tr>
		<tr class="pcrinfo">
			<td>Español</td>
			<td align="center"><input type="checkbox" name="idioma" value="Y"></td>
			<td align="center"><input type="checkbox" name="idioma1" value="Y"></td>
			<td align="center"><input type="checkbox" name="idioma4" value="Y"></td>									
		</tr>
		<tr class="pcrinfo1">
			<td>Ingles</td>
			<td align="center"><input type="checkbox" name="idioma0" value="Y"></td>
			<td align="center"><input type="checkbox" name="idioma2" value="Y"></td>
			<td align="center"><input type="checkbox" name="idioma3" value="Y"></td>									
		</tr>	
		<tr class="pcrinfo">
			<td class="label">Experiencia Minima Requerida
			</td>
			<td colspan="3">
			<textarea rows="5" cols="74" name="experienciaMinima">* Flexibilidad mental de criterios
* Habilidades para la obtención y análisis de información
* Orientación al cliente (interno/externo)
* Interés por la Innovación
* Capacidad de síntesis
* Perspectiva estratégica
</textarea></td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label">Otros Requisitos Deseables</td>
			<td colspan="3">
			<textarea rows="5" cols="74" name="otrosRequisitos">Director de Informática
Director de Tecnologías
Director de Tecnologías de la Información
Jefe de Informática (en pequeñas compañías)
Ing. Information Technology Director

</textarea></td>
		</tr>		
		<tr class="pcrinfo">
			<td class="label">Observaciones del Cargo</td>
			<td colspan="3">
			<textarea rows="5" cols="74" name="observacionesCargo"></textarea></td>
		</tr>			
		<tr class="pcrinfo1">
			<td class="label">Rango de Sueldo De</td>	
			<td><input type="text" name="sueldoDe" size="20"></td>	
			<td class="label">A</td>	
			<td><input type="text" name="sueldoA" size="20"></td>										
		<tr>
		<tr class="pcrinfo">
			<td class="label">Centro de Costo</td>	
			<td colspan="3"><input type="text" name="sueldoDe" size="20" value="Gerencia de Informatica">        	<INPUT type="button" name="dropBoxButtom" value=" v ">	               
			</td>
		</tr>		
	</tbody>
</table>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="button" name="Save" value="<%=rb.getString("B00008")%>" class="button"  onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/employee/listjobprofile.jsp';">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/employee/listjobprofile.jsp';">
</TD>
</TR>
</TABLE>

</form>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</body>
</html>