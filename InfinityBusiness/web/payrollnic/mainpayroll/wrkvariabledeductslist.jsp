<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Trabajar con Deducciones Variables</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Trabajar con Deducciones Variables";

 static final int DEDUCTS_CUR = 1;

 static final int TLCONCID_COLUMN	= 1; 
 static final int TLNAME_COLUMN		= 2; 
 static final int TLAMOUNT_COLUMN	= 3; 
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String payrollId = request.getParameter("payrollId")==null?"":request.getParameter("payrollId");
 String concepType= request.getParameter("concepType")==null?"D":request.getParameter("concepType");
 String fixOrVar  = request.getParameter("fixOrVar")==null?"V":request.getParameter("fixOrVar");

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRWRKCNPTS('" + 
 					companyID + "'," + companyEID + "," + payrollId + ",0,'',0,'',0,'" + concepType + "','" + fixOrVar +"','','',0,0,0,0,'','WRKCNCLS','','',?,?)}"; 
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
 					
 String link1 = baseLink + "wrkvariablededucts.jsp?startIndex=" + startIndex + "&conceptId=";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(DEDUCTS_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="2">Trabajar con Deducciones Variables</TD>
    </TR>
    <TR class="tableheader">
      <TD>Nombre</TD>
      <TD>Monto</TD>      
    </TR>
<%

 if (listDBBean.RowCountResult(DEDUCTS_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="2"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
		String link1s = link1 + ((BigDecimal)listDBBean.valueAtColumnRowResult(TLCONCID_COLUMN,i,DEDUCTS_CUR)).toString() + "&action=WRKCNCEDT&payrollId=" + payrollId + "&concepType=" + concepType + "&fixOrVar=" + fixOrVar;	

		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;	
				
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD align="left" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 80, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,6000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)listDBBean.valueAtColumnRowResult(TLNAME_COLUMN,i,DEDUCTS_CUR)%></A></TD>    
      <TD align="right" nowrap><%=Format.displayCurrency((BigDecimal)listDBBean.valueAtColumnRowResult(TLAMOUNT_COLUMN,i,DEDUCTS_CUR))%></TD>
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/mainpayroll/wrkvariabledeductspre.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="payrollId" value="<%=payrollId%>">
		  <INPUT type="hidden" name="concepType" value="<%=concepType%>">		  
  		  <INPUT type="hidden" name="fixOrVar" value="<%=fixOrVar%>">		  
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD align="center" width="35%" height="30">
    <INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/mainpayroll/mainpayrolllist.jsp';">   
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>