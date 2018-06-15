<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Datos Familiares</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Datos Familiares";

 static final int FAM_CUR = 1;

 static final int EFFAMID_COLUMN	= 1; //FAMILY ID COLUMN 
 static final int EFNAME_COLUMN		= 2; //FAMILY NAME COLUMN
 static final int EFTYPE_COLUMN		= 3; //FAMILY TYPE COLUMN
 static final int EFSEX_COLUMN		= 4; //SEX COLUMN
 static final int EFBRTHDAY_COLUMN	= 5; //BIRTHDAY COLUMN 
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<%
 String contextRoot = request.getContextPath(); 
 
 String employeeId 		= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "',0," + employeeId + ",'','','','',0,0,0,0,'',0,'','',0,0,'',0,0,0,'','','','','',0,0,'','','EMPFAMLST','','','','','','','',0,'',0,?,?)}";
 
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
int startIndex = (request.getParameter("startIndex")==null) ? 0 : Integer.parseInt(request.getParameter("startIndex").trim());
int i = 0;

 String link = null;

 String baseLink = contextRoot + "/erp/payrollnic/employee/";
 					
 String link1 = baseLink + "employeefamadd.jsp?famId=";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(FAM_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="4">Datos Familiares</TD>
    </TR>
    <TR class="tableheader">
    	<TD colspan="4">Empleado: <%=employeeName%></TD>
    </TR>    
    <TR class="tableheader">
      <TD>Nombre</TD>
      <TD>Tipo</TD>
      <TD>Sexo</TD>
      <TD>Fecha de Nacimiento</TD>      
    </TR>
<%
String famType = "";
String famSex  = "";
Date brthDate  = null;

 if (listDBBean.RowCountResult(FAM_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="4"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
		String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(EFFAMID_COLUMN,i,FAM_CUR)).toString() + "&employeeName=" + employeeName + "&employeeId=" + employeeId;	

		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;					
		
		famType  = (String)listDBBean.valueAtColumnRowResult(EFTYPE_COLUMN,i,FAM_CUR).toString().trim();
		famSex	 = (String)listDBBean.valueAtColumnRowResult(EFSEX_COLUMN,i,FAM_CUR).toString().trim();
		brthDate = (Date)listDBBean.valueAtColumnRowResult(EFBRTHDAY_COLUMN,i,FAM_CUR);
		
		if(famType.equals("MA"))
			famType = "Mama";
		else if(famType.equals("PA"))
			famType = "Papa";
		else if(famType.equals("HO"))
			famType = "Hijo";
		else if(famType.equals("HA"))
			famType = "Hija";	
		else if(famType.equals("ES"))
			famType = "Espos@";	
		else
			famType = "";
			
		if(famSex.equals("M"))
			famSex = "Masculino";
		else if(famSex.equals("F"))
			famSex = "Femenino";
		else
			famSex = "";						
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 80, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)(listDBBean.valueAtColumnRowResult(EFNAME_COLUMN,i,FAM_CUR))%></A></TD>
      <TD nowrap><%=famType%></TD>    
      <TD nowrap><%=famSex%></TD>
      <TD nowrap><%=Format.displayDate(brthDate.toString())%></TD>
    </TR>
<%
		i++; 
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
 startIndex = i;
}
listDBBean.closeResultSet();
%>
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR><TD width="30%" height="30">
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/employeefamadd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
		  <INPUT type="hidden" name="employeeName" id="employeeName" value="<%=employeeName%>">	
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
    <%
    if( i == 0)
    { 
    %>
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
    <%
    }
     %>
		</FORM>
	</TD>
    <TD width="20%" align="center" height="30" class="label">
    <%if(request.getParameter("callF")!=null){%>
     	 <INPUT type="button" name="addnew" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/servlet/com.cap.erp.Controller?action=ListEmployee';">
    <%}else{ %>
 		  <INPUT type="button" name="addnew" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/employee/employeelistactive.jsp?contextRoot=<%=request.getContextPath()%>';">
	<%}%> 		  
    </TD>
    <TD width="20%" align="center" height="30" class="label">
  
    </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>