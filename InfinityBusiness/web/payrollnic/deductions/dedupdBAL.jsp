<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Actualizar Deduccion</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.employeeName.focus()">	
<%! 
 static final String title = "Actualizar Prestamo/Deduccion"; 
 
 static final int LOAN_CUR  = 1; 

 static final int LNLOANID_COLUMN 		= 1;
 static final int LNCONCID_COLUMN 		= 2;
 static final int LNEMPLID_COLUMN 		= 3; 
 static final int LNEMPLNM_COLUMN 		= 4;
 static final int LNLOANFDATE_COLUMN	= 6;
 static final int LNLOANTDATE_COLUMN 	= 7;            
 static final int LNLOANAMT_COLUMN 		= 8;
 static final int LNLOANTIM_COLUMN 		= 9;         
 static final int LNLOANRATE_COLUMN	 	= 10;
%>

<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_charcounterJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/charcounter.js"></SCRIPT>

<SCRIPT language="JavaScript" src="../js/mainpayroll.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/searchemployees.js"></SCRIPT>

<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 ********************************************************************************/
 String loanId 			= request.getParameter("loanId")==null?"0":request.getParameter("loanId");
 String employeeId 		= request.getParameter("employeeId")==null?"0":request.getParameter("employeeId");
 String employeeName    = request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String deductionId		= request.getParameter("deductionId")==null?"0":request.getParameter("deductionId");
 String fDate		 	= request.getParameter("fDate")==null?Format.getSysDate():request.getParameter("fDate");
 String tDate		 	= request.getParameter("tDate")==null?Format.getSysDate():request.getParameter("tDate");
 String dedName		    = request.getParameter("dedName")==null?"":request.getParameter("dedName");

 String loanAmt     = request.getParameter("loanAmt")==null?"0.00":request.getParameter("loanAmt");
 String loanDues = request.getParameter("loanDues")==null?"0":request.getParameter("loanDues");
     
 String contextRoot = request.getParameter("contextRoot");

 String errMsg 	= null;

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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRLOANS('" + 
 					companyID + "',0," + loanId + ","+ deductionId +",0,'','',0,0,'','LOANEDT','" + user_ID + "','" + Format.getIPAddress(request).trim() + "',0,'',0,0,?,?)}"; 
 					 
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="updDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="updDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="updDBBean" />
</jsp:useBean>
<%
 updDBBean.execute(); 
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
	 
  
// static final int LNLOANRATE_COLUMN	 	= 9;
 	 
		employeeId 		= ((BigDecimal)updDBBean.valueAtColumnRowResult(LNEMPLID_COLUMN,0,LOAN_CUR)).toString().trim();
		employeeName 	= (String)updDBBean.valueAtColumnRowResult(LNEMPLNM_COLUMN,0,LOAN_CUR).toString().trim();
		
		fDate   		= Format.date_Str(updDBBean.valueAtColumnRowResult(LNLOANFDATE_COLUMN,0,LOAN_CUR).toString());
		tDate   		= Format.date_Str(updDBBean.valueAtColumnRowResult(LNLOANTDATE_COLUMN,0,LOAN_CUR).toString());
		
		loanAmt			= ((BigDecimal)updDBBean.valueAtColumnRowResult(LNLOANAMT_COLUMN,0,LOAN_CUR)).toString().trim();
		loanDues		= ((BigDecimal)updDBBean.valueAtColumnRowResult(LNLOANTIM_COLUMN,0,LOAN_CUR)).toString().trim();

	 }catch (java.lang.ArrayIndexOutOfBoundsException e){  }
}		 
%>
<FORM method="post" name="myForm" action="<%=request.getContextPath()%>/erp/payrollnic/deductions/prloans.jsp">
<INPUT type="hidden" name="action" id="action" value="LOANUPD">
<INPUT type="hidden" name="loanId" id="loanId" value="<%=loanId%>">
<INPUT type="hidden" name="dedName" id="dedName" value="<%=dedName%>">
<INPUT type="hidden" name="deductionId" id="deductionId" value="<%=deductionId%>">
<INPUT type="hidden" name="returnEid" value="Y">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="4" class="tableheader">Actualizar Prestamo</TD>
    </TR>   
    <TR>
      <TD colspan="4" class="tableheader"><%=dedName%></TD>
    </TR>     
    <TR class="pcrinfo">
          <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Empleado</TD>
      <TD>
      	<INPUT type="hidden" name="emplSalQ" value="">    
		<INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
 		<INPUT size="30" name="employeeName" type="text" class="text"	maxlength="50" value="<%=employeeName%>" id="employeeName"  onchange="this.form.employeeId.value='';" onkeypress='if(isEnterPressed()) openSEmployeesDialog("myForm", "employeeId", "employeeName", "", "<%= request.getContextPath()%>","emplSalQ");' autocomplete="off" class="search search-icon">
		<INPUT type="button" class="button" name="searchEmp" value=" v " onclick='openSEmployeesDialog("myForm", "employeeId", "employeeName", "" , "<%= request.getContextPath()%>","emplSalQ");'>            
      </TD> 
    </TR>    
   <TR class="pcrinfo1"> 
   	  <TD class="label">Fecha de Prestamo</TD>	
      <TD>
       <INPUT size="12" maxlength="10" type="text" name="fDate" class="pcrInfo" value="<%=fDate%>" onKeyUp="addSlash(myForm.fDate)" onChange="formatDate(myForm.fDate)" onKeyPress="OnlyDigits();addSlash(myForm.fDate)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.fDate, 'mm/dd/yyyy', 350, -1);" alt="Calendar">            
      </TD>
   </TR>
   <TR class="pcrinfo"> 
   	  <TD class="label">Fecha de Finalizacion</TD>	
      <TD>
       <INPUT size="12" maxlength="10" type="text" name="tDate" class="pcrInfo" value="<%=tDate%>" onKeyUp="addSlash(myForm.tDate)" onChange="formatDate(myForm.tDate)" onKeyPress="OnlyDigits();addSlash(myForm.tDate)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.tDate, 'mm/dd/yyyy', 350, -1);" alt="Calendar">            
      </TD>
   </TR>   
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Monto de Prestamo</TD>
      <TD width="75%">
      	<input type="text" name="loanAmt" value="<%=loanAmt%>" size="21" maxlength="10">
      </TD>			
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Cuotas</TD>
      <TD><input type="text" name="loanDues" size="2" maxlength="4" value="<%=loanDues%>"></TD>			
    </TR>        	        
<%
  updDBBean.closeResultSet();
%>		
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=request.getContextPath()%>/erp/payrollnic/deductions/dedlistBAL.jsp?Id=<%=deductionId%>&dedName=<%=dedName%>';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
