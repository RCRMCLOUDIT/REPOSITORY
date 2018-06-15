<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String name 			= request.getParameter("name")==null?"":request.getParameter("name");
 String Id			 	= request.getParameter("Id")==null?"0":request.getParameter("Id"); 
 String employeeId		= request.getParameter("employeeId")==null?"0":request.getParameter("employeeId");
 String salary		 	= request.getParameter("salary")==null?"0":request.getParameter("salary"); 
 String sctId		 	= request.getParameter("sctId")==null?"0":request.getParameter("sctId"); 

 String level		 	= request.getParameter("level")==null?"":request.getParameter("level"); 
 String codeSies	 	= request.getParameter("codeSies")==null?"":request.getParameter("codeSies"); 
 String prfType		 	= request.getParameter("prfType")==null?"":request.getParameter("prfType");
 
 String action		 	= request.getParameter("action")==null?"":request.getParameter("action"); 
 
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim();
 
 if(Id.equals(""))
 	Id = "0";
 if(employeeId.equals(""))
 	employeeId = "0";
 if(salary.equals(""))
 	salary = "0.00";
 if(sctId.equals(""))
 	sctId = "0";			
 if(level.equals(""))
 	level = "0";	

 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRJOBPROFS('" + 
 					companyID + "',0,"+
 					Id + ",'" +
 					name + "',0," + 
 					sctId + "," +
 					employeeId + "," +
 					salary + ","+
 					level + ",'" +
 					codeSies + "','" +
 					prfType.trim() + "','" +
 					who + "','" +
 					ip + "','" +
 					action +"',?,?)}"; 

 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prjobprofsDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prjobprofsDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prjobprofsDBBean" />
</jsp:useBean>
<%
 prjobprofsDBBean.closeResultSet();
 prjobprofsDBBean.execute();
 prjobprofsDBBean.closeResultSet();
 
 String flag   = prjobprofsDBBean.getErrorFlag();
 String errMsg = prjobprofsDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/confgeneral/jobprofilelist.jsp");
 }
 else if(flag.equals("F") && action.equals("JOBPRFADD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="jobprofileadd.jsp"/>
<%
 } 
 else if(flag.equals("F") && action.equals("JOBPRFUPD"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="jobprofileupd.jsp"/>
 <%
 }
 %>