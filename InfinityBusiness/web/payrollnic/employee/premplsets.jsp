<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String employeeId		= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String extId 			= request.getParameter("extId")==null?"":request.getParameter("extId"); //USE FOR SOCIAL SECURITY NUMBER
 String employeeNum		= request.getParameter("employeeNum")==null?"":request.getParameter("employeeNum");
 String federalId		= request.getParameter("federalId")==null?"":request.getParameter("federalId"); //USE FOR EMPLOYEE PERSONAL ID
 String employeeTypeId 	= request.getParameter("employeeTypeId")==null?"0":request.getParameter("employeeTypeId"); 
 String jobProfId		= request.getParameter("jobProfId")==null?"0":request.getParameter("jobProfId"); 
 String birthDate		= request.getParameter("birthDate")==null?"":request.getParameter("birthDate");
 String age				= request.getParameter("age")==null?"":request.getParameter("age");
 String intDate			= request.getParameter("intDate")==null?"":request.getParameter("intDate");
 String endDate			= request.getParameter("endDate")==null?"":request.getParameter("endDate"); 
 String ageWrks			= request.getParameter("ageWrks")==null?"":request.getParameter("ageWrks");  
 String gainsAging		= request.getParameter("gainsAging")==null?"N":request.getParameter("gainsAging");  
 String agingAmt		= request.getParameter("agingAmt")==null?"0":request.getParameter("agingAmt");  
 String emplSal			= request.getParameter("emplSal")==null?"":request.getParameter("emplSal"); 
 String emplSex			= request.getParameter("emplSex")==null?"M":request.getParameter("emplSex");  
 
 String bank			= request.getParameter("bank")==null?"":request.getParameter("bank");  
 String accNum			= request.getParameter("accNum")==null?"":request.getParameter("accNum");
 
 String marSt			= request.getParameter("marSt")==null?"":request.getParameter("marSt");   
 String drivLNum		= request.getParameter("drivLNum")==null?"":request.getParameter("drivLNum");   
 String drivLCat		= request.getParameter("drivLCat")==null?"":request.getParameter("drivLCat");   
 String bloodTyp		= request.getParameter("bloodTyp")==null?"":request.getParameter("bloodTyp");
 
 String salType			= request.getParameter("salType")==null?"":request.getParameter("salType");
           
 
 String action		 	= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String contextRoot = request.getParameter("contextRoot");
 
 String linesNumber = request.getParameter("linesNumber")==null?"0":request.getParameter("linesNumber");
 StringBuffer bigpara = new StringBuffer();
 
 int realcount = 0;
 if(Integer.parseInt(linesNumber) > 0 && action.equals("EMPFAMADD"))
 {  
 	for(int i=0;i<Integer.parseInt(linesNumber);i++)
 	{
 		if(request.getParameter("famName" + Integer.toString(i)).trim().length()>0)
 		{
			bigpara.append(request.getParameter("lineId" + Integer.toString(i)) == null?"0":request.getParameter("lineId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER); 		
			bigpara.append(request.getParameter("famName" + Integer.toString(i)) == null?"":request.getParameter("famName" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);
			bigpara.append(request.getParameter("famType" + Integer.toString(i)) == null?"":request.getParameter("famType" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("famSex" + Integer.toString(i)) == null?"":request.getParameter("famSex" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("famBrthDate" + Integer.toString(i)) == null?"":request.getParameter("famBrthDate" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("updRec" + Integer.toString(i)) == null?"N":request.getParameter("updRec" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			 							
			realcount++; 				 							
 		}
 	}
 	linesNumber = Integer.toString(realcount); 	
 }    

 if(Integer.parseInt(linesNumber) > 0 && action.equals("EMPACDADD"))
 {  
 	for(int i=0;i<Integer.parseInt(linesNumber);i++)
 	{
 		if(request.getParameter("levelId" + Integer.toString(i)).trim().length()>0)
 		{
			bigpara.append(request.getParameter("lineId" + Integer.toString(i)) == null?"0":request.getParameter("lineId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER); 		
			bigpara.append(request.getParameter("levelId" + Integer.toString(i)) == null?"0":request.getParameter("levelId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);
			bigpara.append(request.getParameter("centerName" + Integer.toString(i)) == null?"":request.getParameter("centerName" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("countryId" + Integer.toString(i)) == null?"":request.getParameter("countryId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("fDate" + Integer.toString(i)) == null?Format.getSysDate():request.getParameter("fDate" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("tDate" + Integer.toString(i)) == null?Format.getSysDate():request.getParameter("tDate" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("title" + Integer.toString(i)) == null?"":request.getParameter("title" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("updRec" + Integer.toString(i)) == null?"N":request.getParameter("updRec" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			 							
			realcount++; 				 							
 		}
 	}
 	linesNumber = Integer.toString(realcount); 	
 }    

 if(Integer.parseInt(linesNumber) > 0 && action.equals("EMPSCLADD"))
 {  
 	for(int i=0;i<Integer.parseInt(linesNumber);i++)
 	{
 		if(request.getParameter("scaleType" + Integer.toString(i)).trim().length()>0)
 		{
			bigpara.append(request.getParameter("lineId" + Integer.toString(i)) == null?"0":request.getParameter("lineId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER); 		
			bigpara.append(request.getParameter("scaleType" + Integer.toString(i)) == null?"":request.getParameter("scaleType" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);
			bigpara.append(request.getParameter("fDate" + Integer.toString(i)) == null?Format.getSysDate():request.getParameter("fDate" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("tDate" + Integer.toString(i)) == null?Format.getSysDate():request.getParameter("tDate" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("days" + Integer.toString(i)) == null?"":request.getParameter("days" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);
			bigpara.append(request.getParameter("memo" + Integer.toString(i)) == null?"":request.getParameter("memo" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("authId" + Integer.toString(i)) == null?"0":request.getParameter("authId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("scaleStatus" + Integer.toString(i)) == null?"":request.getParameter("scaleStatus" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("updRec" + Integer.toString(i)) == null?"N":request.getParameter("updRec" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			 							
			realcount++; 				 							
 		}
 	}
 	linesNumber = Integer.toString(realcount); 	
 }    

 if(Integer.parseInt(linesNumber) > 0 && action.equals("EMPLEXADD"))
 {  
 	for(int i=0;i<Integer.parseInt(linesNumber);i++)
 	{
 		if(request.getParameter("centerName" + Integer.toString(i)).trim().length()>0)
 		{
			bigpara.append(request.getParameter("lineId" + Integer.toString(i)) == null?"0":request.getParameter("lineId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER); 		
			bigpara.append(request.getParameter("centerName" + Integer.toString(i)) == null?"":request.getParameter("centerName" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("countryId" + Integer.toString(i)) == null?"":request.getParameter("countryId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("fDate" + Integer.toString(i)) == null?Format.getSysDate():request.getParameter("fDate" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("tDate" + Integer.toString(i)) == null?Format.getSysDate():request.getParameter("tDate" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("jobProfile" + Integer.toString(i)) == null?"":request.getParameter("jobProfile" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("jobSalary" + Integer.toString(i)) == null?"":request.getParameter("jobSalary" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			bigpara.append(request.getParameter("currencyId" + Integer.toString(i)) == null?"":request.getParameter("currencyId" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("reazon" + Integer.toString(i)) == null?"":request.getParameter("reazon" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);			
			bigpara.append(request.getParameter("areas" + Integer.toString(i)) == null?"":request.getParameter("areas" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);						
			bigpara.append(request.getParameter("updRec" + Integer.toString(i)) == null?"N":request.getParameter("updRec" + Integer.toString(i)));
			bigpara.append(ConstantValue.DELIMITER);	
			 							
			realcount++; 				 							
 		}
 	}
 	linesNumber = Integer.toString(realcount); 	
 }    
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 
 String objectId		= request.getParameter("objectId")==null?"0":request.getParameter("objectId");
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "',0,"+
 					(employeeId.trim().equals("")?"0":employeeId) + ",'" +
 					employeeName + "','" +
 					extId + "','" +
 					employeeNum + "','" +
 					federalId + "'," +
 					(employeeTypeId.trim().equals("")?"0":employeeTypeId) + "," +
 					(jobProfId.trim().equals("")?"0":jobProfId) + ",0,0,'" +
 					Format.strDatetoSQLDate(birthDate) + "'," +
 					(age.trim().equals("")?"0":age) + ",'" +
 					Format.strDatetoSQLDate(intDate) + "','" +
 					Format.strDatetoSQLDate(endDate) + "'," +
 					(ageWrks.trim().equals("")?"0":ageWrks) + "," +
 					(ageWrks.trim().equals("")?"0":ageWrks) + ",'" +
 					gainsAging + "',0,0," +
 					(emplSal.trim().equals("")?"0":emplSal) + ",'" +
 					emplSex + "','','','','',0,0,'" +
 					who + "','" +
 					ip + "','" +
 					action + "','" +
 					bank + "','" +
 					accNum + "','" +
 					marSt + "','" +
 					drivLNum + "','" +
 					drivLCat + "','" +
 					bloodTyp + "','" +
 					bigpara.toString() + "'," + linesNumber +",'" + salType + "'," + objectId + ",?,?)}";

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
 
 if(flag.equals("S") && !action.equals("ALINES") && !action.equals("ALINESACD") && !action.equals("ALINESSCA") && !action.equals("ALINESLEX") && !action.equals("EMPFAMADD") && !action.equals("EMPACDADD") && !action.equals("EMPSCLADD") && !action.equals("EMPLEXADD"))
 {
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/employee/employeelistactive.jsp");
 }
 else if(flag.equals("S") && !action.equals("ALINES") && action.equals("EMPFAMADD") && !action.equals("ALINESACD") && !action.equals("ALINESSCA") && !action.equals("ALINESLEX"))
 {
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/employee/employeefamlist.jsp?employeeId="+ employeeId + "&employeeName=" + employeeName);
 }
 else if(flag.equals("S") && !action.equals("ALINES") && action.equals("EMPACDADD") && !action.equals("ALINESACD") && !action.equals("ALINESSCA") && !action.equals("ALINESLEX"))
 {
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/employee/employeeacademylist.jsp?employeeId="+ employeeId + "&employeeName=" + employeeName);
 }
 else if(flag.equals("S") && !action.equals("ALINES") && action.equals("EMPSCLADD") && !action.equals("ALINESACD") && !action.equals("ALINESSCA") && !action.equals("ALINESLEX"))
 {
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/employee/employeescalelist.jsp?employeeId="+ employeeId + "&employeeName=" + employeeName);
 }
 else if(flag.equals("S") && !action.equals("ALINES") && action.equals("EMPLEXADD") && !action.equals("ALINESACD") && !action.equals("ALINESSCA") && !action.equals("ALINESLEX"))
 {
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/employee/employeeexperiencelist.jsp?employeeId="+ employeeId + "&employeeName=" + employeeName);
 }  
 else if(flag.equals("S") && action.equals("ALINES") && !action.equals("ALINESACD") && !action.equals("ALINESSCA") && !action.equals("ALINESLEX"))
 {
 %>
 	<jsp:forward page="employeefamadd.jsp"/>
 <%
 }
 else if(flag.equals("S") && action.equals("ALINESACD") && !action.equals("ALINES") && !action.equals("ALINESSCA") && !action.equals("ALINESLEX"))
 {
 %>
 	<jsp:forward page="employeeacademyadd.jsp"/>
 <%
 }  
 else if(flag.equals("S") && action.equals("ALINESSCA") && !action.equals("ALINESACD") && !action.equals("ALINES") && !action.equals("ALINESLEX"))
 {
 %>
 	<jsp:forward page="employeescaleadd.jsp"/>
 <%
 }
 else if(flag.equals("S") && action.equals("ALINESLEX") && !action.equals("ALINESSCA") && !action.equals("ALINESACD") && !action.equals("ALINES"))
 {
 %>
 	<jsp:forward page="employeeexperienceadd.jsp"/>
 <%
 }           
 else if(flag.equals("F") && action.equals("EMPLOYADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 	<jsp:forward page="employeeadd.jsp"/>
 <%
 }
 else if(flag.equals("F") && action.equals("EMPFAMADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 	<jsp:forward page="employeefamadd.jsp"/>
 <%
 } 
 else if(flag.equals("F") && action.equals("EMPACDADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 	<jsp:forward page="employeeacademyadd.jsp"/>
 <%
 }
 else if(flag.equals("F") && action.equals("EMPSCLADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 	<jsp:forward page="employeescaleadd.jsp"/>
 <%
 }
 else if(flag.equals("F") && action.equals("EMPLEXADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 	<jsp:forward page="employeeexperienceadd.jsp"/>
 <%
 }         
 else if(flag.equals("F") && action.equals("EMPLOYUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 	<jsp:forward page="employeeupd.jsp"/>
 <%
 }
 %>