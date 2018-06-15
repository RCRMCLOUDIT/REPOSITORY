<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String action 		= request.getParameter("action")==null?"":request.getParameter("action");

 int realcount		= 0; 

 String payrollId = request.getParameter("payrollId")==null?"":request.getParameter("payrollId");
 String concepType= request.getParameter("concepType")==null?"I":request.getParameter("concepType");
 String fixOrVar  = request.getParameter("fixOrVar")==null?"F":request.getParameter("fixOrVar");
 String conceptId =  request.getParameter("conceptId")==null?"":request.getParameter("conceptId"); 

 String conceptNM =  request.getParameter("conceptNM")==null?"":request.getParameter("conceptNM");
 String conceptDS =  request.getParameter("conceptDS")==null?"":request.getParameter("conceptDS");
 
 String isVarIncome =  request.getParameter("isVarIncome")==null?"N":request.getParameter("isVarIncome");
 String isVarDeduct =  request.getParameter("isVarDeduct")==null?"N":request.getParameter("isVarDeduct"); 

 String contextRoot = request.getParameter("contextRoot")==null?request.getContextPath():request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip = Format.getIPAddress(request).trim();
 
 String linesNumber = request.getParameter("linesNumber")==null?"0":request.getParameter("linesNumber");
 StringBuffer bigpara = new StringBuffer();
 
 realcount = 0;
 if(Integer.parseInt(linesNumber) > 0 && (action.equals("WRKCNCADD") || action.equals("WRKCNCUPD")))
 {  
 	for(int i=0;i<Integer.parseInt(linesNumber);i++)
 	{
 		if(request.getParameter("employeeId" + Integer.toString(i)).trim().length()>0)
 		{
			bigpara.append(request.getParameter("lineId" + Integer.toString(i)) == null?"0":request.getParameter("lineId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER); 		
			bigpara.append(request.getParameter("employeeId" + Integer.toString(i)) == null?"0":request.getParameter("employeeId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);
			bigpara.append(request.getParameter("employeeName" + Integer.toString(i)) == null?"0":request.getParameter("employeeName" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("amount" + Integer.toString(i)) == null?"0":request.getParameter("amount" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("percent" + Integer.toString(i)) == null?"0":request.getParameter("percent" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			 	
			bigpara.append(request.getParameter("delRec" + Integer.toString(i)) == null?"N":request.getParameter("delRec" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);
			
			realcount++; 				 							
 		}
 	}
 	linesNumber = Integer.toString(realcount); 	
 }   
 
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRWRKCNPTS('" + 
 					companyID + "'," + 
 					companyEID + "," + 
 					payrollId + ",0,'',0,''," + 
 					conceptId +",'" + 
 					concepType + "','" + 
 					fixOrVar +"','" +
 					conceptNM + "','" +
 					conceptDS + "',0,0,0," +
 					linesNumber + ",'" +
 					bigpara.toString() + "','" + 
 					action + "','" +
 					who + "','" +
 					ip + "',?,?)}"; 

 System.out.println("sqlString = " + sqlString);   
%>
<jsp:useBean id="prwrkcnptsDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prwrkcnptsDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prwrkcnptsDBBean" />
</jsp:useBean>
<%
 prwrkcnptsDBBean.closeResultSet();
 prwrkcnptsDBBean.execute();
 prwrkcnptsDBBean.closeResultSet();
 
 String flag   = prwrkcnptsDBBean.getErrorFlag();
 String errMsg = prwrkcnptsDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S") && !action.equals("ALINES") && !action.equals("ALINESU") && isVarIncome.equals("N") && isVarDeduct.equals("N")){
    //call new preload page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/mainpayroll/wrkfixedincomeslist.jsp?payrollId=" + payrollId + "&concepType="+concepType+"&contextRoot="+request.getContextPath()+"&fixOrVar="+fixOrVar);
 }
 else if(flag.equals("S") && !action.equals("ALINES") && !action.equals("ALINESU") && isVarIncome.equals("Y") && isVarDeduct.equals("N")){
    //call new preload page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/mainpayroll/wrkvariableincomeslist.jsp?payrollId=" + payrollId + "&concepType="+concepType+"&contextRoot="+request.getContextPath()+"&fixOrVar="+fixOrVar);
 } 
 else if(flag.equals("S") && !action.equals("ALINES") && !action.equals("ALINESU") && isVarIncome.equals("N") && isVarDeduct.equals("N")){
    //call new preload page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/mainpayroll/wrkfixeddeductslist.jsp?payrollId=" + payrollId + "&concepType="+concepType+"&contextRoot="+request.getContextPath()+"&fixOrVar="+fixOrVar);
 }
 else if(flag.equals("S") && !action.equals("ALINES") && !action.equals("ALINESU") && isVarIncome.equals("N") && isVarDeduct.equals("Y")){
    //call new preload page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/mainpayroll/wrkvariabledeductslist.jsp?payrollId=" + payrollId + "&concepType="+concepType+"&contextRoot="+request.getContextPath()+"&fixOrVar="+fixOrVar);
 } 
 else if(flag.equals("S") && action.equals("ALINES") && isVarIncome.equals("N") && isVarDeduct.equals("N"))
 {
 %>
 <jsp:forward page="wrkfixedincomes.jsp"/>
 <%
 }  
 else if(flag.equals("S") && action.equals("ALINES") && isVarIncome.equals("Y") && isVarDeduct.equals("N"))
 {
 %>
 <jsp:forward page="wrkvariableincomes.jsp"/>
 <%
 } 
 else if(flag.equals("S") && action.equals("ALINES") && isVarIncome.equals("N") && isVarDeduct.equals("N"))
 {
 %>
 <jsp:forward page="wrkfixeddeducts.jsp"/>
 <%
 }  
 else if(flag.equals("S") && action.equals("ALINES") && isVarIncome.equals("N") && isVarDeduct.equals("Y"))
 {
 %>
 <jsp:forward page="wrkvariablededucts.jsp"/>
 <%
 }  
 else if(flag.equals("F") && (action.equals("WRKCNCADD") || action.equals("WRKCNCUPD")) && isVarIncome.equals("N") && isVarDeduct.equals("N"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="wrkfixedincomes.jsp"/>
 <%
 } 
 else if(flag.equals("F") && (action.equals("WRKCNCADD") || action.equals("WRKCNCUPD")) && isVarIncome.equals("Y") && isVarDeduct.equals("N"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="wrkvariableincomes.jsp"/>
 <%
 }
 else if(flag.equals("F") && (action.equals("WRKCNCADD") || action.equals("WRKCNCUPD")) && isVarIncome.equals("N") && isVarDeduct.equals("N"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="wrkfixeddeducts.jsp"/>
 <%
 } 
 else if(flag.equals("F") && (action.equals("WRKCNCADD") || action.equals("WRKCNCUPD")) && isVarIncome.equals("N") && isVarDeduct.equals("Y"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="wrkvariablededucts.jsp"/>
 <%
 }
 %>