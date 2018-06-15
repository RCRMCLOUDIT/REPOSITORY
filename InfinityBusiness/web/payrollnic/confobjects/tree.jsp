<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Lista de Objetivos</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 

 static final int OBJECT_CUR = 1;

 static final int COOBJID_COLUMN		= 1; //OBJECT ID COLUMN
 static final int COCUSTEID_COLUMN		= 2; //CUSTOMER EID
 static final int CUSTNAME_COLUMN		= 3; //CUSTOMER NAME
 static final int COOBJNAME_COLUMN		= 4; //OBJECT NAME
 static final int COOBJADDR_COLUMN		= 5; //OBJECT ADDRRESS 
 static final int COSUPVR_COLUMN		= 6; //SUPERVISOR 
 static final int COHOURS_COLUMN		= 7; //HOURS
 static final int COPOST_COLUMN			= 8; //POSITIONS  
 static final int COOBJCODE_COLUMN		= 9; //OBJECT CODE 
%>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/searchemployees.js"></SCRIPT>
<%
 String contextRoot = request.getContextPath(); 
 
 String custEid = request.getParameter("custEid")==null?"0":request.getParameter("custEid");
 String proyId  = request.getParameter("proyId")==null?"0":request.getParameter("proyId");

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCLOBJS('" + 
 					companyID + "',0," + custEid + ",0,0,0,0,'','','','','OBJECTLST','',?,?)}"; 
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

 String baseLink = contextRoot + "/erp/payrollnic/confobjects/";
 					
 String link2 = baseLink + "programdetail.jsp?startIndex=" + startIndex + "&objectId=";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(OBJECT_CUR);
 
 String employeeMastId 		= request.getParameter("employeeMastId")==null?"":request.getParameter("employeeMastId");
 String	emplMastSalQ		= request.getParameter("emplMastSalQ")==null?"":request.getParameter("emplMastSalQ");
 String	employeeMastName	= request.getParameter("employeeMastName")==null?"":request.getParameter("employeeMastName");  
%>
<FORM name = "myForm" method="post" target="list" action="<%=contextRoot%>/erp/payrollnic/confobjects/programdetailempl.jsp">
<INPUT type="hidden" name="returnEid" id="returnEid" value="Y">
<INPUT type="hidden" name="proyId" id="proyId" value="<%=proyId%>">

<TABLE cellpadding="0" cellspacing="1" class="Border" border="0">
     <TR class="tableheader">
      <TD colspan="2">
        GRABAR X EMPLEADO
      </TD> 
     <TR class="tableheader">
      <TD colspan="2">
      	<INPUT type="hidden" name="emplMastSalQ" value="<%=emplMastSalQ%>">    
		<INPUT type="hidden" name="employeeMastId" id="employeeMastId" value="<%=employeeMastId%>">
 		<INPUT size="20" name="employeeMastName" type="text" class="text" maxlength="50" value="<%=employeeMastName%>" id="employeeMastName"  onchange="this.form.employeeMastId.value='';" onkeypress='if(isEnterPressed()) openSEmployeesDialog("myForm", "employeeMastId", "employeeMastName", "", "<%= request.getContextPath()%>","emplMastSalQ");'>
		<INPUT type="button" name="searchEmp" value=" v " onclick='openSEmployeesDialog("myForm", "employeeMastId", "employeeMastName", "" , "<%= request.getContextPath()%>","emplMastSalQ");'>
		<INPUT type="submit" name="addnew" value="IR" class="button">		            
      </TD> 
    </TR>
    <TR class="tableheader">
    	<TD colspan="2">GRABAR X OBJETIVO</TD>
    </TR>
<%
String customerName    = "";
String preCustomerName = "";
 if (listDBBean.RowCountResult(OBJECT_CUR)==0) 
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
		String link2s = link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(COOBJID_COLUMN,i,OBJECT_CUR)).toString() + "&custEid=" + ((BigDecimal)listDBBean.valueAtColumnRowResult(COCUSTEID_COLUMN,i,OBJECT_CUR)).toString() + "&proyId=" + proyId + "&custName=" + (String)(listDBBean.valueAtColumnRowResult(CUSTNAME_COLUMN,i,OBJECT_CUR)) + "&objName=" + (String)(listDBBean.valueAtColumnRowResult(COOBJNAME_COLUMN,i,OBJECT_CUR));
		
		customerName = (String)(listDBBean.valueAtColumnRowResult(CUSTNAME_COLUMN,i,OBJECT_CUR));
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      	<%
      		if(!customerName.equals(preCustomerName) || i==0) 
      		{	
      	%>
      		<TD nowrap><%=customerName%></TD>
	 	<%
	 		}
	 		else
	 		{
	 	%>
	 		<TD nowrap></TD>
	 	<%
	 		}
	 	%>
	 	</TR>
	 	<TR>
	 		<TD>&nbsp;&nbsp;&nbsp;<a href="<%=link2s%>" target="list"><%=(String)(listDBBean.valueAtColumnRowResult(COOBJCODE_COLUMN,i,OBJECT_CUR)) + "-" + (String)(listDBBean.valueAtColumnRowResult(COOBJNAME_COLUMN,i,OBJECT_CUR))%></a></TD>  
		</TR>
<%
		preCustomerName = customerName;
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
 startIndex = i;
}
listDBBean.closeResultSet();
%>
</TABLE>
</FORM>
</HTML>