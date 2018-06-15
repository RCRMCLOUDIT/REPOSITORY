<html> 
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>

<head> 
<title>Empleados Configurados</title> 
</head> 
<%@ include file="../../ERP_COMMON/session.jspf" %>

<frameset FRAMEBORDER=NO COLS="20%, 80%"> 
  <frame NORESIZE name="parms" src="<%=request.getContextPath()%>/erp/payrollnic/employee/tree.jsp"> 
  <frame name="list"  src="<%=request.getContextPath()%>/erp/payrollnic/employee/employeelistactive.jsp"> 

  <noframes>
  	<body> 
		  <p>This page uses frames, but your browser doesn't support them.</p> 
  	</body> 
  </noframes> 
</frameset> 

</html> 