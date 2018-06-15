<html> 
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>

<head> 
<title>Detalle de Programa</title> 
</head> 
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
String custEid 	= request.getParameter("custEid")==null?"0":request.getParameter("custEid");
String proyId  	= request.getParameter("proyId")==null?"0":request.getParameter("proyId");
String objectId	= request.getParameter("objectId")==null?"0":request.getParameter("objectId");

String custName = request.getParameter("custName")==null?"":request.getParameter("custName");
String objName = request.getParameter("objName")==null?"":request.getParameter("objName");

%>
<frameset FRAMEBORDER=NO COLS="15%, 95%"> 
  <frame NORESIZE name="parms" src="<%=request.getContextPath()%>/erp/payrollnic/confobjects/tree.jsp?proyId=<%=proyId%>"> 
  <frame name="list"  src="<%=request.getContextPath()%>/erp/payrollnic/confobjects/programdetail.jsp?custEid=<%=custEid%>&proyId=<%=proyId%>&objectId=<%=objectId%>&custName=<%=custName%>&objName=<%=objName%>"> 

  <noframes>
  	<body> 
		  <p>This page uses frames, but your browser doesn't support them.</p> 
  	</body> 
  </noframes> 
</frameset> 

</html> 
