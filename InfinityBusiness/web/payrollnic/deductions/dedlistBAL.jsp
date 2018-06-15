<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Lista de Deducciones</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Lista de Prestamos";

 static final int LOANS_CUR = 1;

 static final int LNLOANID_COLUMN		= 1;
 static final int LNCONCID_COLUMN		= 2;
 static final int LNEMPLID_COLUMN		= 3;
 static final int LNEMPLNM_COLUMN		= 4;
 static final int LNEMPLNUM_COLUMN		= 5;
 static final int LNLOANFDATE_COLUMN	= 6;
 static final int LNLOANTDATE_COLUMN	= 7;
 static final int LNLOANAMT_COLUMN		= 8;
 static final int LNLOANTIM_COLUMN		= 9;    
 static final int LNLOANRATE_COLUMN		= 10;              
 static final int LDLODEDAMT_COLUMN		= 11;               
 static final int LDLOANTIM_COLUMN		= 12;               
 static final int LDLOANBAL_COLUMN		= 13;
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 

 String deductionId = request.getParameter("Id")==null?"0":request.getParameter("Id");
 String dedName		=  request.getParameter("dedName")==null?"0":request.getParameter("dedName");

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRLOANS('" + 
 					companyID + "',0,0,"+ deductionId +",0,'','',0,0,'','LOANLST','" + user_ID + "','" + Format.getIPAddress(request).trim() + "',0,'',0,0,?,?)}"; 
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

 String baseLink = contextRoot + "/erp/payrollnic/deductions/";
 					
 String link1 = baseLink + "dedupdBAL.jsp?startIndex=" + startIndex + "&deductionId="; 
 String link2 = baseLink + "dedlistDET.jsp?startIndex=" + startIndex + "&deductionId=";
 
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(LOANS_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="10">Lista de Prestamos</TD>
    </TR>
    <TR class="tableheader">
    	<TD colspan="10"><%=dedName%></TD>
    </TR>
    <TR class="tableheader">
      <TD>Id Prestamo</TD>
      <TD>Nombre Empleado</TD>
      <TD>Desde</TD>     
      <TD>Hasta</TD>              
      <TD>Monto Total</TD>
      <TD>Monto Cuota</TD>
      <TD>Monto Total Deducido</TD>
      <TD>Plazo Total</TD> 
      <TD>Plazo Deducidos</TD>
      <TD>Balance</TD>                
    </TR>
<%
String wageType = "";

 if (listDBBean.RowCountResult(LOANS_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="5"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
	int monthDUE = 1;

// static final int LNEMPLID_COLUMN		= 3;
 	
		String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(LNCONCID_COLUMN,i,LOANS_CUR)).toString() + "&loanId=" + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(LNLOANID_COLUMN,i,LOANS_CUR)).toString() + "&dedName=" + dedName;	
		String link2s = link2 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(LNCONCID_COLUMN,i,LOANS_CUR)).toString() + "&loanId=" + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(LNLOANID_COLUMN,i,LOANS_CUR)).toString() + "&dedName=" + dedName;	
 		
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;	
		//link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Trabajar Saldos" + ConstantValue.END_TAG;	
		link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Revisar Detalle" + ConstantValue.END_TAG;
		
		monthDUE = Integer.valueOf(((BigDecimal)listDBBean.valueAtColumnRowResult(LNLOANTIM_COLUMN,i,LOANS_CUR)).divide(new BigDecimal("2")).intValue());
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
			Calendar cal = Calendar.getInstance(); 
            cal.setTime(((java.util.Date)(listDBBean.valueAtColumnRowResult(LNLOANTDATE_COLUMN,i,LOANS_CUR)))); 
            cal.add(Calendar.MONTH, monthDUE);      
            
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD align="center" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 120, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(BigDecimal)listDBBean.valueAtColumnRowResult(LNLOANID_COLUMN,i,LOANS_CUR)%></A></TD>    
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(LNEMPLNUM_COLUMN,i,LOANS_CUR) + " " + (String)listDBBean.valueAtColumnRowResult(LNEMPLNM_COLUMN,i,LOANS_CUR)%></TD>      
      <TD nowrap align="center"><%=Format.date_Str((listDBBean.valueAtColumnRowResult(LNLOANFDATE_COLUMN,i,LOANS_CUR)).toString())%></TD>
      <TD nowrap align="center"><%=Format.date_Str((listDBBean.valueAtColumnRowResult(LNLOANTDATE_COLUMN,i,LOANS_CUR)).toString())%></TD>
      <TD nowrap align="right"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LNLOANAMT_COLUMN,i,LOANS_CUR)))%></TD>        
      <TD nowrap align="right"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LNLOANRATE_COLUMN,i,LOANS_CUR)))%></TD>
	  <TD nowrap align="right"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LDLODEDAMT_COLUMN,i,LOANS_CUR)))%></TD>
      <TD nowrap align="center"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LNLOANTIM_COLUMN,i,LOANS_CUR)))%></TD>
      <TD nowrap align="center"><%=listDBBean.valueAtColumnRowResult(LDLOANTIM_COLUMN,i,LOANS_CUR)==null?"0":listDBBean.valueAtColumnRowResult(LDLOANTIM_COLUMN,i,LOANS_CUR)%></TD>       
      <TD nowrap align="right"><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LDLOANBAL_COLUMN,i,LOANS_CUR)))%></TD>
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/deductions/dedaddBAL.jsp?deductionId=<%=deductionId%>&dedName=<%=dedName%>">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
		</TD>
	    <TD align="center" width="35%" height="30">   
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/deductions/deductionslist.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00010")%>" class="button">
		</FORM>
	    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>