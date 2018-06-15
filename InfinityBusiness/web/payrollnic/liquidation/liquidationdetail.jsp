<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Detalle de Liquidacion</TITLE>
</HEAD> 
 <BODY onLoad="cal_totAmt('0');">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Nomina Quincenal";

 static final int LIQLST_CUR 		= 1;
 static final int PAYSALARY_CUR 	= 2;
 static final int INCCONCEPTS_CUR	= 3;	
 static final int DECCONCEPTS_CUR	= 4;
 static final int LIQINCS_CUR		= 5;
 static final int LIQDED_CUR		= 6;
 
 static final int LQLIQUID_COLUMN	= 1;
 static final int LQLIQUNUM_COLUMN	= 2;
 static final int LQDATE_COLUMN 	= 3;
 static final int LQEMPLID_COLUMN 	= 4;
 static final int LQEMPLNUM_COLUMN	= 5;
 static final int LQEMPLNM_COLUMN	= 6;
 static final int LQEXTID_COLUMN 	= 7;     
 static final int LQPROFNM_COLUMN	= 8;
 static final int LQTOPMNGRDS_COLUMN= 9;
 static final int LQCOMPSCTDS_COLUMN= 10;
 static final int LQEMPLSAL_COLUMN	= 11;        
 static final int LQEMPLSALDY_COLUMN= 12;
 static final int LQEMPLSALHR_COLUMN= 13;
 static final int LQCC_COLUMN		= 14;
 static final int LQCOTYPE_COLUMN	= 15;
 static final int LQSALTYPE_COLUMN	= 16;           
 static final int LQINTDATE_COLUMN	= 17;
 static final int LQENDDATE_COLUMN	= 18;
 static final int LQDECDATE_COLUMN	= 19;
 static final int LQPAYDATE_COLUMN	= 20;
 static final int LQREAZON_COLUMN	= 21;
 static final int LQEMPSALP_COLUMN	= 22;
 static final int LQINCMAX_COLUMN	= 23;
 static final int LQYEARS_COLUMN	= 24;
 static final int LQMONTH_COLUMN	= 25;
 static final int LQDAYS_COLUMN		= 26;
 
 static final int LDEMPLSAL_COLUMN 		= 1;
 static final int LDEMPLSALQT_COLUMN 	= 2;
 static final int LDEMPLAGN_COLUMN 		= 3;
 static final int LDEMPLAGNQT_COLUMN 	= 4;
 static final int LDAGINGYN_COLUMN 		= 5;
 static final int LDDAYSMISS_COLUMN 	= 6;
 static final int LDMISSAMT_COLUMN 		= 7;
 static final int LDSICKDAYS_COLUMN 	= 8;
 static final int LDEXHR_COLUMN 		= 9;
 static final int LDEXHRAMT_COLUMN 		= 10;
 static final int LDVACDAYS_COLUMN 		= 11;
 static final int LDVACSAMT_COLUMN 		= 12;
 static final int LDRVACDAYS_COLUMN 	= 13;
 static final int LDRVACAMT_COLUMN 		= 14;
 static final int LDTOTAL_COLUMN 		= 15;
 static final int LDSICKAMT_COLUMN 		= 16;     
 static final int LDSEPHR_COLUMN 		= 17;
 static final int LDSEPHRAMT_COLUMN 	= 18;
 static final int LDWRKDAYS_COLUMN 		= 19;
 static final int LDFERHR_COLUMN 		= 20;
 static final int LDFERHRAMT_COLUMN 	= 21;
 static final int LDINSSLB_COLUMN 		= 22;
 static final int LDIR_COLUMN 			= 23;
 static final int LDRWRKDAYS_COLUMN		= 24;
 static final int LDDECDAYS_COLUMN		= 25;
 static final int LDDECAMT_COLUMN		= 26;
 static final int LDFINDAYS_COLUMN		= 27;
 static final int LDFINAMTDY_COLUMN		= 28;
 static final int LDFINAMTMT_COLUMN		= 29;
 static final int LDFINAMTYR_COLUMN		= 30;
 static final int LDFINAMTTT_COLUMN		= 31;
 static final int LDINSSPT_COLUMN		= 32;
 static final int LDINATEC_COLUMN		= 33;
 static final int LDTOTNET_COLUMN		= 34;
 static final int LDTRUSTAMT_COLUMN		= 35;
 static final int LDVIATAMT_COLUMN		= 36;
 
 static final int LQINCID_COLUMN		= 1;
 static final int LQINCAM_COLUMN		= 2;
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/liquidation.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String liquidationId = request.getParameter("liquidationId")==null?"0":request.getParameter("liquidationId");
 
   String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLLIQS('" + 
 					companyID + "',0,0,'','',"+ liquidationId +",'','','','','','EMPLIQDET','','','',0,?,?)}";
 
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
int startIndex = (request.getParameter("startIndex")==null) ? 0 : Integer.parseInt(request.getParameter("startIndex").trim());
int i = 0;
  
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(PAYSALARY_CUR);
 String code 			= "";
 String descr			= "";
 String conceptIncomeId = "";
 String conceptDeductId = "";
%>
<FORM name = "myForm" method="post" action="<%=contextRoot%>/erp/payrollnic/liquidation/premplliqs.jsp">
<TABLE width="750" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="4" class="tableheader">LIQUIDACION PERSONAL</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label">Liquidacion No.</TD>
      <TD><%=((String)listDBBean.valueAtColumnRowResult(LQLIQUNUM_COLUMN,0,LIQLST_CUR)).toString()%></TD>
      <TD class="label">Fecha</TD>
      <TD><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQDATE_COLUMN,0,LIQLST_CUR).toString())%></TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label">No. Empleado</TD>
      <TD><%=((String)listDBBean.valueAtColumnRowResult(LQEMPLNUM_COLUMN,0,LIQLST_CUR)).toString()%></TD>
      <TD class="label">Inss</TD>
      <TD><%=((String)listDBBean.valueAtColumnRowResult(LQEXTID_COLUMN,0,LIQLST_CUR)).toString()%></TD>
    </TR>    
    <TR class="pcrinfo">
      <TD class="label">Nombre Completo</TD>
      <TD><%=((String)listDBBean.valueAtColumnRowResult(LQEMPLNM_COLUMN,0,LIQLST_CUR)).toString()%>
		<INPUT type="hidden" name="employeeId" id="employeeId" value="<%=((BigDecimal)listDBBean.valueAtColumnRowResult(LQEMPLID_COLUMN,0,LIQLST_CUR)).toString()%>">
 		<INPUT type="hidden" name="employeeName" id="employeeName" value="<%=((String)listDBBean.valueAtColumnRowResult(LQEMPLNM_COLUMN,0,LIQLST_CUR)).toString()%>">
      </TD>
	  <TD class="label"><SPAN class="textRed">*</SPAN>Puesto</TD>
      <TD><%=((String)listDBBean.valueAtColumnRowResult(LQPROFNM_COLUMN,0,LIQLST_CUR)).toString()%></TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label">Gerencia</TD>
      <TD><%=((String)listDBBean.valueAtColumnRowResult(LQTOPMNGRDS_COLUMN,0,LIQLST_CUR)).toString()%></TD>
      <TD class="label">Salario Basico Mes</TD>
      <TD align="right"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LQEMPLSAL_COLUMN,0,LIQLST_CUR)))%></TD>
    </TR>     
    <TR class="pcrinfo">
      <TD class="label">Departamento</TD>
      <TD><%=((String)listDBBean.valueAtColumnRowResult(LQCOMPSCTDS_COLUMN,0,LIQLST_CUR)).toString()%></TD>
      <TD class="label">Salario Basico Dia</TD>
      <TD align="right"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LQEMPLSALDY_COLUMN,0,LIQLST_CUR)))%></TD>
    </TR>      
    <TR class="pcrinfo1">
      <TD class="label">CeCo</TD>
      <TD><%=((String)listDBBean.valueAtColumnRowResult(LQCC_COLUMN,0,LIQLST_CUR)).toString()%></TD>
      <TD class="label">Salario Hora</TD>
      <TD align="right"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LQEMPLSALHR_COLUMN,0,LIQLST_CUR)))%></TD>
	</TR>
	<TR class="pcrinfo">
      <TD class="label">Tipo de Contrato</TD>
      <TD>
      <%
      String contract = ((String)listDBBean.valueAtColumnRowResult(LQCOTYPE_COLUMN,0,LIQLST_CUR)).toString();
      
      if(contract.trim().equals("01"))
      	contract = "Indeterminado";
      else if(contract.trim().equals("02"))
      	contract = "Determinado";
	  else if(contract.trim().equals("03"))
		contract = "Libre";
	  else
	    contract = "";		        		
      %>
      <%=contract%>
      </TD>
	  <TD class="label" colspan="2">Periodo Laborado</TD>
	</TR>
	<TR class="pcrinfo1">
      <TD class="label">Tipo de Salario</TD>
      <TD class="label"><%=((String)listDBBean.valueAtColumnRowResult(LQSALTYPE_COLUMN,0,LIQLST_CUR)).toString()%></TD>
	  <TD class="label">Años</TD>
	  <TD align="right"><%=((BigDecimal)listDBBean.valueAtColumnRowResult(LQYEARS_COLUMN,0,LIQLST_CUR)).toString()%></TD>	  
	</TR>
    <TR class="pcrinfo">
      <TD class="label">Fecha de Inicio</TD>
      <TD><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQINTDATE_COLUMN,0,LIQLST_CUR).toString())%></TD>
	  <TD class="label">Mes</TD>
	  <TD align="right"><%=((BigDecimal)listDBBean.valueAtColumnRowResult(LQMONTH_COLUMN,0,LIQLST_CUR)).toString()%></TD>	  
    </TR>
    <TR class="pcrinfo1">
      <TD class="label"></TD>
      <TD></TD>
	  <TD class="label">Dias</TD>
	  <TD align="right"><%=((BigDecimal)listDBBean.valueAtColumnRowResult(LQDAYS_COLUMN,0,LIQLST_CUR)).toString()%></TD>	  
    </TR>     	 
    <TR class="pcrinfo">
      <TD class="label">Fecha Retiro</TD>
      <TD><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQENDDATE_COLUMN,0,LIQLST_CUR).toString())%></TD>
	  <TD class="label">Fechal Ultimo Aguinaldo</TD>
	  <TD><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQDECDATE_COLUMN,0,LIQLST_CUR).toString())%></TD>
    </TR>
    <TR class="pcrinfo1">
      <TD class="label">Motivo de Retiro</TD>
      <TD>
      <%
			String reazon = ((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString();
			
			if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("RD"))
				reazon = "RENUNCIA CON 15 DIAS";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("RI"))
				reazon = "RENUNCIA INMEDIATA";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("AT"))
				reazon = "ABANDONO TRABAJO";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("MA"))
				reazon = "MUTUO ACUERDO";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("EC"))
				reazon = "EXPIRACION DE CONTRATO DETERMINADO";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("RC"))
				reazon = "RESCICIÓN DE CONTRATO ART.45 CT";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("RJ"))
				reazon = "RESCICIÓN DE CONTRATO-JUBILACIÓN";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("RI"))
				reazon = "RESCICIÓN DE CONTRATO-INVALIDEZ TOTAL";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("RM"))
				reazon = "RESCICIÓN DE CONTRATO-MUERTE";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("RP"))
				reazon = "RESCICIÓN DE CONTRATO-PENA CONDENATORIA";
			else if(((String)listDBBean.valueAtColumnRowResult(LQREAZON_COLUMN,0,LIQLST_CUR)).toString().equals("NP"))
				reazon = "NO PASA PERIODO DE PRUEBA ART.28";				
	 %>
	 <%=reazon%>
	 </TD>
	  <TD class="label">Fecha Ultima Quincena</TD>
	  <TD><%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQPAYDATE_COLUMN,0,LIQLST_CUR).toString())%></TD>
    </TR>     	          	 
    <TR class="pcrinfo">
      <TD class="label">Salario Promedio</TD>
      <TD align="right"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LQEMPSALP_COLUMN,0,LIQLST_CUR)))%></TD>
      <TD class="label">Salario Maximo</TD>
      <TD align="right"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LQINCMAX_COLUMN,0,LIQLST_CUR)))%></TD>
	</TR>
</TABLE>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="3">Detalle de Pago</TD>
    </TR>
    <TR class="tableheader">
    	<TD>Concepto</TD>
    	<TD>Valor</TD>
    	<TD>Monto</TD>
    </TR>    
<%
String fpayDate = "";
String wrkDays = "";
 if (listDBBean.RowCountResult(PAYSALARY_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="3"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{
		fpayDate = listDBBean.valueAtColumnRowResult(LQPAYDATE_COLUMN,0,LIQLST_CUR).toString();
		wrkDays  = listDBBean.valueAtColumnRowResult(LDRWRKDAYS_COLUMN,i,PAYSALARY_CUR).toString();	

		if(fpayDate.length() < 10)
			fpayDate = "";
		else
		{
			if(fpayDate.substring(8,10).equals("15"))
				fpayDate =  fpayDate.substring(5, 7) + "/16/"  + fpayDate.substring(0, 4); 
			else
			{
				if((wrkDays.substring(0,1)).equals("-") || wrkDays.substring(0,1).equals("0"))
					fpayDate = Format.date_Str(fpayDate);
			 	//IF PAYDATE DAY EQUALS 30 OR 31 2016-05-31 
			 	else if(fpayDate.substring(8,10).equals("30") || fpayDate.substring(8,10).equals("31"))
			 	{
			 		//IF MONTH IS BETWEEN 1 AND 11 WE SET DAY TO 01 AND ADD 1 MONTH
			 		if(!fpayDate.substring(5,7).equals("10") && !fpayDate.substring(5,7).equals("11") && !fpayDate.substring(5,7).equals("12") )
			 			fpayDate =	"0" + (new BigDecimal(fpayDate.substring(5,7)).add(new BigDecimal("1.00")).toString()).substring(0,1) + "/01/" + fpayDate.substring(0, 4);
			 		else if((fpayDate.substring(5,7).equals("10") || fpayDate.substring(5,7).equals("11")) && !fpayDate.substring(5,7).equals("12") )
			 			fpayDate =	(new BigDecimal(fpayDate.substring(5,7)).add(new BigDecimal("1.00")).toString()) + "/01/" + fpayDate.substring(0, 4);
					else //IF MONTH IS 12 WE SET DAY TO 01 AND MONTH TO 01 AND ADD YEAR 1			 
						fpayDate =	"01/01/" + (new BigDecimal(fpayDate.substring(0,4)).add(new BigDecimal("1.00")).toString()).substring(0,4);
				}			 
			} 	
		}	
%>    
	<TR class="tableheader">
    	<TD colspan="3">INGRESOS GRAVABLES</TD>
    </TR>
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">Salario del <%=fpayDate%> al <%=Format.date_Str(listDBBean.valueAtColumnRowResult(LQENDDATE_COLUMN,0,LIQLST_CUR).toString())%></TD>
      <TD align="right"><INPUT type="text" class="readonlyfield" size = "2" name="rwrkDays<%=i%>" value="<%=listDBBean.valueAtColumnRowResult(LDRWRKDAYS_COLUMN,i,PAYSALARY_CUR)%>" readOnly></TD>
      <TD nowrap align="right">
    	<INPUT type="hidden" name="updRec<%=i%>" value="Y">            
    	<INPUT type="hidden" name="wrkDays<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDWRKDAYS_COLUMN,i,PAYSALARY_CUR)%>">		    	      
    	<INPUT type="hidden" name="salProm<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LQEMPSALP_COLUMN,0,LIQLST_CUR)%>">
    	<INPUT type="hidden" name="salType<%=i%>" value="<%=(String)listDBBean.valueAtColumnRowResult(LQSALTYPE_COLUMN,0,LIQLST_CUR)%>">
      	<INPUT type="hidden" name="salary<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDEMPLSAL_COLUMN,i,PAYSALARY_CUR)%>">
      	<INPUT type="hidden" name="aging<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDEMPLAGN_COLUMN,i,PAYSALARY_CUR)%>">      
		<INPUT type="hidden" name="salaryQTOR<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDEMPLSALQT_COLUMN,i,PAYSALARY_CUR)%>">
		<INPUT type="text" class="readonlyfield" name="salaryQT<%=i%>" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDEMPLSALQT_COLUMN,i,PAYSALARY_CUR))%>" readOnly>
      </TD>
    </TR>  
	<TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">      
      <TD class="label">Antiguedad</TD>
      <TD>
      	<INPUT type="hidden" name="agingQT<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDEMPLAGNQT_COLUMN,i,PAYSALARY_CUR)%>">
      </TD>
      <TD nowrap align="right">
      	<%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDEMPLAGNQT_COLUMN,i,PAYSALARY_CUR))%>
      </TD>
     </TR>
	<TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">      
      <TD class="label">Horas Extras</TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="exHR<%=i%>" onBlur="cal_hrExtAmt(<%=i%>);" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDEXHR_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input readOnly class="textfield" type="text" name="exHRAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDEXHRAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>
	</TR>
	<TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">Feriado</TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="ferHR<%=i%>" onBlur="cal_ferExtAmt(<%=i%>);" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDFERHR_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input readOnly class="textfield" type="text" name="ferHRAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDFERHRAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>
	</TR>
	<TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">	
      <TD class="label">Septimo(HRS)</TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="septHR<%=i%>" onBlur="cal_septExtAmt(<%=i%>);" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDSEPHR_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input readOnly class="textfield" type="text" name="septHRAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDSEPHRAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>
	</TR>
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">Vacaciones Pagadas</TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="vacDays<%=i%>" onBlur="cal_vacsAmt(<%=i%>,'N');" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDVACDAYS_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input readOnly class="textfield" type="text" name="vacAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDVACSAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>
	</TR>
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">Vacaciones Descansadas</TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="rvacDays<%=i%>" onBlur="cal_vacsAmt(<%=i%>,'R');" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDRVACDAYS_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input readOnly class="textfield" type="text" name="rvacAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDRVACAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>                              
	</TR>
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">Dias Falta</TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="daysMiss<%=i%>" onBlur="cal_missesAmt(<%=i%>);" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDDAYSMISS_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input readOnly class="textfield" type="text" name="amountMiss<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDMISSAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>
	</TR>
<%
int numOfConcepts 		= 0;
int liqINC				= 0;
BigDecimal amountINC 	= new BigDecimal("0.00");
for(int k=0;k<10;k++)
{ 
%>	
    <TR class="pcrinfo">
      <TD>
	            <SELECT size="1" name="conceptIncomeId<%=k%>" class="text">
	            <OPTION value="0" <%=conceptIncomeId.length()==0?"selected": ""%>></OPTION>
<%
		numOfConcepts	 = listDBBean.getRowsInResult(INCCONCEPTS_CUR);
		liqINC			 = listDBBean.getRowsInResult(LIQINCS_CUR);

		if(k < liqINC)
		{
		 	amountINC		= (BigDecimal)listDBBean.valueAtColumnRowResult(LQINCAM_COLUMN,k,LIQINCS_CUR);
			conceptIncomeId = ((BigDecimal)listDBBean.valueAtColumnRowResult(LQINCID_COLUMN,k,LIQINCS_CUR)).toString();
		}
		else
		{
			conceptIncomeId = "0";
			amountINC		= new BigDecimal("0.00");
		}
		
   		for (int j = 0; j < numOfConcepts; j++) 
   		{ 
 			code 	= ((BigDecimal)listDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,INCCONCEPTS_CUR)).toString();
			descr	= (String)listDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,INCCONCEPTS_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=conceptIncomeId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>	                         
      </TD>	
      <TD></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="amountINC<%=k%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="15" value="<%=Format.formatCurrency(amountINC)%>"></TD>      
    </TR>       	
<% }%>    
    <TR class="tableheaderY">
      <TD colspan="2" align="right">TOTAL INGRESOS GRAVABLES</TD>
      <TD nowrap align="right"><input readOnly class="readonlyfield" type="text" name="totalAmt<%=i%>" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDTOTAL_COLUMN,i,PAYSALARY_CUR))%>"></TD>                                                      
	</TR>
	<TR class="tableheader">
    	<TD colspan="3">INGRESOS NO GRAVABLES</TD>
    </TR>
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">Dias Subsidio</TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="sickDays<%=i%>" onBlur="cal_sicksAmt(<%=i%>);" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDSICKDAYS_COLUMN,i,PAYSALARY_CUR)%>"></TD>                              
      <TD nowrap align="right"><input class="textfield" readOnly type="text" name="sickAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDSICKAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>                                                
    </TR>
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">VIATICOS</TD>
      <TD class="label" align="center"></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="viatAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDVIATAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>                                                
    </TR>    
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">CARGO DE CONFIANZA</TD>
      <TD class="label" align="center"></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="trustAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDTRUSTAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>                                                
    </TR>
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">INDEMNIZACION</TD>
      <TD class="label" align="center">
      	<TABLE cellpadding="0" cellspacing="1" class="Border" border="0">
      	<TBODY>
			<TR>
				<TD class="label">AÑOS</TD>
				<TD class="label">MES</TD>
				<TD class="label">DIAS</TD>
			</TR>
			<TR>
				<TD><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDFINAMTYR_COLUMN,i,PAYSALARY_CUR))%></TD>
				<TD><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDFINAMTMT_COLUMN,i,PAYSALARY_CUR))%></TD>
				<TD><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDFINAMTDY_COLUMN,i,PAYSALARY_CUR))%></TD>								
			</TR>
		</TBODY>
		</TABLE>
	  </TD>
      <TD align = "right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDFINAMTTT_COLUMN,i,PAYSALARY_CUR))%></TD>
    </TR>            
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD class="label">TRECEAVO MES(AGUINALDO)</TD>
      <TD align="right"><%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDDECDAYS_COLUMN,i,PAYSALARY_CUR)%></TD>
      <TD align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDDECAMT_COLUMN,i,PAYSALARY_CUR))%></TD>
    </TR>
    <TR class="tableheaderY">
      <TD colspan="2" align="right">TOTAL INGRESOS NO GRAVABLES</TD>
      <TD nowrap align="right">
      <%
      BigDecimal payAmtTT = (BigDecimal)listDBBean.valueAtColumnRowResult(LDTOTAL_COLUMN,i,PAYSALARY_CUR);
      BigDecimal finAmtTT = (BigDecimal)listDBBean.valueAtColumnRowResult(LDFINAMTTT_COLUMN,i,PAYSALARY_CUR);
      BigDecimal decAmtTT = (BigDecimal)listDBBean.valueAtColumnRowResult(LDDECAMT_COLUMN,i,PAYSALARY_CUR);
      BigDecimal trsAmtTT = (BigDecimal)listDBBean.valueAtColumnRowResult(LDTRUSTAMT_COLUMN,i,PAYSALARY_CUR);
      BigDecimal vitAmtTT = (BigDecimal)listDBBean.valueAtColumnRowResult(LDVIATAMT_COLUMN,i,PAYSALARY_CUR);
      %>
	<INPUT type="text" class="readonlyfield" name="totNGIncome<%=i%>" value="<%=Format.displayCurrency(finAmtTT.add(decAmtTT).add(trsAmtTT).add(vitAmtTT).add((BigDecimal)listDBBean.valueAtColumnRowResult(LDSICKDAYS_COLUMN,i,PAYSALARY_CUR)))%>" readOnly>      
      
      </TD>                                                      
	</TR>
    <TR class="tableheaderY">
      <TD colspan="2" align="right">TOTAL INGRESOS</TD>
      <TD nowrap align="right">            
        <INPUT type="hidden" name="finAmtTT<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDFINAMTTT_COLUMN,i,PAYSALARY_CUR)%>">
        <INPUT type="hidden" name="decAmtTT<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(LDDECAMT_COLUMN,i,PAYSALARY_CUR)%>">                  
	<INPUT type="text" class="readonlyfield" name="ttIncome<%=i%>" value="<%=Format.formatCurrency(finAmtTT.add(decAmtTT).add(vitAmtTT).add(payAmtTT).add(trsAmtTT))%>" readOnly>
      </TD>                                                      
	<TR class="tableheader">
    	<TD colspan="3"></TD>
    </TR>	
	<TR class="tableheader">
    	<TD colspan="3">DEDUCCIONES</TD>
    </TR>
<%
int liqDED			= 0;
BigDecimal amountDED 	= new BigDecimal("0.00");
BigDecimal amountDEDTOT = new BigDecimal("0.00");

for(int k=0;k<10;k++)
{ 
%>	
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
      <TD>
	            <SELECT size="1" name="conceptDeductId<%=k%>" class="text">
	            <OPTION value="0" <%=conceptDeductId.length()==0?"selected": ""%>></OPTION>
<%
		numOfConcepts = listDBBean.getRowsInResult(DECCONCEPTS_CUR);
		liqDED = listDBBean.getRowsInResult(LIQDED_CUR);

		if(k < liqDED)
		{
		 	amountDED		= (BigDecimal)listDBBean.valueAtColumnRowResult(LQINCAM_COLUMN,k,LIQDED_CUR);
			conceptDeductId = ((BigDecimal)listDBBean.valueAtColumnRowResult(LQINCID_COLUMN,k,LIQDED_CUR)).toString();
			amountDEDTOT	= amountDEDTOT .add(amountDED);
		}
		else
		{
			conceptDeductId = "0";
			amountDED		= new BigDecimal("0.00");
		}

		
   		for (int j = 0; j < numOfConcepts; j++) 
   		{ 
 			code 	= ((BigDecimal)listDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,DECCONCEPTS_CUR)).toString();
			descr	= (String)listDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,DECCONCEPTS_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=conceptDeductId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
      
      </TD>	
      <TD></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="amountDED<%=k%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="15" value="<%=Format.formatCurrency(amountDED)%>"></TD>      
    </TR>
<% }%>        
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
    	<TD class="label">INSS LABORAL</TD>
        <TD></TD>
        <TD nowrap align="right"><input class="readonlyfield" type="text" name="inssLB<%=i%>" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDINSSLB_COLUMN,i,PAYSALARY_CUR))%>" readOnly></TD>             	
	</TR>
	<TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
    	<TD class="label">IR</TD>
        <TD></TD>
        <TD nowrap align="right"><input class="readonlyfield" type="text" name="ir<%=i%>" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDIR_COLUMN,i,PAYSALARY_CUR))%>" readOnly></TD>             	
	</TR>
    <TR class="tableheaderY">
    	<TD colspan="2" align="right">TOTAL DEDUCCIONES</TD>
        <TD nowrap align="right"><input class="readonlyfield" type="text" name="totDed<%=i%>" size="10" maxlength="21" value="<%=Format.formatCurrency(amountDEDTOT.add((BigDecimal)listDBBean.valueAtColumnRowResult(LDINSSLB_COLUMN,i,PAYSALARY_CUR)).add((BigDecimal)listDBBean.valueAtColumnRowResult(LDIR_COLUMN,i,PAYSALARY_CUR)))%>" readOnly></TD>             	
	</TR>	
    <TR class="tableheaderY">
    	<TD colspan="2" align="right">NETO A RECIBIR</TD>
        <TD nowrap align="right"><input class="readonlyfield" type="text" name="totNet<%=i%>" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDTOTNET_COLUMN,i,PAYSALARY_CUR))%>" readOnly></TD>             	
	</TR>
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
    	<TD class="label">INSS PATRONAL</TD>
        <TD></TD>
        <TD nowrap align="right"><input class="readonlyfield" type="text" name="inssPT<%=i%>" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDINSSPT_COLUMN,i,PAYSALARY_CUR))%>" readOnly></TD>             	
	</TR>
    <TR onClick ="this.style.backgroundColor='#00FA9A';" onMouseOver="this.style.backgroundColor='#00FA9A';this.style.cursor='hand';" onMouseOut="this.style.backgroundColor='#FFFFFF';">
    	<TD class="label">INATEC</TD>
        <TD></TD>
        <TD nowrap align="right"><input class="readonlyfield" type="text" name="inatec<%=i%>" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(LDINATEC_COLUMN,i,PAYSALARY_CUR))%>" readOnly></TD>             	
	</TR>
<%
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
 startIndex = i;
}

listDBBean.closeResultSet();
%>
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR>
    <TD width="30%" height="30">
		  <INPUT type="hidden" name="rows" value="<%=i%>">
		  <INPUT type="hidden" name="action" value="EMPLIQUPD">
		  <INPUT type="hidden" name="liquidationId" value="<%=liquidationId%>">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00008")%>" class="button">
	</TD>
    <TD align="center" width="35%" height="30"> 
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="button" name="cancel" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/liquidation/liquidationlist.jsp';">
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>