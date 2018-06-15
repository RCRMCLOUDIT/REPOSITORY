<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Trabajar con Deducciones Variables</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.conceptId.focus()">
<%! 
 static final String title = "Trabajar con Deducciones Variables"; 
 
 static final int CONCEPTS_CUR = 1;
%>

<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/mainpayroll.js"></SCRIPT>

<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 ********************************************************************************/
  
 String payrollId = request.getParameter("payrollId")==null?"":request.getParameter("payrollId");
 String concepType= request.getParameter("concepType")==null?"D":request.getParameter("concepType");
 String fixOrVar  = request.getParameter("fixOrVar")==null?"V":request.getParameter("fixOrVar");

 String conceptId	= request.getParameter("conceptId")==null?"":request.getParameter("conceptId"); 
  
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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRWRKCNPTS('" + 
 					companyID + "'," + companyEID + "," + payrollId + ",0,'',0,'',0,'" + concepType + "','" + fixOrVar +"','','',0,0,0,0,'','WRKCNCPR','','',?,?)}"; 
 					 
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="addDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="addDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="addDBBean" />
</jsp:useBean>
<%
 addDBBean.execute(); 
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />

<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/mainpayroll/wrkvariablededucts.jsp">
<INPUT type="hidden" name="action" id="action" value="WRKCNCNEW">
<INPUT type="hidden" name="payrollId" id="payrollId" value="<%=payrollId%>">
<INPUT type="hidden" name="concepType" id="concepType" value="<%=concepType%>">
<INPUT type="hidden" name="fixOrVar" id="fixOrVar" value="<%=fixOrVar%>">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">
<TABLE width="600" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="2" class="tableheader">Trabajar con Deducciones Variables</TD>
    </TR>     
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Deduccion Variable</TD>
      <TD>
	            <SELECT size="1" name="conceptId" class="text">
	            <OPTION value="" <%=conceptId.length()==0?"selected": ""%>></OPTION>
<%
		int numOfConcepts = addDBBean.getRowsInResult(CONCEPTS_CUR);
		
   		for (int j = 0; j < numOfConcepts; j++) { 
 			code 	= ((BigDecimal)addDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,CONCEPTS_CUR)).toString();
			descr	= (String)addDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,CONCEPTS_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=conceptId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
      
      </TD>	
    </TR>      
<%
  addDBBean.closeResultSet();
%>		
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00013")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/mainpayroll/wrkvariabledeductslist.jsp?payrollId=<%=payrollId%>';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
