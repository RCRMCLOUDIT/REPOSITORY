<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<%@ page import="com.cap.util.*,java.net.InetAddress,java.net.URL,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<TITLE>Reporte de Ingresos/Deducciones</TITLE>
</HEAD>
<%! 
 static final String title = "Reporte de Ingresos/Deducciones";  
 
 static final int EMPLTYP_CUR 	= 1; //EMPLOYEE TYPES CURSOR
 static final int CONCEPTS_CUR  = 2; //CONCEPTS CURSOR
%>
<BODY onload="myForm.fDate.focus();">
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="Javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/reports.js"></SCRIPT>
<%
 String fDate	= request.getParameter("fDate")==null?Format.getSysDate():request.getParameter("fDate");
 String tDate	= request.getParameter("tDate")==null?Format.getSysDate():request.getParameter("tDate");
 String reportType	= request.getParameter("reportType")==null?"SCR":request.getParameter("reportType");
 String employeeTypeId 	= request.getParameter("employeeTypeId")==null?"0":request.getParameter("employeeTypeId"); 
 String conceptId	= request.getParameter("conceptId")==null?"":request.getParameter("conceptId"); 
 
 String contextRoot = request.getContextPath(); 
 
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "',0,0,'','','','',0,0,0,0,'',0,'" + 
 					Format.strDatetoSQLDate(fDate) + "','" +
 					Format.strDatetoSQLDate(tDate) + "',0,0,'',0,0,0,'','','','','',0,0,'','','OIDRPTENT','','','','','','','',0,'',?,?)}";
 
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="entryDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="entryDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="entryDBBean" />
</jsp:useBean>
<%
 entryDBBean.execute(); 

 int numOfRows 	= entryDBBean.getRowsInResult(EMPLTYP_CUR);
%>
<FORM name="myForm" method="post" action="<%=request.getContextPath()%>/erp/payrollnic/reports/oidlistall.jsp" onsubmit='return oid_lookup(myForm);'>
<INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">

<TABLE width="600" border="0" class="Border" cellpadding="0" cellspacing="1">
    <TR class="pcrinfo">
		<TD class="label" nowrap><span class="textRed">*</span><%=rb.getString("P12540003")%></TD>
		<TD><INPUT type="text" name="fDate" value="<%=fDate%>" size="10" maxlength="10" onkeyup="addSlash(myForm.fDate)" onchange="formatDate(myForm.fDate)" onkeypress="OnlyDigits();addSlash(myForm.fDate)" onkeydown="return checkArrows(this, event)"><IMG id="cal" border="0" onclick="popUpCalendar(this, myForm.fDate, 'mm/dd/yyyy', -1, -1);" alt="Calendar" src="../../ERP_COMMON/images/popcalendar/calendar.gif"></TD>
    </TR>
    <TR class="pcrinfo1">
      	<TD class="label" nowrap><span class="textRed">*</span><%=rb.getString("P12540004")%></TD>
		<TD><INPUT type="text" name="tDate" value="<%=tDate%>" size="10" maxlength="10" onkeyup="addSlash(myForm.tDate)" onchange="formatDate(myForm.tDate)" onkeypress="OnlyDigits();addSlash(myForm.tDate)" onkeydown="return checkArrows(this, event)"><IMG id="cal" border="0" onclick="popUpCalendar(this, myForm.tDate, 'mm/dd/yyyy', -1, -1);" alt="Calendar" src="../../ERP_COMMON/images/popcalendar/calendar.gif"></TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Tipo de Empleado</TD>
      <TD>
	            <SELECT size="1" name="employeeTypeId" class="text">
	            <OPTION value="" <%=employeeTypeId.length()==0?"selected": ""%>></OPTION>
<%
		int numOfEmplyTyp = entryDBBean.getRowsInResult(EMPLTYP_CUR);
		String code  = "";
		String descr = "";
		
   		for (int j = 0; j < numOfEmplyTyp; j++) { 
 			code 	= ((BigDecimal)entryDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,EMPLTYP_CUR)).toString();
			descr	= (String)entryDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,EMPLTYP_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=employeeTypeId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
      
      </TD>
    </TR>
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Concepto</TD>
      <TD>
	            <SELECT size="1" name="conceptId" class="text">
	            <OPTION value="0" <%=conceptId.length()==0?"selected": ""%>>Todos los Ingresos/Deducciones</OPTION>
<%
		int numOfConcepts = entryDBBean.getRowsInResult(CONCEPTS_CUR);
		
   		for (int j = 0; j < numOfConcepts; j++) { 
 			code 	= ((BigDecimal)entryDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,CONCEPTS_CUR)).toString();
			descr	= (String)entryDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,CONCEPTS_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=conceptId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
      
      </TD>	
    </TR>      
   	<TR class="pcrinfo">
		<TD class="label" nowrap><span class="textRed">*</span>Tipo de Reporte</TD>
		<TD class="label">    
	   		<input type="radio" name="reportType" value="SCR" <%=reportType.equals("SCR")?"checked":""%>>Pantalla 
	   		<input type="radio" name="reportType" value="PDF" <%=reportType.equals("PDF")?"checked":""%>>PDF 
			<input type="radio" name="reportType" value="XLS" <%=reportType.equals("XLS")?"checked":""%>>XLS 
			<input type="radio" name="reportType" value="CHR" <%=reportType.equals("CHR")?"checked":""%>>Grafico 	   		
	   </TD>
	</TR>  
  </TABLE>
<%
  entryDBBean.closeResultSet();
%>		
  
 <TABLE width="600" border="0" cellpadding="0" cellspacing="1">
    <TR>
      <TD align="center">
      	<INPUT name="submit" type="submit" class="button" value="<%=rb.getString("B00013")%> >>">&nbsp;&nbsp;&nbsp;&nbsp; 
       	<INPUT name="Reset" type="reset" class="button" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
		<INPUT type="button" name="exit" value="<%=rb.getString("B00029")%>" class="button" onclick="window.close();">
    </TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
