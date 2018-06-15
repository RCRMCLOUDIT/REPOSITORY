<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String employeeId		= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String employeeNum		= request.getParameter("employeeNum")==null?"":request.getParameter("employeeNum");
 String liquidationId 	= request.getParameter("liquidationId")==null?"0":request.getParameter("liquidationId"); 
 String intDate			= request.getParameter("intDate")==null?"":request.getParameter("intDate");
 String endDate			= request.getParameter("endDate")==null?"":request.getParameter("endDate"); 
 
 String reazonId 		= request.getParameter("reazonId")==null?"":request.getParameter("reazonId"); 
 String action		 	= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String contextRoot = request.getParameter("contextRoot");
 
 String bigParaPY		= "";
 String bigParaIN 		= "";
 String bigParaDE 		= "";
 
 int count 			= Integer.parseInt(request.getParameter("rows")==null?"0":request.getParameter("rows"));

 for (int i = 0; i < count; i++)
 {
		bigParaPY = bigParaPY + request.getParameter("daysMiss" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("amountMiss" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("exHR" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("exHRAmt" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("ferHR" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("ferHRAmt" + i) + ConstantValue.DELIMITER;							
		bigParaPY = bigParaPY + request.getParameter("septHR" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("septHRAmt" + i) + ConstantValue.DELIMITER;							
		bigParaPY = bigParaPY + request.getParameter("vacDays" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("vacAmt" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("rvacDays" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("rvacAmt" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("sickDays" + i) + ConstantValue.DELIMITER;							
		bigParaPY = bigParaPY + request.getParameter("sickAmt" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("totalAmt" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("wrkDays" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("rwrkDays" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("inssLB" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("totNet" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("inssPT" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("inatec" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("trustAmt" + i) + ConstantValue.DELIMITER;
		bigParaPY = bigParaPY + request.getParameter("viatAmt" + i) + ConstantValue.DELIMITER;
		
		for(int j=0; j < 10; j++)
		{
			//if(!request.getParameter("conceptIncomeId" + j).trim().equals("") && !request.getParameter("amountINC" + j).trim().equals(""))
			//{
				bigParaIN = bigParaIN + (request.getParameter("conceptIncomeId" + j) == null?"0":request.getParameter("conceptIncomeId" + j)) + ConstantValue.DELIMITER;
				bigParaIN = bigParaIN + (request.getParameter("amountINC" + j) == null ? "0":request.getParameter("amountINC" + j)) + ConstantValue.DELIMITER;
			//}
		}
		
		for(int k=0; k < 10; k++)
		{
			//if(!request.getParameter("conceptDeductId" + k).trim().equals("") && !request.getParameter("amountDED" + k).trim().equals(""))
			//{
				bigParaDE = bigParaDE + (request.getParameter("conceptDeductId" + k) == null?"0":request.getParameter("conceptDeductId" + k)) + ConstantValue.DELIMITER;
				bigParaDE = bigParaDE + (request.getParameter("amountDED" + k) == null?"0":request.getParameter("amountDED" + k)) + ConstantValue.DELIMITER;
			//}
		}		
 }
 
 String lineId = "0";
 String emplId = "0";
 String emplNum= "0";
 
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
    String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLLIQS('" + 
 					companyID + "',0,"+
 					(employeeId.trim().equals("")?"0":employeeId) + ",'','',"+ 
 					liquidationId +",'"+
 					Format.strDatetoSQLDate(intDate) + "','"+
 					Format.strDatetoSQLDate(endDate) + "','"+ 
 					reazonId +"','" + 
 					who +"','" + 
 					ip +"','" + action +"','" +
 					bigParaPY.toString() + "','"+
 					bigParaIN.toString() + "','"+
 					bigParaDE.toString() + "'," + count +",?,?)}";
 
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="premplsetsDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="premplsetsDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="premplsetsDBBean" />
</jsp:useBean>
<%
 premplsetsDBBean.closeResultSet();
 premplsetsDBBean.execute();
 premplsetsDBBean.closeResultSet();
 
 String flag   = premplsetsDBBean.getErrorFlag();
 String errMsg = premplsetsDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S") && (!action.equals("ALINES") && !action.equals("EMPLIQPRL")))
 {
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/liquidation/liquidationlist.jsp");
 }
 else if(flag.equals("S") && action.equals("EMPLIQPRL"))
 {
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/liquidation/liquidationdetail.jsp?liquidationId=" + errMsg.trim());
 }
 else if(flag.equals("S") && action.equals("ALINES"))
 {
 %>
 	<jsp:forward page="liquidationdetail.jsp"/>
 <%
 }
 else if(flag.equals("F") && (action.equals("EMPLIQADD")))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 	<jsp:forward page="liquidationdetail.jsp"/>
 <%
 }
 else if(flag.equals("F") && (action.equals("EMPLIQPRL")))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 	<jsp:forward page="liquidationlist.jsp"/>
 <%
 }
 %>