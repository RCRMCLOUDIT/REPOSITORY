<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Retenciones de Ley</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Retenciones de Ley";

 static final int TAXES_CUR = 1;

 static final int TXTAXID_COLUMN		= 1; //ID COLUMN
 static final int TXTAXNM_COLUMN		= 2; //NAME
 static final int TXTAXORD_COLUMN		= 3; //TAX ORDER APP
 static final int TXCALBSON_COLUMN		= 4; //TAX CAL BASE ON
 static final int TXPAYEID_COLUMN		= 5; //TAX PAY TO WHOM 
 static final int TXISSS_COLUMN			= 6;
 static final int TXISIR_COLUMN			= 7;
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRTAXES('" + 
 					companyID + "',0,0,'','',0,'','','',0,'','','','','','','','','','',0,0,0,0,'','','TAXLST',0,?,?)}"; 
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

 String baseLink = contextRoot + "/erp/payrollnic/taxes/";
 					
 String link1 = baseLink + "taxupd.jsp?startIndex=" + startIndex + "&Id=";
 String link2 = baseLink + "taxirlist.jsp?startIndex=" + startIndex + "&taxId="; 
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(TAXES_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="5">Retenciones de Ley</TD>
    </TR>
    <TR class="tableheader">
      <TD>Id de Retencion</TD>
      <TD>Nombre</TD>
      <TD>Orden de Aplicacion</TD>      
      <TD>Calculo Basado En</TD>            
      <TD>Entidad</TD>      
    </TR>
<%
String calBSON = "";
String taxType = "";

 if (listDBBean.RowCountResult(TAXES_CUR)==0) 
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
		String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(TXTAXID_COLUMN,i,TAXES_CUR)).toString();	
		String link2s = link2 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(TXTAXID_COLUMN,i,TAXES_CUR)).toString();	

 		String isIR = (String)(listDBBean.valueAtColumnRowResult(TXISIR_COLUMN,i,TAXES_CUR));
 
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;	

		if(isIR.equals("Y"))
			link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Tabla IR" + ConstantValue.END_TAG;	
		
		calBSON = (String)(listDBBean.valueAtColumnRowResult(TXCALBSON_COLUMN,i,TAXES_CUR));
		
		if(calBSON.equals("PR"))
			calBSON = "Porcentaje";
		else if(calBSON.equals("AM"))
			calBSON = "Monto";
		else					
			calBSON = "Otro";
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD align="center" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 80, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(BigDecimal)listDBBean.valueAtColumnRowResult(TXTAXID_COLUMN,i,TAXES_CUR)%></A></TD>    
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(TXTAXNM_COLUMN,i,TAXES_CUR))%></TD>
      <TD nowrap><%=(BigDecimal)(listDBBean.valueAtColumnRowResult(TXTAXORD_COLUMN,i,TAXES_CUR))%></TD>      
      <TD nowrap><%=calBSON%></TD>      
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(TXPAYEID_COLUMN,i,TAXES_CUR))%></TD>       
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/taxes/taxadd.jsp">
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