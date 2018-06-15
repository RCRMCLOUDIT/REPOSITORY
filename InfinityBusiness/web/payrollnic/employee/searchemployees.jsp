<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META http-equiv="Content-Style-Type" content="text/css">
<META http-equiv="Cache-Control" content="no-cache">
<META http-equiv="Expires" content="0">
<META http-equiv="Pragma" content="no-cache">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Busqueda de Puertos</TITLE>
<%
String v_id		= request.getParameter("v_id")==null?"":request.getParameter("v_id");
String v_name	= request.getParameter("v_name")==null?"":request.getParameter("v_name");

String v_sal	= request.getParameter("v_sal")==null?"":request.getParameter("v_sal");
 %>
<SCRIPT language="JavaScript">
<!--
 var openerDocument;
 var aname = new Array();

 if (parent.openerDocument) {
   openerDocument = parent.openerDocument;
 } else {
   openerDocument = opener.document;
 }

 function passBack(value_a, label_a, value_b) 
 {
	openerDocument.myForm.<%=v_id%>.value 		= value_a;
	openerDocument.myForm.<%=v_name%>.value		= unescape(label_a);
	
	<%
		if(!v_sal.trim().equals(""))
		{
	%>
		openerDocument.myForm.<%=v_sal%>.value		= value_b;
	<%
		}
	%>	
	close();
 }
//-->
</SCRIPT>
</HEAD> 
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<%! 
 static final String title = "Lista de Empleados";

 static final int EMPLOYEES_CUR 		= 1;

 static final int EMPEID_COLUMN		= 1;
 static final int EMPNUM_COLUMN		= 2;
 static final int EMPNM_COLUMN		= 3; 
 static final int EMPSALQ_COLUMN	= 4;  
%>

<% 
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 

 String search 		= request.getParameter("search") == null ? "" : request.getParameter("search");//Search By EmployeeNum
 String search1 	= request.getParameter("search1") == null ? "" : request.getParameter("search1");//Search By EmployeeName
 String filter 		= request.getParameter("filter") == null ? "0" : request.getParameter("filter");
 String payrollId	= request.getParameter("payrollId") == null ? "0" : request.getParameter("payrollId");
 
 if(!search1.trim().equals(""))
 	filter = "2";
 else if(!search.trim().equals(""))
 	filter = "1";	

 int pag = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRSRCHEMPS('" + 
 					companyID + "',0,'" + search + "','" + search1 +"','SEMPLS','"+ filter +"',0,?,?)}"; 
 System.out.println("sqlString = " + sqlString); 					
%>
 <BODY>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>

<jsp:useBean id="employeesDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="employeesDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="employeesDBBean" />
</jsp:useBean>
<%
int startIndex = (request.getParameter("startIndex")==null) ? 0 : Integer.parseInt(request.getParameter("startIndex").trim());
int i = 0;

 String empEid	= "";
 String empName	= "";
 String empNum	= "";
 String empSalQ	= "";

 employeesDBBean.execute(); 

 int numOfRows = employeesDBBean.getRowsInResult(EMPLOYEES_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="2">Lista de Empleados</TD>
    </TR>
    <TR class="tableheader">
      <TD width="20%">Numero de Empleado</TD>
      <TD width="80%">Nombre de Empleado</TD>      
    </TR>
<%
 if (employeesDBBean.RowCountResult(EMPLOYEES_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="4"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else if (employeesDBBean.RowCountResult(EMPLOYEES_CUR)==1) 
 {
 		empEid	= ((BigDecimal)(employeesDBBean.valueAtColumnRowResult(EMPEID_COLUMN,0,EMPLOYEES_CUR))).toString().trim();
		empName	= (String)(employeesDBBean.valueAtColumnRowResult(EMPNM_COLUMN,0,EMPLOYEES_CUR)).toString().trim();
		empNum	= (String)(employeesDBBean.valueAtColumnRowResult(EMPNUM_COLUMN,0,EMPLOYEES_CUR)).toString().trim();
		empSalQ = ((BigDecimal)(employeesDBBean.valueAtColumnRowResult(EMPSALQ_COLUMN,0,EMPLOYEES_CUR))).toString().trim(); 
%>
<SCRIPT language="JavaScript">
	passBack('<%=empEid%>','<%=empName%>','<%=empSalQ%>');
</SCRIPT>
<%
 }
 else
 {
   for (i = startIndex; i < startIndex + ConstantValue.PAGE_SIZE ; )
   { 
	try 
	{ 
		empEid	= ((BigDecimal)(employeesDBBean.valueAtColumnRowResult(EMPEID_COLUMN,i,EMPLOYEES_CUR))).toString().trim();
		empName	= (String)(employeesDBBean.valueAtColumnRowResult(EMPNM_COLUMN,i,EMPLOYEES_CUR)).toString().trim();
		empNum	= (String)(employeesDBBean.valueAtColumnRowResult(EMPNUM_COLUMN,i,EMPLOYEES_CUR)).toString().trim();
		empSalQ = ((BigDecimal)(employeesDBBean.valueAtColumnRowResult(EMPSALQ_COLUMN,i,EMPLOYEES_CUR))).toString().trim();		
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>" onmouseover="changeColorBox(this,1);" onmouseout="changeColorBox(this,0);" onclick="passBack('<%=empEid%>','<%=empName%>','<%=empSalQ%>')">
      <TD nowrap><%=empNum%></TD>      
      <TD nowrap><%=empName%></TD>
    </TR>
<%
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
 startIndex = i;
}
employeesDBBean.closeResultSet();
%>
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR>
    <TD class="label" width="30%" height="30"> Buscar Por Numero de Empleado
		<FORM name="searchByCode" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/searchemployees.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="hidden" name="filter" value="2">
		  <INPUT type="hidden" name="v_id" value="<%=v_id%>">
		  <INPUT type="hidden" name="v_name" value="<%=v_name%>">		  
		  <INPUT type="text"   name="search" value="<%=search%>" size="10" maxlength="20">		  
	  	  <INPUT type="submit" name="Go" value="<%=rb.getString("B00015")%>" class="button">		  
		</FORM>
	</TD>
    <TD class="label" width="30%" height="30"> Buscar Por Nombre de Empleado
		<FORM name="searchByName" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/searchemployees.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="hidden" name="filter" value="1">
		  <INPUT type="hidden" name="v_id" value="<%=v_id%>">
		  <INPUT type="hidden" name="v_name" value="<%=v_name%>">		  		  
		  <INPUT type="text"   name="search1" value="<%=search1%>" size="20" maxlength="50">		  
	  	  <INPUT type="submit" name="Go" value="<%=rb.getString("B00015")%>" class="button">		  		
	  	</FORM>
	</TD>		
  	<TD width="20%" align="right"> 
		<FORM name="myForm" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/searchemployees.jsp">  
			<INPUT type="hidden" name="filter" value="<%=filter%>">		
        	<INPUT type="hidden" name="search" value="<%=search%>">
        	<INPUT type="hidden" name="search1" value="<%=search1%>">        
		  	<INPUT type="hidden" name="v_id" value="<%=v_id%>">
		  	<INPUT type="hidden" name="v_name" value="<%=v_name%>">		          	        
			<INPUT TYPE="hidden" NAME="startIndex" VALUE="0">		
<% 
  if (startIndex > ConstantValue.PAGE_SIZE) 
  {
	int prevpage = 0;
	if ((i % ConstantValue.PAGE_SIZE) == 0) 
	{
		prevpage = (  ( (i/ConstantValue.PAGE_SIZE)*ConstantValue.PAGE_SIZE )-(ConstantValue.PAGE_SIZE*2)  );
	}
	else 
	{
		prevpage = (  ( (i/ConstantValue.PAGE_SIZE+1)*ConstantValue.PAGE_SIZE )-(ConstantValue.PAGE_SIZE*2)  );
	}
%>
    	<INPUT type="submit" name="Previous" value="<%=rb.getString("B00005")%>" class="button" onclick="myForm.startIndex.value='<%=prevpage%>';">
<%} %>
      </TD>
      <TD width="20%" align="left"> 
<%
   if (i != numOfRows) { %>
	  	<INPUT type="submit" name="Next" value="<%=rb.getString("B00006")%>" class="button" onclick="myForm.startIndex.value='<%=startIndex%>';">
<% }	%>
		</FORM> 
	</TD>  
    </TR>
  </TABLE>
</HTML>