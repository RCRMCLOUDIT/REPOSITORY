<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css"
	type="text/css">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Configuar Empleados</title>
</head>
<%! 
  	static final String title = "Configuracion Empleados";

	static final int ENTITY_CUR 	= 1;
	static final int CURRENCY_CUR 	= 2;	
	static final int WAGES_CUR 		= 3;	
	static final int ADDITIONS_CUR	= 4;	
	static final int DEDUCTIONS_CUR	= 5;	
	
	static final int WGWAGESID_COLUMN = 1;
	static final int WGNAME_COLUMN 	  = 4;
	static final int WGOVRTMLT_COLUMN = 5;
	static final int WGCOMISION_COLUMN= 6;	
	static final int WGTYPE_COLUMN 	  = 7;	
	
	static final int ADADDID_COLUMN 	= 1;
	static final int ADADNAME_COLUMN 	= 2;
	static final int DESCR_COLUMN 		= 3;
	static final int ADSICKVAC_COLUMN	= 4;     
	static final int ADCLTGRSNT_COLUMN	= 5;
	static final int ADDFTRATE_COLUMN	= 6;
	static final int ADDFTAMNT_COLUMN	= 7;	                        	

	static final int DEDEDUCTID_COLUMN 	= 1;
	static final int DEDENAME_COLUMN 	= 2;
	static final int VENDOR_COLUMN 		= 3;
	static final int DESCR2_COLUMN		= 4;     
	static final int DESICKVAC_COLUMN	= 5;     
	static final int DECLTGRSNT_COLUMN	= 6;
	static final int DEDFTRATE_COLUMN	= 7;
	static final int DEDFTAMNT_COLUMN	= 8;	                        	
 %> 	
<body onload="javascript: document.myForm.employeeName.focus(); document.myForm.bank.disabled=true; document.myForm.accountNum.disabled=true;">
<%@ page errorPage="../../ERP_COMMON/error.jsp" import="java.math.*,com.cap.util.*, java.util.*" %>
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
String employeeId	= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
String employeeName	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
String employeeNum	= request.getParameter("employeeNum")==null?"":request.getParameter("employeeNum");
String employeeAge	= request.getParameter("employeeAge")==null?"":request.getParameter("employeeAge");
String employeeType	= request.getParameter("employeeType")==null?"":request.getParameter("employeeType");
String employeeGenre= request.getParameter("employeeGenre")==null?"":request.getParameter("employeeGenre");

String jobId		= request.getParameter("jobId")==null?"":request.getParameter("jobId");
String gainsAging	= request.getParameter("gainsAging")==null?"N":request.getParameter("gainsAging"); 

String identification	= request.getParameter("identification")==null?"":request.getParameter("identification");

String birthDate		= request.getParameter("birthDate")==null?Format.getSysDate():request.getParameter("birthDate");

String frequencyPayment = request.getParameter("frequencyPayment")==null?Format.getSysDate():request.getParameter("frequencyPayment");
String basicIncome		= request.getParameter("basicIncome")==null?"0.00":request.getParameter("basicIncome");

String entType 			= request.getParameter("entType")==null?"0.00":request.getParameter("entType");

String empCustId		= request.getParameter("empCustId")==null?"":request.getParameter("empCustId");
String empCustIdText	= request.getParameter("empCustIdText")==null?"":request.getParameter("empCustIdText");

String currencyId		= request.getParameter("currencyId")==null?"CD":request.getParameter("currencyId");

String paymentMethod	= request.getParameter("paymentMethod")==null?"":request.getParameter("paymentMethod");

String bank				= request.getParameter("bank")==null?"":request.getParameter("bank");
String accountNum		= request.getParameter("accountNum")==null?"":request.getParameter("accountNum");

String applyWage		= "N";
String applyAddition	= "N";
String applyDeduction	= "N";

 String code  = "";	
 String descr = "";
 
String contextRoot	= request.getContextPath();

if(!employeeName.equals(""))
{
	employeeNum = "1082";
	basicIncome = "8000";
	jobId		= "GG";
}
	
 /*******************************************************************************
 * build the sqlString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCONFEMPS('" + 
 					companyID + "',"+ companyEID +",'NEW',?,?)}"; 
 System.out.println("sqlString = " + sqlString); 	
%>
<jsp:useBean id="confemployeeDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="confemployeeDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="confemployeeDBBean" />
</jsp:useBean>
<%
 confemployeeDBBean.execute();
%>
<FORM name="myForm" method="post" action="">
<table width="750" class="Border">
	<tbody>
		<tr class="tableheader">
			<td colspan="4">Datos de Empleado</td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">Empleado</td>
			<td width="177">
				<INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>"> 
				<INPUT type="text" class="text" size="20" maxlength="40" name="employeeName" id="employeeName" value="<%=employeeName%>" onchange="this.form.employeeId.value='';" onkeypress='if(isEnterPressed()) receipt_search(myForm, "EMP","<%=contextRoot%>");'>
				<INPUT type="button" name="searchEmp" value=" v " onclick='receipt_search(myForm,"EMP","<%= contextRoot %>");'>			
			</td>
			<td class="label" width="159">Numero de Empleado</td>
			<td width="207"><input type="text" name="employeeNum" size="5" maxlength="5" value="<%=employeeNum%>"></td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label">Tipo de Empleado</td>
			<td width="177">
			<select size="1" name="employeeType">
				<option value=""></option>
				<option value="E" <%=employeeType.equals("E")?"selected":""%>>Eventuales</option>
				<option value="J" <%=employeeType.equals("J")?"selected":""%>>Jubilados</option>
				<option value="P" <%=employeeType.equals("P")?"selected":""%>>Presupuestado</option>
				<option value="R" <%=employeeType.equals("R")?"selected":""%>>Retidaros</option>
				<option value="T" <%=employeeType.equals("T")?"selected":""%>>Temporales</option>
				<option value="T" <%=employeeType.equals("O")?"selected":""%>>Oferente</option>				
			</select></td>
			<td class="label" width="159">Fecha Contratado</td>
			<td width="207">
			<input size="8" name="birthDate0" value="<%=birthDate%>"
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate0)"
				onchange="formatDate(myForm.birthDate0)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate0)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate0, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">Titulo Obtenido</td>
			<td width="177">
				<input type="text" size="15" maxlength="16" name="identification0"
				value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="159">Fecha Recontratado</td>
			<td width="207"><input size="8" name="birthDate00"
				value="" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate00)"
				onchange="formatDate(myForm.birthDate00)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate00)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate00, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar">			
			</td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label">Foto</td>
			<td width="177"><input type="submit" name="Examinar" value="Examinar"></td>
			<td class="label" width="159">Ultimo Aumento</td>
			<td width="207"><input size="8" name="birthDate01"
				value="" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate01)"
				onchange="formatDate(myForm.birthDate01)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate01)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate01, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">Multimedia</td>
			<td width="177"><input type="submit" name="Examinar0"
				value="Examinar"></td>
			<td class="label" width="159">Ultima Evaluacion</td>
			<td width="207"><input size="8" name="birthDate02"
				value="" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate02)"
				onchange="formatDate(myForm.birthDate02)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate02)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate02, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label"></td>
			<td width="177"></td>
			<td class="label" width="159"></td>
			<td width="207"></td>
		</tr>
		<tr class="tableheader">
			<td colspan="4">Datos Personales Empleado</td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label">Fecha de Nacimiento</td>
			<td width="177"><input size="8" name="birthDate" value="<%=birthDate%>"
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate)"
				onchange="formatDate(myForm.birthDate)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar">			
			</td>
			<td class="label" width="159">Edad</td>
			<td width="207"><input type="text" name="employeeAge" size="3"
				maxlength="2" value="<%=employeeAge%>"></td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">Genero</td>
			<td width="177"><select size="1" name="emplyeeGenre">
				<option value="M" <%=employeeGenre.equals("M")?"selected":""%>>M</option>
				<option value="F" <%=employeeGenre.equals("F")?"selected":""%>>F</option>
			</select></td>
			<td class="label" width="159">Cedula</td>
			<td width="207"><input type="text" size="15" maxlength="16"
				name="identification" value="<%=identification%>"
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label">Telefono Casa</td>
			<td width="177"><input class="textfieldDisableR" type="text" size="15" maxlength="16"
				name="identification02" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="159">Telefono Movil</td>
			<td width="207"><input class="textfieldDisableR" type="text" size="15" maxlength="16"
				name="identification03" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">Correo Electronico Personal</td>
			<td width="177"><input class="textfieldDisableR" type="text" size="15" maxlength="16"
				name="identification00" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
			<td class="label" width="159">Correo Electronico Empresa</td>
			<td width="207"><input class="textfieldDisableR" type="text" size="15" maxlength="16"
				name="identification01" value=""
				onkeyup="formatCEDID(myForm.identification)"
				onkeypress="formatCEDID(myForm.identification)"></td>
		</tr>
		<tr class="pcrinfo">
			<td class="label"></td>
			<td width="177"></td>
			<td class="label" width="159"></td>
			<td width="207"></td>
		</tr>
		<tr class="tableheader">
			<td colspan="4">Datos de Cargo</td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">Cargo</td>
			<td width="177">
			<select size="1" name="jobId">
				<option value=""></option>
				<option value="AL" <%=jobId.equals("AL")?"selected":""%>>Asesoria Legal</option>
				<option value="AA" <%=jobId.equals("AA")?"selected":""%>>Asistente Administrativa</option>
				<option value="AD" <%=jobId.equals("AD")?"selected":""%>>Auditor Delegado</option>
				<option value="CG" <%=jobId.equals("CG")?"selected":""%>>Contador General</option>
				<option value="GP" <%=jobId.equals("GP")?"selected":""%>>Gerente Portuario</option>
				<option value="GG" <%=jobId.equals("GG")?"selected":""%>>Gerente General</option>				
				<option value="GI" <%=jobId.equals("GI")?"selected":""%>>Gerente Informatica</option>								
			</select>
			</td>
			<td class="label" width="159">Salario Basico</td>
			<td width="207">
				<INPUT type="text" size="15" maxlength="15" name="basicIncome" value="<%=Format.formatCurrency(new BigDecimal(basicIncome))%>">	
			</td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label">Gana Antiguedad</td>
			<td class="label" width="177">
				<input type="checkbox" name="gainsAging" value="S" <%=gainsAging.equals("Y")?"checked":""%>>SI 
				<input type="checkbox" name="gainsAging" value="N" <%=gainsAging.equals("N")?"checked":""%>>NO 
			</td>
			<td class="label" width="159">Centro de Costo</td>
			<td width="207">
	            <SELECT size="1" name="entType" class="text" onchange="myForm.empCustId.value='<%=ConstantValue.COST_CENTER_BLANK_ID%>'; myForm.empCustIdText.value='';">
	            <OPTION value="" <%=entType.length()==0?"selected": ""%>></OPTION>
<%
		int numOfEntity = confemployeeDBBean.getRowsInResult(ENTITY_CUR);
		
   		for (int j = 0; j < numOfEntity; j++) { 
 			code 	= (String)confemployeeDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,ENTITY_CUR);
			descr	= (String)confemployeeDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,ENTITY_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=entType.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
			<INPUT type="hidden" name="empCustId" value="<%=empCustId%>">
        	<INPUT type="text" size="20" maxlength="55" name="empCustIdText" id="empCustIdText" value="<%=empCustIdText%>" onChange="myForm.empCustId.value='<%=ConstantValue.COST_CENTER_BLANK_ID%>';" onkeypress='if(isEnterPressed()) openCostCenterDialog("", "A", "<%= request.getContextPath() %>");'>
        	<INPUT type="button" name="dropBoxButtom" value=" v " onclick='openCostCenterDialog("", "A", "<%= request.getContextPath() %>");'>	               
			
			</td>
		</tr>
		<tr class="tableheader">
			<td colspan="4">Datos de Pago</td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">Frecuencia de Pago</td>
			<td width="177"><select size="1" name="frequencyPayment">
				<option value="Q" <%=frequencyPayment.equals("Q")?"selected":""%>>Quincenal</option>
				<option value="M" <%=frequencyPayment.equals("M")?"selected":""%>>Mensual</option>
			</select></td>
			<td class="label" width="159">Metodo de Pago</td>
			<td width="207">
			<select size="1" name="paymentMethod" onChange="payment_method(this.form);">
				<option value="CS" <%=paymentMethod.equals("CS")?"selected":""%>>Efectivo</option>
				<option value="CK" <%=paymentMethod.equals("CK")?"selected":""%>>Cheque</option>
				<option value="DC" <%=paymentMethod.equals("DC")?"selected":""%>>Tarjeta Debito</option>				
			</select>			
			</td>
		</tr>
		<tr class="pcrinfo1">
			<td class="label">Moneda de Pago</td>
			<td width="177">
	            <SELECT size="1" name="currencyId" class="text">
	            <OPTION value="" <%=currencyId.length()==0?"selected": ""%>></OPTION>
<%
		int numOfCurrencies = confemployeeDBBean.getRowsInResult(CURRENCY_CUR);
		
   		for (int j = 0; j < numOfCurrencies; j++) { 
 			code 	= (String)confemployeeDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,CURRENCY_CUR);
			descr	= (String)confemployeeDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,CURRENCY_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=currencyId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>   			
			</td>
			<td class="label" width="159">Banco</td>
			<td width="207">
				<INPUT type="text" size="20" maxlength="50" name="bank" value="<%=bank%>">
			</td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">Pagar de Cuenta(Aplica Cheques Solamente)</td>
			<td width="177"><select size="1" name="frequencyPayment0">
				<option value="A" <%=frequencyPayment.equals("A")?"selected":""%>>Banpro/Cuenta Operativa 1211</option>
				<option value="B" <%=frequencyPayment.equals("B")?"selected":""%>>Banpro/Cuenta Dolar 129099</option>
				<option value="C" <%=frequencyPayment.equals("C")?"selected":""%>>BAC/Cuenta Cordobas 11101-90</option>
				<option value="D" <%=frequencyPayment.equals("D")?"selected":""%>>BAC/Cuenta Dolares 11101-91</option>
				<option value="E" <%=frequencyPayment.equals("E")?"selected":""%>>City Bank/Cuenta Operativa 6122</option>
				<option value="F" <%=frequencyPayment.equals("F")?"selected":""%>>City Bank/Cuenta Dolares 12829</option>				
			</select></td>
			<td class="label" width="159">No. Cuenta</td>
			<td width="207">
				<INPUT type="text" size="20" maxlength="20" name="accountNum" value="<%=accountNum%>">
			</td>
		</tr>
	</tbody>
</table>
<table width="750" class="Border">
	<tbody>
		<tr class="tableheader">
			<td colspan="5">Ingresos(Percepciones)</td>
		</tr>
		<tr class="tableheader">
			<td>Aplica?</td>
			<td>Nombre</td>
			<td>Tipo</td>
			<td>Multiplo de H/Extra</td>														
			<td>% Comision</td>
		</tr>		
<%
 int wagesRows = confemployeeDBBean.getRowsInResult(WAGES_CUR);

 int i = 0;
 
 if (wagesRows == 0) 
 {
%>
	<TR>
	 <TH colspan="5"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < wagesRows ; ) 
   { 
	try 
	{
		if(i==0 || i==2 || i==3)
			applyWage = "Y";
		else
			applyWage = "N";
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD><input type="checkbox" name="applyWage<%=i%>" value="Y" <%=applyWage.equals("Y")?"checked":""%>></TD>	
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(WGNAME_COLUMN,i,WAGES_CUR)%></TD>
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(WGTYPE_COLUMN,i,WAGES_CUR)%></TD>
      <TD align="right"><%=Format.formatDecimal(((BigDecimal)confemployeeDBBean.valueAtColumnRowResult(WGOVRTMLT_COLUMN,i,WAGES_CUR)).toString())%></TD>
      <TD align="right"><%=Format.formatDecimal(((BigDecimal)confemployeeDBBean.valueAtColumnRowResult(WGCOMISION_COLUMN,i,WAGES_CUR)).toString())%></TD>    
     </TR>
<%
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
}
%>		
	</tbody>
</table>
<table width="750" class="Border">
	<tbody>
		<tr class="tableheader">
			<td colspan="7">Otros Ingresos(Otras Percepciones)</td>
		</tr>
		<tr class="tableheader">
			<td>Aplica?</td>
			<td>Nombre</td>
			<td>Calculo/Basado En</td>
			<td>Calcular/Sobre</td>			
			<td>Porcentaje</td>
			<td>Monto Fijo</td>						
			<td>Incluir Subsidio?</td>														
		</tr>		
<%
 int additionRows = confemployeeDBBean.getRowsInResult(ADDITIONS_CUR);

 if (additionRows == 0) 
 {
%>
	<TR>
	 <TH colspan="7"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < additionRows ; ) 
   { 
	try 
	{ 
		if(i == 2) 
			applyAddition = "Y";
		else
			applyAddition = "N";		
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD><input type="checkbox" name="applyAddition<%=i%>" value="Y" <%=applyAddition.equals("Y")?"checked":""%>></TD>	
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(ADADNAME_COLUMN,i,ADDITIONS_CUR)%></TD>
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(DESCR_COLUMN,i,ADDITIONS_CUR)%></TD>
      <TD><%=((String)confemployeeDBBean.valueAtColumnRowResult(ADCLTGRSNT_COLUMN,i,ADDITIONS_CUR)).toString().equals("G")?"Pago Bruto":"Pago Neto"%></TD>      
      <TD align="right"><%=Format.formatDecimal(((BigDecimal)confemployeeDBBean.valueAtColumnRowResult(ADDFTRATE_COLUMN,i,ADDITIONS_CUR)).toString())%></TD>
      <TD align="right"><%=Format.formatDecimal(((BigDecimal)confemployeeDBBean.valueAtColumnRowResult(ADDFTAMNT_COLUMN,i,ADDITIONS_CUR)).toString())%></TD>            
      <TD align="center"><%=(String)confemployeeDBBean.valueAtColumnRowResult(ADSICKVAC_COLUMN,i,ADDITIONS_CUR)%></TD>
     </TR>
<%
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
}
%>		
	</tbody>
</table>
<table width="750" class="Border">
	<tbody>
		<tr class="tableheader">
			<td colspan="8">Deducciones</td>
		</tr>
		<tr class="tableheader">
			<td>Aplica?</td>
			<td>Nombre</td>
			<td>Calculo/Basado En</td>
			<td>Calcular/Sobre</td>	
			<td>Entidad(A Que se le Paga)</td>		
			<td>Porcentaje</td>
			<td>Monto Fijo</td>						
			<td>Incluir Subsidio?</td>														
		</tr>		
<%
 int deductionRows = confemployeeDBBean.getRowsInResult(DEDUCTIONS_CUR);

 if (deductionRows == 0) 
 {
%>
	<TR>
	 <TH colspan="8"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < deductionRows ; ) 
   { 
	try 
	{ 
		 if(i==0 || i==1)
		 	applyDeduction = "Y";
		 else
 			applyDeduction = "N"; 
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD><input type="checkbox" name="applyDeduction<%=i%>" value="Y" <%=applyDeduction.equals("Y")?"checked":""%>></TD>	
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(DEDENAME_COLUMN,i,DEDUCTIONS_CUR)%></TD>
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(DESCR2_COLUMN,i,DEDUCTIONS_CUR)%></TD>
      <TD><%=((String)confemployeeDBBean.valueAtColumnRowResult(DECLTGRSNT_COLUMN,i,DEDUCTIONS_CUR)).toString().equals("G")?"Pago Bruto":"Pago Neto"%></TD>      
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(VENDOR_COLUMN,i,DEDUCTIONS_CUR)%></TD>      
      <TD align="right"><%=Format.formatDecimal(((BigDecimal)confemployeeDBBean.valueAtColumnRowResult(DEDFTRATE_COLUMN,i,DEDUCTIONS_CUR)).toString())%></TD>
      <TD align="right"><%=Format.formatDecimal(((BigDecimal)confemployeeDBBean.valueAtColumnRowResult(DEDFTAMNT_COLUMN,i,DEDUCTIONS_CUR)).toString())%></TD>            
      <TD align="center"><%=(String)confemployeeDBBean.valueAtColumnRowResult(DESICKVAC_COLUMN,i,DEDUCTIONS_CUR)%></TD>
     </TR>
<%
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
}
%>		
	</tbody>
</table>
<%
  confemployeeDBBean.closeResultSet();
%>
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