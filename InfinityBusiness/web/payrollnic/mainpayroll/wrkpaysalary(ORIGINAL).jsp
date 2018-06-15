<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Nomina Quincenal</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Nomina Quincenal";

 static final int PAYSALARY_CUR = 1;

 static final int PLLINEID_COLUMN 		= 1; 
 static final int PLEMPLID_COLUMN 		= 2;
 static final int PLEMPLNUM_COLUMN 		= 3;
 static final int PLEMPLNM_COLUMN 		= 4;
 static final int PLEMPLSAL_COLUMN 		= 5;
 static final int PLEMPLSALQT_COLUMN 	= 6;
 static final int PLEMPLAGN_COLUMN 		= 7;
 static final int PLEMPLAGNQT_COLUMN 	= 8;
 static final int PLAGINGYN_COLUMN 		= 9;
 static final int PLAGINLESS_COLUMN 	= 10;
 static final int PLDAYSMISS_COLUMN 	= 11;
 static final int PLMISSAMT_COLUMN 		= 12;
 static final int PLSICKCAT_COLUMN 		= 13;
 static final int PLSICKDAYS_COLUMN 	= 14;
 static final int PLEXHR_COLUMN 		= 15;
 static final int PLEXHRAMT_COLUMN 		= 16;
 static final int PLVACDAYS_COLUMN 		= 17;
 static final int PLVACSAMT_COLUMN 		= 18;
 static final int PLRVACDAYS_COLUMN 	= 19;
 static final int PLRVACAMT_COLUMN 		= 20;
 static final int PLINTERN_COLUMN 		= 21;
 static final int PLTOTAL_COLUMN 		= 22;
 static final int ETEMPTYPAV_COLUMN 	= 23; 
 static final int CSCOMPSCTAV_COLUMN 	= 24;  
 static final int PLSICKAMT_COLUMN 		= 25;     
 static final int PLSEPHR_COLUMN 		= 26;
 static final int PLSEPHRAMT_COLUMN 	= 27;
 static final int PLWRKDAYS_COLUMN 	= 28;
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/paysalary.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String payrollId = request.getParameter("payrollId")==null?"0":request.getParameter("payrollId");
 String sectionId = request.getParameter("sectionId")==null?"0":request.getParameter("sectionId");

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRPAYSALAS('" + 
 					companyID + "'," + 
 					companyEID + ",0," + payrollId + ",0,0,'',0," + sectionId + ",'','','','LSTPAYSAL',?,?)}"; 
 					
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
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(PAYSALARY_CUR);
%>
<FORM name = "myForm" method="post" action="<%=contextRoot%>/erp/payrollnic/mainpayroll/prpaysalas.jsp">
<TABLE width="1000" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="23">Nomina Quincenal</TD>
    </TR>
    <TR class="tableheader">
      <TD>Seccion</TD>
      <TD>Numero</TD>      
      <TD>Nombre</TD>      
      <TD>Salario Basico</TD>
      <TD>Quincenal</TD>
      <TD>Antiguedad Mensual</TD>
      <TD>Antiguedad Quincenal</TD>
      <TD>Horas Extras</TD>
      <TD>Monto Horas Extras</TD>
      <TD>Feriado/Septimo Laborado</TD>
      <TD>Monto Feriado/Septimo Laborado</TD>
      <TD>Vacaciones Pagadas</TD>
      <TD>Monto VP</TD>
      <TD>Categoria Subsidio</TD>
      <TD>Dias Subsidio</TD>
	  <TD>Monto Subsidio</TD>    
      <TD>Dias Falta</TD>
      <TD>Monto Dias Falta</TD>
      <TD>Antiguedad Falta</TD>                                          
      <TD>Vacaciones Descansadas</TD>
      <TD>Monto VD</TD>                             
	  <TD>Interinato</TD>                                          
	  <TD>Total</TD>                                           	   	  
    </TR>
<%

 if (listDBBean.RowCountResult(PAYSALARY_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="21"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
		//String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(PYPAYRLLID_COLUMN,i,PAYROLLS_CUR)).toString();	
 
		//link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;	
		
	    //link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Trabajar Planilla Quincenal" + ConstantValue.END_TAG;	
/*
 static final int ETEMPTYPAV_COLUMN 	= 23; 

*/    		
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap align="left">
    	<INPUT type="hidden" name="updRec<%=i%>" value="Y">            
    	<INPUT type="hidden" name="lineId<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLLINEID_COLUMN,i,PAYSALARY_CUR)%>">      
    	<INPUT type="hidden" name="wrkDays<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLWRKDAYS_COLUMN,i,PAYSALARY_CUR)%>">      
    	<INPUT type="hidden" name="employeeId<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLID_COLUMN,i,PAYSALARY_CUR)%>">
      	<%=(String)listDBBean.valueAtColumnRowResult(CSCOMPSCTAV_COLUMN,i,PAYSALARY_CUR)%>
      </TD>    
      <TD nowrap align="left"><%=(String)listDBBean.valueAtColumnRowResult(PLEMPLNUM_COLUMN,i,PAYSALARY_CUR)%></TD>
      <TD nowrap align="left"><%=(String)listDBBean.valueAtColumnRowResult(PLEMPLNM_COLUMN,i,PAYSALARY_CUR)%></TD>
      <TD nowrap align="right">
      	<INPUT type="hidden" name="salary<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLSAL_COLUMN,i,PAYSALARY_CUR)%>">
      	<%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLSAL_COLUMN,i,PAYSALARY_CUR))%>
      </TD>
      <TD nowrap align="right">
	<INPUT type="hidden" name="salaryQTOR<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLSALQT_COLUMN,i,PAYSALARY_CUR)%>">
	<INPUT type="text" class="readonlyfield" name="salaryQT<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLSALQT_COLUMN,i,PAYSALARY_CUR)%>" readOnly>
      <TD nowrap align="right">
      	<INPUT type="hidden" name="aging<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLAGN_COLUMN,i,PAYSALARY_CUR)%>">      
      	<%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLAGN_COLUMN,i,PAYSALARY_CUR))%>
      </TD>
      <TD nowrap align="right">
      	<INPUT type="hidden" name="agingQT<%=i%>" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLAGNQT_COLUMN,i,PAYSALARY_CUR)%>">      
      	<%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEMPLAGNQT_COLUMN,i,PAYSALARY_CUR))%>
      </TD> 
      <TD nowrap align="right"><input class="textfield" type="text" name="exHR<%=i%>" onBlur="cal_hrExtAmt(<%=i%>);" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLEXHR_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="exHRAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLEXHRAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>
     
      <TD nowrap align="right"><input class="textfield" type="text" name="septHR<%=i%>" onBlur="cal_septExtAmt(<%=i%>);" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLSEPHR_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="septHRAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLSEPHRAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>
     
      <TD nowrap align="right"><input class="textfield" type="text" name="vacDays<%=i%>" onBlur="cal_vacsAmt(<%=i%>,'N');" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLVACDAYS_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="vacAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLVACSAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>
      <TD nowrap align="right"><input type="text" name="sickCat<%=i%>" size="5" maxlength="5" value="<%=((String)listDBBean.valueAtColumnRowResult(PLSICKCAT_COLUMN,i,PAYSALARY_CUR)).toString().trim()%>"></TD>                              
      <TD nowrap align="right"><input class="textfield" type="text" name="sickDays<%=i%>" onBlur="cal_sicksAmt(<%=i%>);" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLSICKDAYS_COLUMN,i,PAYSALARY_CUR)%>"></TD>                              
      <TD nowrap align="right"><input class="textfield" type="text" name="sickAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLSICKAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>                                                

 
      <TD nowrap align="right"><input class="textfield" type="text" name="daysMiss<%=i%>" onBlur="cal_missesAmt(<%=i%>);" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLDAYSMISS_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="amountMiss<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLMISSAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="agingMiss<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLAGINLESS_COLUMN,i,PAYSALARY_CUR))%>"></TD>                                                
      <TD nowrap align="right"><input class="textfield" type="text" name="rvacDays<%=i%>" onBlur="cal_vacsAmt(<%=i%>,'R');" size="2" maxlength="5" value="<%=(BigDecimal)listDBBean.valueAtColumnRowResult(PLRVACDAYS_COLUMN,i,PAYSALARY_CUR)%>"></TD>
      <TD nowrap align="right"><input class="textfield" type="text" name="rvacAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLRVACAMT_COLUMN,i,PAYSALARY_CUR))%>"></TD>                              
      <TD nowrap align="right"><input class="textfield" type="text" name="interAmt<%=i%>" onBlur="cal_totAmt(<%=i%>);" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLINTERN_COLUMN,i,PAYSALARY_CUR))%>"></TD>                                                
	  <TD nowrap align="right"><input class="textfield" type="text" name="totalAmt<%=i%>" size="10" maxlength="21" value="<%=Format.formatCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(PLTOTAL_COLUMN,i,PAYSALARY_CUR))%>"></TD>                                                      
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
		  <INPUT type="hidden" name="action" value="UPDPAYSALR">
		  <INPUT type="hidden" name="payrollId" value="<%=payrollId%>">
		  <INPUT type="hidden" name="sectionId" value="<%=sectionId%>">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00008")%>" class="button">
	</TD>
    <TD align="center" width="35%" height="30"> 
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="button" name="cancel" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/mainpayroll/wrkpaysalarybysect.jsp?payrollId=<%=payrollId%>';">
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