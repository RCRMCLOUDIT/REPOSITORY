<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
 static final String title = "Lista de Deducciones";

 static final int DEDUCTS_CUR = 1;

 static final int PDCONCID_COLUMN		= 1; 
 static final int PDNAME_COLUMN			= 2; 
 static final int PDFIXED_COLUMN		= 3; 
 static final int PDVARIABL_COLUMN		= 4; 
 static final int PDPAYTO_COLUMN		= 5;
 static final int PDSTATUS_COLUMN		= 7;
 static final int PDORDER_COLUMN		= 8; 
 static final int PDCOMINC_COLUMN		= 10;
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRINCDECTS('" + 
 					companyID + "',0,0,'','','','','','','','','','','','','','','','',0,'','','','2',0,'','','',0,0,'INCDEDLST','',?,?)}"; 
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
 					
 String link1 = baseLink + "deductionsupd.jsp?startIndex=" + startIndex + "&Id="; 
 String link2 = baseLink + "dedlistBAL.jsp?startIndex=" + startIndex + "&Id=";
 String link3 = contextRoot + "/servlet/com.cap.erp.report.PayRollInfoPDF?Id=";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(DEDUCTS_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="5">Lista de Deducciones</TD>
    </TR>
    <TR class="tableheader">
      <TD>Nombre</TD>
      <TD>Fija/Variable</TD>      
      <TD>Pagar A</TD>     
      <TD>Orden de Aplicacion</TD>              
      <TD>Estado</TD>                 
    </TR>
<%
String wageType = "";

 if (listDBBean.RowCountResult(DEDUCTS_CUR)==0) 
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
		String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(PDCONCID_COLUMN,i,DEDUCTS_CUR)).toString();	
		String link2s = link2 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(PDCONCID_COLUMN,i,DEDUCTS_CUR)).toString() + "&dedName=" + (String)listDBBean.valueAtColumnRowResult(PDNAME_COLUMN,i,DEDUCTS_CUR);	
		String link3s = link3 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(PDCONCID_COLUMN,i,DEDUCTS_CUR)).toString() + "&action=LOANRPT" + "&dedName=" + (String)listDBBean.valueAtColumnRowResult(PDNAME_COLUMN,i,DEDUCTS_CUR);;

 		String isFIXED = (String)(listDBBean.valueAtColumnRowResult(PDFIXED_COLUMN,i,DEDUCTS_CUR));
 		String dedType = (String)(listDBBean.valueAtColumnRowResult(PDCOMINC_COLUMN,i,DEDUCTS_CUR));
 		
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;	
		
		if(isFIXED.equals("Y"))
			wageType = "Fija";		
		else
			wageType = "Variable";		
			
		if(dedType.equals("I") || dedType.equals("E") || dedType.equals("D") || dedType.equals("T"))
		{
			link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Trabajar Prestamos/Deduciones" + ConstantValue.END_TAG;	
			link = link + ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Imprimir Saldos" + ConstantValue.END_TAG;
		}	
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD align="left" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 200, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)listDBBean.valueAtColumnRowResult(PDNAME_COLUMN,i,DEDUCTS_CUR)%></A></TD>    
      <TD nowrap><%=wageType%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(PDPAYTO_COLUMN,i,DEDUCTS_CUR)%></TD>      
      <TD nowrap><%=(BigDecimal)listDBBean.valueAtColumnRowResult(PDORDER_COLUMN,i,DEDUCTS_CUR)%></TD>        
      <TD nowrap><%=((String)listDBBean.valueAtColumnRowResult(PDSTATUS_COLUMN,i,DEDUCTS_CUR)).toString().equals("AC")?"Activo":"Inactivo"%></TD>       
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/deductions/deductionsadd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD align="center" width="35%" height="30">
    	<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/deductions/loanrptentry.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="go" value="Ver X Empleado" class="button">
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