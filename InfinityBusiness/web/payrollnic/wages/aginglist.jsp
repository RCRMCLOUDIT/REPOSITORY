<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Tabla de Antiguedad</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Tabla de Antiguedad";

 static final int AGING_CUR = 1;

 static final int AGROWID_COLUMN		= 1; 
 static final int AGYEARS_COLUMN		= 2; 
 static final int AGPERCENT_COLUMN		= 3; 
 static final int AGAMOUNT_COLUMN		= 4; 
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String wageId = request.getParameter("wageId")==null?"":request.getParameter("wageId");

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRAGINGS('" + 
 					companyID + "',0,0," + wageId + ",0,0,0,'','','AGLST',?,?)}"; 
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

 String baseLink = contextRoot + "/erp/payrollnic/wages/";
 					
 String link1 = baseLink + "agingupd.jsp?startIndex=" + startIndex + "&Id=";
 String link2 = baseLink + "pragings.jsp?startIndex=" + startIndex + "&action=AGDEL&Id=";
  
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(AGING_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="6">Tabla de Antiguedad</TD>
    </TR>
    <TR class="tableheader">
      <TD>Años</TD>
      <TD>Porcentaje</TD>
      <TD>Monto</TD>      
    </TR>
<%
 if (listDBBean.RowCountResult(AGING_CUR)==0) 
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
		String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(AGROWID_COLUMN,i,AGING_CUR)).toString() + "&wageId=" + wageId;	
		String link2s = link2 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(AGROWID_COLUMN,i,AGING_CUR)).toString() + "&wageId=" + wageId;	
		
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;	
		link = link + ConstantValue.PRE_TAG + link2s + ConstantValue.MIDDEL_TAG + "Eliminar" + ConstantValue.END_TAG;					
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD align="right" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 80, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=Format.formatQty((BigDecimal)listDBBean.valueAtColumnRowResult(AGYEARS_COLUMN,i,AGING_CUR))%></A></TD>    
      <TD align="right" nowrap><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(AGPERCENT_COLUMN,i,AGING_CUR))%></TD>
      <TD align="right" nowrap><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(AGAMOUNT_COLUMN,i,AGING_CUR))%></TD>          
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/wages/agingadd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="wageId" value="<%=wageId%>">		  
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD align="center" width="35%" height="30"> 
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/wages/wagelist.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00012")%>" class="button">
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