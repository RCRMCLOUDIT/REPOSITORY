<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Retenciones de Ley Aplicables</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Retenciones de Ley Aplicables";

 static final int APTAXES_CUR = 1;

 static final int TXTAXID_COLUMN		= 1; 
 static final int TXNAME_COLUMN			= 2; 
 static final int TXCHKYN_COLUMN		= 3; 
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath();

 String Id 			= request.getParameter("Id")==null?"":request.getParameter("Id");
 String wageName 	= request.getParameter("wageName")==null?"":request.getParameter("wageName");

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRAPLTAXES('" + 
 					companyID + "',0," + Id +",'','','','','APTAXLST',?,?)}"; 
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(APTAXES_CUR);
%>
<FORM name="myForm" method="post" action="<%=contextRoot%>/erp/payrollnic/wages/prapltaxes.jsp">
<INPUT type="hidden" name="Id" value="<%=Id%>">
<INPUT type="hidden" name="wageName" value="<%=wageName%>">
<INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
<INPUT type="hidden" name="userLang" value="<%=userLang%>">

<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="2">Retenciones de Ley Aplicables</TD>
    </TR>
    <TR class="tableheader">
    	<TD colspan="2"><%=wageName%></TD>
    </TR>    
    <TR class="tableheader">
      <TD>Seleccionar</TD>
      <TD>Nombre</TD>          
    </TR>
<%
String taxId	= "";
String taxName 	= "";
String checkYN 	= "";

int checkCount	= 0;
int i			= 0;

 if (listDBBean.RowCountResult(APTAXES_CUR)==0) 
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
	taxId	= ((BigDecimal)listDBBean.valueAtColumnRowResult(TXTAXID_COLUMN,i,APTAXES_CUR)).toString().trim();
	taxName = ((String)listDBBean.valueAtColumnRowResult(TXNAME_COLUMN,i,APTAXES_CUR)).toString().trim();
	checkYN = ((String)listDBBean.valueAtColumnRowResult(TXCHKYN_COLUMN,i,APTAXES_CUR)).toString().trim(); 
	
	if(checkYN.equals("UNCHECKED"))
		checkCount++;	
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
     	<TD width="25%">
   	 		<INPUT type="hidden" name="seleccionado<%=i%>" value="<%=!"UNCHECKED".equals(checkYN)?"true":"" %>">
       		<INPUT type="checkbox" name="checkbox<%=i%>" <%=!"UNCHECKED".equals(checkYN)?"CHECKED":"" %> onclick="javascript:this.checked==true?myForm.seleccionado<%=i%>.value=true:myForm.seleccionado<%=i%>.value=false" >
			<INPUT type="hidden" name="apTaxid<%=i%>" value="<%=taxId%>"  >  
		</TD>         
		<TD width="75%"><%=taxName%></TD>		
    </TR>
<%
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
}
listDBBean.closeResultSet();
String firstTime = "N";

if(i == checkCount)
  firstTime =  "Y";
%>
<input type="hidden" name="count" value="<%=i%>"> 
<input type="hidden" name="firstTime" value="<%=firstTime%>"> 
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR>
    	<TD width="30%" height="30">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00008")%>" class="button">
		</TD>
    	<TD align="center" width="35%" height="30">
	   		<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/wages/wagelist.jsp';">   
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