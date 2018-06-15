<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String deductionId		= request.getParameter("deductionId")==null?"":request.getParameter("deductionId");
 String loanId			= request.getParameter("loanId")==null?"":request.getParameter("loanId");
 
 String employeeId 		= request.getParameter("employeeId")==null?"0":request.getParameter("employeeId");
 String employeeName    = request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String fDate		 	= request.getParameter("fDate")==null?Format.getSysDate():request.getParameter("fDate");
 String tDate		 	= request.getParameter("tDate")==null?Format.getSysDate():request.getParameter("tDate");
 String loanAmt     	= request.getParameter("loanAmt")==null?"0.00":request.getParameter("loanAmt");
 String loanDues 		= request.getParameter("loanDues")==null?"0":request.getParameter("loanDues");
 
 String status		 	= request.getParameter("status")==null?"":request.getParameter("status"); 
 
 String action		 	= request.getParameter("action")==null?"LOANLST":request.getParameter("action"); 
 String dedName		 	= request.getParameter("dedName")==null?"":request.getParameter("dedName");
 
 String payrollId		= request.getParameter("payrollId")==null?"0":request.getParameter("payrollId");
 String fpayDate		= request.getParameter("fpayDate")==null?Format.getSysDate():request.getParameter("fpayDate");
 String payAmt     	= request.getParameter("payAmt")==null?"0.00":request.getParameter("payAmt");
 String numDue	 	= request.getParameter("numDue")==null?"0":request.getParameter("numDue");
 
 String contextRoot = request.getParameter("contextRoot");
 
 String rowId		= request.getParameter("rowId")==null?"0":request.getParameter("rowId");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRLOANS('" + 
 					companyID + "'," +
 					companyEID + "," +
 					(loanId.equals("")?"0":loanId) + "," +
 					(deductionId.equals("")?"0":deductionId) + ",'" +
 					employeeId + "','" +
 					Format.strDatetoSQLDate(fDate) + "','" +
 					Format.strDatetoSQLDate(tDate) + "',"  + 			
 					loanAmt +"," +
 					loanDues + ",'" + 
 					status + "','" +
 					action + "','"+
 					who +"','" +
 					ip +"',"+
 					(action.equals("LOANDTD")?rowId:payrollId) +",'" +
 					Format.strDatetoSQLDate(fpayDate) + "',"+
 					payAmt +","+
 					numDue +",?,?)}";
 					
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prloansDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prloansDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prloansDBBean" />
</jsp:useBean>
<%
 prloansDBBean.closeResultSet();
 prloansDBBean.execute();
 prloansDBBean.closeResultSet();
 
 String flag   = prloansDBBean.getErrorFlag();
 String errMsg = prloansDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S") && !action.equals("LOANDTA") && !action.equals("LOANDTD")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/deductions/dedlistBAL.jsp?Id=" + deductionId + "&dedName=" + dedName);
 }
 else if(flag.equals("S") && (action.equals("LOANDTA") || action.equals("LOANDTD"))){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/deductions/dedlistDET.jsp?deductionId=" + deductionId + "&loanId=" +loanId+ "&dedName=" + dedName);
 } 
 else if(flag.equals("F") && action.equals("LOANADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="dedaddBAL.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("LOANUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="dedupdBAL.jsp"/>
 <%
 }
 else if(flag.equals("F") && action.equals("LOANDTA"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="dedaddDET.jsp"/>
 <%
 }
 %>