<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Editar Objetivo</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.customerName.focus()">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<%! 
 static final String title = "Editar Objetivo"; 
 

 static final int OBJECT_CUR = 1; 
      
 static final int COOBJID_COLUMN	= 1; //OBJ ID
 static final int COCUSTEID_COLUMN	= 2; //CUST EID
 static final int CUSTNAME_COLUMN	= 3; //CUSTOMER NAME
 static final int COOBJNAME_COLUMN	= 4; //OBJECT NAME
 static final int COOBJADDR_COLUMN	= 5; //ADDRESS
 static final int COOBJSUPR_COLUMN	= 6; //SUPERVISOR EID
 static final int SUPNAME_COLUMN	= 7; //SUPERVISOR
 static final int COHOURS_COLUMN	= 8; //HOURS
 static final int COPOST_COLUMN		= 9; //POST 
 static final int COOBJCODE_COLUMN	= 10; //OBJECT CODE
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 *******************************************************************************/
 String objectId 		= request.getParameter("objectId")==null?"0":request.getParameter("objectId");
 String proyId	 		= request.getParameter("proyId")==null?"0":request.getParameter("proyId");

 String customerId 		= request.getParameter("customerId")==null?"0":request.getParameter("customerId");
 String customerName 	= request.getParameter("customerName")==null?"":request.getParameter("customerName");

 String empId 		= request.getParameter("empId")==null?"0":request.getParameter("empId");
 String empName 	= request.getParameter("empName")==null?"":request.getParameter("empName");
  
 String objName 	= request.getParameter("objName")==null?"":request.getParameter("objName");
 String objAddress 	= request.getParameter("objAddress")==null?"":request.getParameter("objAddress");
 String objCode 	= request.getParameter("objCode")==null?"":request.getParameter("objCode");
 
 String hours 		= request.getParameter("hours")==null?"0":request.getParameter("hours");
 String post 		= request.getParameter("post")==null?"0":request.getParameter("post");
 
 String contextRoot = request.getContextPath();

 String errMsg 	= null;
 String code 	= "";	
 String descr 	= ""; 

 /*******************************************************************************
 * In case we are comming from the command page due some error, the addCommandDBBean
 * object already exists from that page. It must be create in request scope
 *******************************************************************************/
 if (returnWithError.equals("Y"))
 {
       errMsg = (String)request.getAttribute("ErrorMessage");
 }
 
  /*******************************************************************************
 * build the sqlString with the call to the SP
 *******************************************************************************/
  String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCLOBJS('" + 
 					companyID + "',0,0," + objectId + ",0,0,0,'','','','','OBJECTEDT','',?,?)}"; 
 System.out.println("sqlString = " + sqlString); 					

%>
<jsp:useBean id="updateDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="updateDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="updateDBBean" />
</jsp:useBean>
<%
 updateDBBean.execute();
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<%
 if (returnWithError.equals("N"))
 { 
	 try
	 {
		customerId 		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(COCUSTEID_COLUMN,0,OBJECT_CUR)).toString().trim(); 
		customerName 	= (String)updateDBBean.valueAtColumnRowResult(CUSTNAME_COLUMN,0,OBJECT_CUR).toString().trim(); 

		empId 			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(COOBJSUPR_COLUMN,0,OBJECT_CUR)).toString().trim();
		empName  		= (String)updateDBBean.valueAtColumnRowResult(SUPNAME_COLUMN,0,OBJECT_CUR).toString().trim();

		objName  		= (String)updateDBBean.valueAtColumnRowResult(COOBJNAME_COLUMN,0,OBJECT_CUR).toString().trim();
		objAddress 		= (String)updateDBBean.valueAtColumnRowResult(COOBJADDR_COLUMN,0,OBJECT_CUR).toString().trim();
		
		hours 			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(COHOURS_COLUMN,0,OBJECT_CUR)).toString().trim(); 
		post 			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(COPOST_COLUMN,0,OBJECT_CUR)).toString().trim(); 
		
		objCode			= (String)updateDBBean.valueAtColumnRowResult(COOBJCODE_COLUMN,0,OBJECT_CUR).toString().trim();
	
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 }
%>
<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/confobjects/prclobjs.jsp">
<INPUT type="hidden" name="action" id="action" value="OBJECTUPD">
<INPUT type="hidden" name="objectId" id="objectId" value="<%=objectId%>">	
<INPUT type="hidden" name="returnEid" id="returnEid" value="Y"> 
<INPUT type="hidden" name="proyId" id="proyId" value="<%=proyId%>">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">

<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="2" class="tableheader">Editar Objetivo</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN><%=rb.getString("B00132")%></TD>
      <TD width="75%">
        <INPUT type="hidden" name="customerId" id="customerId" value="<%=customerId%>">
      	<INPUT size="40" type="text" maxlength="40" name="customerName" id="customerName" value="<%= customerName %>" onchange='document.myForm.customerId.value="";' onkeypress='if(isEnterPressed() && myForm.searchCustomer.disabled==false) openEntDialog("CUS", "A", "myForm", "customerId", "customerName", "<%= contextRoot %>");'> 
        <INPUT type="button" name="searchCustomer" value=" v " onclick='openEntDialog("CUS", "A", "myForm", "customerId", "customerName", "<%= contextRoot %>");'>
      </TD>
    </TR>
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Nombre de Objetivo</TD>
      <TD width="70%"><input type="text" name="objName" size="50" maxlength="100" value="<%=objName%>"></TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Codigo de Objetivo</TD>
      <TD width="70%"><input type="text" name="objCode" size="10" maxlength="10" value="<%=objCode%>"></TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Direccion de Objetivo</TD>
      <TD width="70%"><input type="text" name="objAddress" size="50" maxlength="100" value="<%=objAddress%>"></TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Fondo Horario</TD>
      <TD width="70%"><input type="text" name="hours" size="10" maxlength="15" value="<%=hours%>"></TD>
    </TR>     
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Puestos</TD>
      <TD width="70%"><input type="text" name="post" size="10" maxlength="15" value="<%=post%>"></TD>
    </TR>     
         
    <TR class="pcrinfo">
      <TD width="50%" class="label"><span class="textRed">*</span>Supervisor</TD>
      <TD width="50%">
        <INPUT type="hidden" name="empId" id="empId" value="<%=empId%>">
      	<INPUT size="40" type="text" maxlength="40" name="empName" id="empName" value="<%= empName %>" onchange='document.myForm.empId.value="";' onkeypress='if(isEnterPressed()) openEntDialog("EMP", "A", "myForm", "empId", "empName", "<%= contextRoot %>");'> 
        <INPUT type="button" name="searchEmp" value=" v " onclick='openEntDialog("EMP", "A", "myForm", "empId", "empName", "<%= contextRoot %>");'>
      </TD>
    </TR>
</TABLE>
<TABLE width="600">
	<TR>
		<TD height="30" align="center">
			<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
			<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
			<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/confobjects/objectslist.jsp?proyId=<%=proyId%>';">
		</TD>
	</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
