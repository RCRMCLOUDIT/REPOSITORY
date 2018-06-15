<html> 
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<head> 
<title></title> 
</head> 
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
	String contextRoot = request.getContextPath();
%>	
<script type="text/javascript">
function validateForm()
{ 	
  	document.Buscar3.target = 'list';
  	return true;
}
</script>
<TABLE border="0" width="100%" cellspacing="0" cellpadding="0">
<INPUT TYPE="hidden" name = "contextPath" value="<%=contextRoot%>">
	<TR align="center" height="30" class="label">
		<TD>
		 FILTRAR POR PRIMER NOMBRE:
		</TD> 
	</TR>
	<%
	String employeeNum  = "";
	String employeeName = "";

	 char[] s;
	 s=new char[26];
	 for ( int i=0; i<26; i++) 
	 {
	%>
		<TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
			<TD>
		 		<a href="<%=contextRoot%>/erp/payrollnic/employee/employeelistall.jsp?emplFLetter=<%=(char)('A'+i)%>" target="list"><%=(char)('A'+i)%></a>
			</TD>
		</TR>
	<%
	 }
 %>
	<TR>
		<TD>
 		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/employeeadd.jsp" onSubmit="document.Add.target = 'list';return true;">
 		  	<INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
 		  	<INPUT type="hidden" name="userLang" value="<%=userLang%>">
 		  	<INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
 		</FORM>
 		</TD>
 	</TR>
 	<TR align="center" height="30" class="label">
 		<TD>
 		Buscar Por:
 		</TD>
 	</TR>	
 	<TR align="center" height="30" class="label">
 		<TD>
		Numero de Empleado:
		<FORM name="Buscar1" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/employeelistall.jsp" onSubmit="document.Buscar1.target = 'list';return true;">
  			<INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
  			<INPUT type="hidden" name="userLang" value="<%=userLang%>">
  			<INPUT type="hidden" name="filter" value="1">
  			<INPUT type="text" name="employeeNum" size="10" maxlength="10" value="<%=employeeNum%>">
  			<INPUT type="submit" name="GO" value="<%=rb.getString("B00015")%>" class="button" onClick="document.Buscar2.employeeName.value = '';">
		</FORM>
		</TD>    
 	</TR>
 	<TR align="center" height="30" class="label">
 		<TD>
		Nombre de Empleado:
		<FORM name="Buscar2" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/employeelistall.jsp" onSubmit="document.Buscar2.target = 'list';return true;">
  			<INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
  			<INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  	<INPUT type="hidden" name="filter" value="1">
  			<INPUT type="text" name="employeeName" size="10" maxlength="10" value="<%=employeeName%>">
  			<INPUT type="submit" name="GO" value="<%=rb.getString("B00015")%>" class="button" onClick="document.Buscar1.employeeNum.value = '';">
		</FORM>
		</TD>    
 	</TR>
 </TABLE>	
 <TABLE border="0" width="100%" cellspacing="0" cellpadding="0">
 	 <TR width="20%" align="center" height="30" class="label">
 	 <TD>
			Vista Actual:
			<FORM name="Buscar3" method="post" action="" onSubmit="return validateForm();">
	  			<INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
	  			<INPUT type="hidden" name="userLang" value="<%=userLang%>">
	  			<INPUT type="radio" name="status" id="all" value="all" checked onClick="document.Buscar3.action ='<%=contextRoot%>/erp/payrollnic/employee/employeelistall.jsp';"> Todos
	  			<INPUT type="radio" name="status" id="active" value="active" onClick="document.Buscar3.action ='<%=contextRoot%>/erp/payrollnic/employee/employeelistactive.jsp';"> Altas
	  			<INPUT type="radio" name="status" id="inactive" value="inactive" onClick="document.Buscar3.action ='<%=contextRoot%>/erp/payrollnic/employee/employeelistinactive.jsp';"> Bajas
	  			<INPUT type="submit" name="GO" value="<%=rb.getString("B00015")%>" class="button" onClick="document.Buscar1.employeeNum.value = '';document.Buscar2.employeeName.value = '';">
			</FORM>
		</TD>		    
 	</TR>
 </TABLE>
</html> 