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
String employeeNum	= request.getParameter("employeeNum")==null?"1082":request.getParameter("employeeNum");
String employeeAge	= request.getParameter("employeeAge")==null?"":request.getParameter("employeeAge");
String employeeType	= request.getParameter("employeeType")==null?"":request.getParameter("employeeType");
String employeeGenre= request.getParameter("employeeGenre")==null?"":request.getParameter("employeeGenre");

String jobId		= request.getParameter("jobId")==null?"":request.getParameter("jobId");
String gainsAging	= request.getParameter("gainsAging")==null?"Y":request.getParameter("gainsAging"); 

String identification	= request.getParameter("identification")==null?"":request.getParameter("identification");

String birthDate		= request.getParameter("birthDate")==null?Format.getSysDate():request.getParameter("birthDate");

String frequencyPayment = request.getParameter("frequencyPayment")==null?Format.getSysDate():request.getParameter("frequencyPayment");
String basicIncome		= request.getParameter("basicIncome")==null?"0.00":request.getParameter("basicIncome");

String entType 			= request.getParameter("entType")==null?"0.00":request.getParameter("entType");

String empCustId		= request.getParameter("empCustId")==null?"":request.getParameter("empCustId");
String empCustIdText	= request.getParameter("empCustIdText")==null?"":request.getParameter("empCustIdText");

String currencyId		= request.getParameter("currencyId")==null?"":request.getParameter("currencyId");

String paymentMethod	= request.getParameter("paymentMethod")==null?"":request.getParameter("paymentMethod");

String bank				= request.getParameter("bank")==null?"":request.getParameter("bank");
String accountNum		= request.getParameter("accountNum")==null?"":request.getParameter("accountNum");

 String code  = "";	
 String descr = "";
 
String contextRoot	= request.getContextPath();

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
			<td colspan="4">Ingreso Datos de Planilla</td>
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
			<td class="label">Pagar desde Cuenta</td>
			<td width="177"><select size="1" name="frequencyPayment0">
				<option value="A" <%=frequencyPayment.equals("A")?"selected":""%>>Banpro/Cuenta
				Operativa 1211</option>
				<option value="B" <%=frequencyPayment.equals("B")?"selected":""%>>Banpro/Cuenta
				Dolar 129099</option>
				<option value="C" <%=frequencyPayment.equals("C")?"selected":""%>>BAC/Cuenta
				Cordobas 11101-90</option>
				<option value="D" <%=frequencyPayment.equals("D")?"selected":""%>>BAC/Cuenta
				Dolares 11101-91</option>
				<option value="E" <%=frequencyPayment.equals("E")?"selected":""%>>City
				Bank/Cuenta Operativa 6122</option>
				<option value="F" <%=frequencyPayment.equals("F")?"selected":""%>>City
				Bank/Cuenta Dolares 12829</option>
			</select></td>
			<td class="label" width="159">Fecha Inicio</td>
			<td width="207"><input size="8" name="birthDate0"
				value="<%=birthDate%>" maxlength="10" type="text"
				onkeyup="addSlash(myForm.birthDate0)"
				onchange="formatDate(myForm.birthDate0)"
				onkeypress="OnlyDigits();addSlash(myForm.birthDate0)"
				onkeydown="return checkArrows(this, event)">
				<img src="../../ERP_COMMON/images/popcalendar/calendar.gif"
				border="0"
				onclick="popUpCalendar(this, myForm.birthDate0, 'mm/dd/yyyy', -1, -1);"
				alt="Calendar"></td>
		</tr>
		<tr class="pcrinfo">
			<td class="label">Semanas Trabajadas</td>
			<td width="177"><input type="text" size="20" maxlength="50"
				name="bank0" value="2"></td>
			<td class="label" width="159">Fecha Final</td>
			<td width="207"><input size="8" name="birthDate00" value=""
				maxlength="10" type="text" onkeyup="addSlash(myForm.birthDate00)"
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
			<td class="label"></td>
			<td width="177"></td>
			<td class="label" width="159"></td>
			<td width="207"></td>
		</tr>
	</tbody>
</table>
<table width="750" class="Border">
	<tbody>
		<tr class="tableheader">
			<td colspan="2">Ingresos</td>
		</tr>
		<tr class="tableheader">
			<td>Nombre</td>
			<td>Monto</td>			
		</tr>		
<%
 BigDecimal wageAmount = new BigDecimal("0.00"); 
 BigDecimal totalWageAmount = new BigDecimal("0.00"); 

 int wagesRows = confemployeeDBBean.getRowsInResult(WAGES_CUR);

 int i = 0;
 
 if (wagesRows == 0) 
 {
%>
	<TR>
	 <TH colspan="2"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < wagesRows ; ) 
   { 
	try 
	{
		if(i==0)
			wageAmount = new BigDecimal("1500");
		else if(i==2)
			wageAmount = new BigDecimal("4000");
		else if(i==3)		
			wageAmount = new BigDecimal("500");
		else
			wageAmount = new BigDecimal("0.00");
				
		if(i == 0 || i == 2 || i == 3) 
		{
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(WGNAME_COLUMN,i,WAGES_CUR)%></TD>
	  <TD><input type="text" name="wageAmount<%=i%>" size="20" value="<%=wageAmount%>"></TD>
     </TR>
<%
		}	
		i++; 
		totalWageAmount = wageAmount.add(totalWageAmount);
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
}
%>		
	</tbody>
</table>
<table width="750" class="Border">
	<tbody>
		<tr class="tableheader">
			<td colspan="2">Otros Ingresos</td>
		</tr>
		<tr class="tableheader">
			<td>Nombre</td>							
			<td>Monto Total</td>
		</tr>		
<%
 int additionRows = confemployeeDBBean.getRowsInResult(ADDITIONS_CUR);

BigDecimal otherWageAmount = new BigDecimal("0.00");
BigDecimal totalOtherWageAmount = new BigDecimal("0.00");

 if (additionRows == 0) 
 {
%>
	<TR>
	 <TH colspan="2"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
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
		{
			otherWageAmount = new BigDecimal("1000");
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(ADADNAME_COLUMN,i,ADDITIONS_CUR)%></TD>
  	 <TD><input type="text" name="otherWageAmount<%=i%>" size="20" value="<%=otherWageAmount%>"></TD>
     </TR>
<%
		}
		else
			otherWageAmount = new BigDecimal("0.00");
		i++; 
		totalOtherWageAmount = otherWageAmount.add(totalOtherWageAmount);
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
}
%>		
	</tbody>
</table>
<table width="750" class="Border">
	<tbody>
		<tr class="tableheader">
			<td colspan="2">Deducciones/Impuestos</td>
		</tr>
		<tr class="tableheader">
			<td>Nombre</td>
			<td>Monto</td>						
		</tr>		
<%
 int deductionRows = confemployeeDBBean.getRowsInResult(DEDUCTIONS_CUR);
BigDecimal deductionAmount = new BigDecimal("0.00");
BigDecimal totalDeductionAmount = new BigDecimal("0.00");

 if (deductionRows == 0) 
 {
%>
	<TR>
	 <TH colspan="2"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < deductionRows ; ) 
   { 
	try 
	{
		 if(i==0)
			deductionAmount = new BigDecimal("1000");
		 else if(i==1)
		 	deductionAmount = new BigDecimal("200"); 
		 else
 			deductionAmount = new BigDecimal("0.00");
		 
		if(i == 0 || i == 1) 
		{
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD><%=(String)confemployeeDBBean.valueAtColumnRowResult(DEDENAME_COLUMN,i,DEDUCTIONS_CUR)%></TD>
	 <TD><input type="text" name="deductionAmount<%=i%>" size="20" value="<%=deductionAmount%>"></TD>
     </TR>
<%
		}
		totalDeductionAmount = deductionAmount.add(totalDeductionAmount);
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
<table width="750" class="Border">
	<tbody>
	<tr class="tableheader">
		<td colspan="2">Resumen</td>
	</tr>
	<tr>
		<td class="label">Ingresos</td>
		<td class="label"><%=totalWageAmount.add(totalOtherWageAmount)%></td>
	</tr>
	<tr>
		<td class="label">Deducciones</td>
		<td class="label"><%=totalDeductionAmount%></td>
	</tr>	
	<tr>
	<%
		BigDecimal totalIncome  = totalWageAmount.add(totalOtherWageAmount);
		BigDecimal totalPay 	= totalIncome.subtract(totalDeductionAmount);
	%>
	<Tr>
		<td class="label">Neto a Pagar</td>
		<td class="label"><%=totalPay%></td>
	</Tr>		
	</tbody>
</table>	
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="button" name="Save" value="<%=rb.getString("B00008")%>" class="button"  onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/employee/listpayrollemployee.jsp';">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/employee/listpayrollemployee.jsp';">
</TD>
</TR>
</TABLE>

</form>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</body>
</html>