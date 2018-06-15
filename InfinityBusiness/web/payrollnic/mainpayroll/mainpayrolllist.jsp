<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Trabajar con Nominas</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Trabajar con Nominas";

 static final int PAYROLLS_CUR = 1;
 static final int EMPTYPES_CUR = 2;

 static final int PYPAYRLLID_COLUMN		= 1; 
 static final int PYMEMO_COLUMN			= 2; 
 static final int CURRENCY_COLUMN		= 3; 
 static final int GENYN_COLUMN			= 4;
 static final int TOTINCPY_COLUMN		= 5;  
 static final int PYEMPLTYPE_COLUMN		= 6;  
 static final int TOTINCOME_COLUMN		= 7;  
 static final int TOTDEDUCT_COLUMN		= 8;
 static final int TOTINSS_COLUMN		= 9;
 static final int TOTIR_COLUMN			= 10;
 static final int STATUS_COLUMN			= 11;
 static final int PYDTFROM_COLUMN		= 12;
 static final int PYDTTO_COLUMN			= 13;
 static final int PYDECPAY_COLUMN		= 14;
 
 static final int ETEMPTYPID_COLUMN		= 1;
 static final int ETEMPTYPDS_COLUMN		= 2;
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/mainpayroll.js"></SCRIPT>

<%
 String _tabName = request.getParameter("tabName")==null?"Nomina Ordinaria":request.getParameter("tabName");

 String emptTypeId = request.getParameter("emptTypeId")==null?"1":request.getParameter("emptTypeId");	

 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCRTPARS('" + 
 					companyID + "'," + companyEID + ",0,'',''," + emptTypeId + ",'','','','','',0,0,0,0,'LSTPYR',?,?)}"; 
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
int startIndex = (request.getParameter("startIndex")==null) ? 0 : Integer.parseInt(request.getParameter("startIndex").trim());
int i = 0;

 String link = null;

 String baseLink = contextRoot + "/erp/payrollnic/mainpayroll/";
 					
 String link1 = baseLink + "mainpayrollupd.jsp?startIndex=" + startIndex + "&payrollId=";
 String link2 = baseLink + "prpaysalas.jsp?startIndex=" + startIndex + "&payrollId="; 
 String link3 = baseLink + "wrkpaysalarybysect.jsp?startIndex=" + startIndex + "&payrollId=";  
 String link4 = baseLink + "wrkfixedincomeslist.jsp?startIndex=" + startIndex + "&payrollId=";  
 String link5 = baseLink + "wrkvariableincomeslist.jsp?startIndex=" + startIndex + "&payrollId=";  
 String link6 = baseLink + "wrkvariabledeductslist.jsp?startIndex=" + startIndex + "&payrollId=";  
 String link7 = baseLink + "mainpayrolllist.jsp?startIndex=" + startIndex + "&payrollId=";  
 
 String link8 = contextRoot + "/servlet/com.cap.erp.report.PayRollInfoPDF?payrollId=";
   
 listDBBean.execute(); 

 int numOfRows  = listDBBean.getRowsInResult(PAYROLLS_CUR);
 int numOfRows2 = listDBBean.getRowsInResult(EMPTYPES_CUR);
 
 BigDecimal tIncome = new BigDecimal("0.00");
 BigDecimal vIncome = new BigDecimal("0.00"); //Variable Income and Fixed Income
 BigDecimal pIncome = new BigDecimal("0.00"); //Payroll Income
 BigDecimal tpNet	= new BigDecimal("0.00"); //Total Net Pay Payroll
 
 String status		= "";
 String currId		= "";
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
   <TR><TD colspan="7"><%@ include file="mainpayrolltab.jspf" %></TD></TR>
    <TR class="tableheader">
    	<TD colspan="7">Trabajar con Nominas</TD>
    </TR>
    <TR class="tableheader">
      <TD>Descripcion</TD>
      <TD>Moneda</TD>      
      <TD>Total Percepciones</TD> 
      <TD>Total Deducciones</TD>             
      <TD>Total INSS</TD>                   
      <TD>Total IR</TD>             
      <TD>Total Nomina</TD>             
    </TR>
<%
 int day = 0;

 if (listDBBean.RowCountResult(PAYROLLS_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="7"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
	 	String tDate 	= Format.displayDate(((Date)listDBBean.valueAtColumnRowResult(PYDTTO_COLUMN,i,PAYROLLS_CUR)).toString());
	 	String sDay	  	= tDate.substring(3,5);
	 	String sMonth 	= tDate.substring(0,2);
		currId			= (String)listDBBean.valueAtColumnRowResult(CURRENCY_COLUMN,i,PAYROLLS_CUR).toString().trim();
	 	
		String link1s = link1 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString();	
 		String link3s = link3 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString();			
		String link2s = link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=GENQUSALY" + "&emplType=" + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYEMPLTYPE_COLUMN,i,PAYROLLS_CUR)).toString().trim();
 		String link4s = link4 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&concepType=I&fixOrVar=F";
 		String link5s = link5 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&concepType=I&fixOrVar=V"; 		
 		String link6s = link6 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&concepType=D&fixOrVar=V"; 		
		String link9s 	= link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=CALINSS";	 		 
		String link10s 	= link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=CALIR";	 		 		
		String link21s 	= link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=VALREGAUS";
		String link23s 	= link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=GENJRN";

		//DELETE AFTER OPTION
		String link34s = link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=UPDLINES" + "&emplType=" + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYEMPLTYPE_COLUMN,i,PAYROLLS_CUR)).toString().trim();

		//REPORTS
 		String link8s  = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=RPTPAYINF&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);	 		 		
		String link12s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=INDEREP&type=I&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);		 		 	
		String link13s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=INDEREP&type=D&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link14s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=BNKRPTPDF&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link15s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=VACRPTPDF&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link17s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=BNKRPTXLS&fDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTFROM_COLUMN,i,PAYROLLS_CUR).toString()) + "&tDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTTO_COLUMN,i,PAYROLLS_CUR).toString()) + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link18s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&sectionId=0&action=LSTPAYSAL&fDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTFROM_COLUMN,i,PAYROLLS_CUR).toString()) + "&tDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTTO_COLUMN,i,PAYROLLS_CUR).toString()) + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link19s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=OINDECREP&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link20s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=OINDECREPXLS&fDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTFROM_COLUMN,i,PAYROLLS_CUR).toString()) + "&tDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTTO_COLUMN,i,PAYROLLS_CUR).toString()) + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link27s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=COLRPT&currId=" + currId;
		
		String link16s = "";
		String link22s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=DECRPT&decPay=" + ((String)listDBBean.valueAtColumnRowResult(PYDECPAY_COLUMN,i,PAYROLLS_CUR)).toString() + "&otherAmount=" + ((BigDecimal)listDBBean.valueAtColumnRowResult(TOTDEDUCT_COLUMN,i,PAYROLLS_CUR)).toString() + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link31s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=DECRPTXLS&decPay=" + ((String)listDBBean.valueAtColumnRowResult(PYDECPAY_COLUMN,i,PAYROLLS_CUR)).toString() + "&otherAmount=" + ((BigDecimal)listDBBean.valueAtColumnRowResult(TOTDEDUCT_COLUMN,i,PAYROLLS_CUR)).toString() + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link24s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=VACRPTXLS&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		
		String link25s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=RMSRPT&tDate=" + tDate + "&sDate=" + sDay + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);	 		 		
		String link28s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=RMSRPTXLS&tDate=" + tDate + "&sDate=" + sDay + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link29s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=RMSCHR&tDate=" + tDate + "&sDate=" + sDay + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link32s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=XLSJRN&fDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTFROM_COLUMN,i,PAYROLLS_CUR).toString()) + "&tDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTTO_COLUMN,i,PAYROLLS_CUR).toString()) + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		String link33s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=INDRPTXLS&fDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTFROM_COLUMN,i,PAYROLLS_CUR).toString()) + "&tDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTTO_COLUMN,i,PAYROLLS_CUR).toString()) + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		
		if(((String)listDBBean.valueAtColumnRowResult(PYDECPAY_COLUMN,i,PAYROLLS_CUR)).toString().equals("N"))
		{
			link16s= link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=TCKPAY&fDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTFROM_COLUMN,i,PAYROLLS_CUR).toString()) + "&tDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTTO_COLUMN,i,PAYROLLS_CUR).toString()) + "&decPay=N&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);		
					 
		}
		else
		{
			link16s= link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=TCKPAY&fDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTFROM_COLUMN,i,PAYROLLS_CUR).toString()) + "&tDate=" + Format.date_Str(listDBBean.valueAtColumnRowResult(PYDTTO_COLUMN,i,PAYROLLS_CUR).toString()) + "&decPay=Y&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
		}
		
		String link11s 	= link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=CLSPAY";
		String link26s 	= link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=CLSDECPAY";
		String link30s 	= link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=CLSYEAR";
		
		//String link35s = link8 + ((BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString() + "&action=INSRPTXLS&tDate=" + tDate + "&sDate=" + sDay + "&currId=" + currId + "&descr=" + (String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR);
				
		vIncome = (BigDecimal)listDBBean.valueAtColumnRowResult(TOTINCOME_COLUMN,i,PAYROLLS_CUR);
		pIncome = (BigDecimal)listDBBean.valueAtColumnRowResult(TOTINCPY_COLUMN,i,PAYROLLS_CUR);	
		
		tIncome = vIncome.add(pIncome);
		
		status = (String)listDBBean.valueAtColumnRowResult(STATUS_COLUMN,i,PAYROLLS_CUR);
		
		tpNet	= tIncome.subtract((BigDecimal)listDBBean.valueAtColumnRowResult(TOTDEDUCT_COLUMN,i,PAYROLLS_CUR)).subtract((BigDecimal)listDBBean.valueAtColumnRowResult(TOTINSS_COLUMN,i,PAYROLLS_CUR)).subtract((BigDecimal)listDBBean.valueAtColumnRowResult(TOTIR_COLUMN,i,PAYROLLS_CUR));
		


	if(!status.equals("AP"))
	{
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;

		if(((String)listDBBean.valueAtColumnRowResult(PYDECPAY_COLUMN,i,PAYROLLS_CUR)).toString().equals("N"))
		{
			if(((BigDecimal)listDBBean.valueAtColumnRowResult(GENYN_COLUMN,i,PAYROLLS_CUR)).signum() == 0)
			{
				link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Generar Planilla Quincenal" + ConstantValue.END_TAG;		
			}	
			else
			{
				link = link + ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Trabajar Planilla Quincenal" + ConstantValue.END_TAG;		
				link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Regenerar Planilla Quincenal" + ConstantValue.END_TAG;	    
				//link = link + ConstantValue.PRE_TAG + link34s + ConstantValue.MID_TAG + "Actualizar Lineas" + ConstantValue.END_TAG;	    	    	    					    	    
			}
	
			link = link + ConstantValue.PRE_TAG + link4s + ConstantValue.MID_TAG + "Percepciones Fijas" + ConstantValue.END_TAG;			
			link = link + ConstantValue.PRE_TAG + link5s + ConstantValue.MID_TAG + "Percepciones Variables" + ConstantValue.END_TAG;			
			//link = link + ConstantValue.PRE_TAG + link7 + ConstantValue.MID_TAG + "Deducciones Fijas" + ConstantValue.END_TAG;			
		   	//link = link + ConstantValue.PRE_TAG + link6s + ConstantValue.MID_TAG + "Deducciones Variables" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link6s + ConstantValue.MID_TAG + "Deducciones" + ConstantValue.END_TAG;		
	    	link = link + ConstantValue.PRE_TAG + link10s + ConstantValue.MID_TAG + "Calcular IR" + ConstantValue.END_TAG;
	    	link = link + ConstantValue.PRE_TAG + link9s + ConstantValue.MID_TAG + "Calcular INSS" + ConstantValue.END_TAG;
	    	link = link + ConstantValue.PRE_TAG + link21s + ConstantValue.MID_TAG + "Validar Esquelas de Empleados" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link8s + ConstantValue.MID_TAG + "Informacion Planilla" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link19s + ConstantValue.MID_TAG + "Reporte de Otros Ingresos/Deducciones" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link20s + ConstantValue.MID_TAG + "Reporte de Otros Ingresos/Deducciones XLS" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link12s + ConstantValue.MID_TAG + "Reporte de Ingresos Planilla" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link13s + ConstantValue.MID_TAG + "Reporte de Egresos Planilla" + ConstantValue.END_TAG;
		    link = link + ConstantValue.PRE_TAG + link14s + ConstantValue.MID_TAG + "Detalle de Banco PDF" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link17s + ConstantValue.MID_TAG + "Detalle de Banco XLS" + ConstantValue.END_TAG;	    	   
		    //link = link + ConstantValue.PRE_TAG + link15s + ConstantValue.MID_TAG + "Reporte de Vacaciones PDF" + ConstantValue.END_TAG;
			//link = link + ConstantValue.PRE_TAG + link24s + ConstantValue.MID_TAG + "Reporte de Vacaciones XLS" + ConstantValue.END_TAG;		    	 
			//link = link + ConstantValue.PRE_TAG + link22s + ConstantValue.MID_TAG + "Reporte de Aguinaldo" + ConstantValue.END_TAG;	 		
			//link = link + ConstantValue.PRE_TAG + link35s + ConstantValue.MID_TAG + "Reporte INSS" + ConstantValue.END_TAG;
			
			if(Integer.parseInt(sDay) > 15)
			{
				link = link + ConstantValue.PRE_TAG + link25s + ConstantValue.MID_TAG + "Reporte de Consolidado PDF(RMS)" + ConstantValue.END_TAG;
				link = link + ConstantValue.PRE_TAG + link28s + ConstantValue.MID_TAG + "Reporte de Consolidado XLS(RMS)" + ConstantValue.END_TAG;
				link = link + ConstantValue.PRE_TAG + link29s + ConstantValue.MID_TAG + "Reporte de Consolidado Grafico(RMS)" + ConstantValue.END_TAG;
				link = link + ConstantValue.PRE_TAG + link27s + ConstantValue.MID_TAG + "Reporte de Colaboradores" + ConstantValue.END_TAG;
				//link = link + ConstantValue.PRE_TAG + link35s + ConstantValue.MID_TAG + "Reporte INSS Mensual" + ConstantValue.END_TAG;
			}			
			link = link + ConstantValue.PRE_TAG + link16s + ConstantValue.MID_TAG + "Ticket de Pagos" + ConstantValue.END_TAG;	
			link = link + ConstantValue.PRE_TAG + link18s + ConstantValue.MID_TAG + "Formato de Planilla Quincenal(XLS)" + ConstantValue.END_TAG;	
			//REMEMBER TO REMOVE AFTE
			link = link + ConstantValue.PRE_TAG + link23s + ConstantValue.MID_TAG + "Generar Comprobante" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link32s + ConstantValue.MID_TAG + "Comprobante XLS" + ConstantValue.END_TAG;
			//
    		link = link + ConstantValue.PRE_TAG + link11s + ConstantValue.MID_TAG + "Cerrar Planilla" + ConstantValue.END_TAG;
    	}
    	else
    	{
		   	link = link + ConstantValue.PRE_TAG + link6s + ConstantValue.MID_TAG + "Deducciones Variables" + ConstantValue.END_TAG;    	

		   	link = link + ConstantValue.PRE_TAG + link19s + ConstantValue.MID_TAG + "Reporte de Otros Ingresos/Deducciones" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link20s + ConstantValue.MID_TAG + "Reporte de Otros Ingresos/Deducciones XLS" + ConstantValue.END_TAG;
		    link = link + ConstantValue.PRE_TAG + link14s + ConstantValue.MID_TAG + "Detalle de Banco PDF" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link17s + ConstantValue.MID_TAG + "Detalle de Banco XLS" + ConstantValue.END_TAG;	    	   
			link = link + ConstantValue.PRE_TAG + link22s + ConstantValue.MID_TAG + "Reporte de Aguinaldo" + ConstantValue.END_TAG;	 		
			link = link + ConstantValue.PRE_TAG + link16s + ConstantValue.MID_TAG + "Ticket de Pagos" + ConstantValue.END_TAG;	
    		link = link + ConstantValue.PRE_TAG + link26s + ConstantValue.MID_TAG + "Cerrar Planilla" + ConstantValue.END_TAG;
    	}
	}
	else
	{
		if(((String)listDBBean.valueAtColumnRowResult(PYDECPAY_COLUMN,i,PAYROLLS_CUR)).toString().equals("N"))
		{
		   	link = ConstantValue.PRE_TAG + link8s + ConstantValue.MID_TAG + "Informacion Planilla" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link19s + ConstantValue.MID_TAG + "Reporte de Otros Ingresos/Deducciones" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link20s + ConstantValue.MID_TAG + "Reporte de Otros Ingresos/Deducciones XLS" + ConstantValue.END_TAG;	   	
		   	link = link + ConstantValue.PRE_TAG + link12s + ConstantValue.MID_TAG + "Reporte de Ingresos Planilla" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link13s + ConstantValue.MID_TAG + "Reporte de Egresos Planilla" + ConstantValue.END_TAG;
		    link = link + ConstantValue.PRE_TAG + link14s + ConstantValue.MID_TAG + "Detalle de Banco PDF" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link17s + ConstantValue.MID_TAG + "Detalle de Banco XLS" + ConstantValue.END_TAG;	    	   
			//link = link + ConstantValue.PRE_TAG + link35s + ConstantValue.MID_TAG + "Reporte INSS" + ConstantValue.END_TAG;
			
			link = link + ConstantValue.PRE_TAG + link15s + ConstantValue.MID_TAG + "Reporte de Vacaciones PDF" + ConstantValue.END_TAG;
		    link = link + ConstantValue.PRE_TAG + link24s + ConstantValue.MID_TAG + "Reporte de Vacaciones XLS" + ConstantValue.END_TAG;		    	 
			link = link + ConstantValue.PRE_TAG + link22s + ConstantValue.MID_TAG + "Reporte de Aguinaldo PDF" + ConstantValue.END_TAG;
		    link = link + ConstantValue.PRE_TAG + link31s + ConstantValue.MID_TAG + "Reporte de Aguinaldo XLS" + ConstantValue.END_TAG;
			
			if(Integer.parseInt(sDay) > 15)
			{			
				link = link + ConstantValue.PRE_TAG + link25s + ConstantValue.MID_TAG + "Reporte de Consolidado PDF(RMS)" + ConstantValue.END_TAG;
				link = link + ConstantValue.PRE_TAG + link28s + ConstantValue.MID_TAG + "Reporte de Consolidado XLS(RMS)" + ConstantValue.END_TAG;
				link = link + ConstantValue.PRE_TAG + link29s + ConstantValue.MID_TAG + "Reporte de Consolidado Grafico(RMS)" + ConstantValue.END_TAG;				
		    	link = link + ConstantValue.PRE_TAG + link27s + ConstantValue.MID_TAG + "Reporte de Colaboradores" + ConstantValue.END_TAG;
		    	link = link + ConstantValue.PRE_TAG + link33s + ConstantValue.MID_TAG + "Reporte de Indemnización" + ConstantValue.END_TAG;
				//link = link + ConstantValue.PRE_TAG + link35s + ConstantValue.MID_TAG + "Reporte INSS Mensual" + ConstantValue.END_TAG;		    	
		    }
			link = link + ConstantValue.PRE_TAG + link16s + ConstantValue.MID_TAG + "Ticket de Pagos" + ConstantValue.END_TAG;	
			link = link + ConstantValue.PRE_TAG + link18s + ConstantValue.MID_TAG + "Formato de Planilla Quincenal(XLS)" + ConstantValue.END_TAG;		   			   	   				   	      	    
			link = link + ConstantValue.PRE_TAG + link23s + ConstantValue.MID_TAG + "Generar Comprobante" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link32s + ConstantValue.MID_TAG + "Comprobante XLS" + ConstantValue.END_TAG;
			
		    if(Integer.parseInt(sDay) > 15 && Integer.parseInt(sMonth) == 12)
			{
				link = link + ConstantValue.PRE_TAG + link30s + ConstantValue.MID_TAG + "Cerrar Año Nominal" + ConstantValue.END_TAG;
			}
		}
		else
    	{
		   	link = ConstantValue.PRE_TAG + link19s + ConstantValue.MID_TAG + "Reporte de Otros Ingresos/Deducciones" + ConstantValue.END_TAG;
		   	link = link + ConstantValue.PRE_TAG + link20s + ConstantValue.MID_TAG + "Reporte de Otros Ingresos/Deducciones XLS" + ConstantValue.END_TAG;
		    link = link + ConstantValue.PRE_TAG + link14s + ConstantValue.MID_TAG + "Detalle de Banco PDF" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link17s + ConstantValue.MID_TAG + "Detalle de Banco XLS" + ConstantValue.END_TAG;	    	   
			link = link + ConstantValue.PRE_TAG + link22s + ConstantValue.MID_TAG + "Reporte de Aguinaldo PDF" + ConstantValue.END_TAG;	 		
			link = link + ConstantValue.PRE_TAG + link31s + ConstantValue.MID_TAG + "Reporte de Aguinaldo XLS" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link16s + ConstantValue.MID_TAG + "Ticket de Pagos" + ConstantValue.END_TAG;	
			link = link + ConstantValue.PRE_TAG + link23s + ConstantValue.MID_TAG + "Generar Comprobante" + ConstantValue.END_TAG;
			link = link + ConstantValue.PRE_TAG + link32s + ConstantValue.MID_TAG + "Comprobante XLS" + ConstantValue.END_TAG;			
    		//link = link + ConstantValue.PRE_TAG + link35s + ConstantValue.MID_TAG + "Reporte INSS" + ConstantValue.END_TAG;
    	}
	}	
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD align="left" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 250, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,10000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)listDBBean.valueAtColumnRowResult(PYMEMO_COLUMN,i,PAYROLLS_CUR)%></A></TD>    
      <TD nowrap><%=currId%></TD>
      <TD nowrap align="right"><%=Format.displayCurrency(tIncome)%></TD>
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(TOTDEDUCT_COLUMN,i,PAYROLLS_CUR))%></TD>  
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(TOTINSS_COLUMN,i,PAYROLLS_CUR))%></TD>            
      <TD nowrap align="right"><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(TOTIR_COLUMN,i,PAYROLLS_CUR))%></TD> 
	  <TD nowrap align="right"><%=Format.displayCurrency(tpNet)%></TD>                 
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
    <TR><TD width="30%" height="30">
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/mainpayroll/mainpayrolladd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD align="center" width="35%" height="30">   
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>