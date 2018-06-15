<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Experiencia Laboral</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Experiencia Laboral";

 static final int LEX_CUR = 1;

 static final int LEEXPRID_COLUMN	= 1; //EXPERIENCE ID
 static final int LECENTNM_COLUMN	= 2; //EXPERIENCE CENTER NAME
 static final int LEFDATE_COLUMN	= 4; //EXPERIENCE FROM DATE
 static final int LETDATE_COLUMN	= 5; //EXPERIENCE TO DATE
 static final int LEJOBPR_COLUMN	= 6; //EXPERIENCE JOB PROFILE
 static final int LEJOBSL_COLUMN	= 7; //EXPERIENCE JOB SALARY                                       
 static final int LEREAZON_COLUMN	= 9; //EXPERIENCE REAZON
 static final int LEAREAS_COLUMN	= 10; //EXPERIENCE AREAS
 static final int COUNTRY_COLUMN	= 11; //EXPERIENCE COUNTRY
 static final int CURRENCY_COLUMN	= 12; //EXPERIENCE CURRENCY
 
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
 					companyID + "'," + companyEID + "," + employeeId + ",'','','','',0,0,0,0,'',0,'','',0,0,'',0,0,0,'','','','','',0,0,'','','EMPLEXLST','','','','','','','',0,'',0,?,?)}";
 
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
 					
 String link1 = baseLink + "employeeexperienceadd.jsp?experienceId=";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(LEX_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="9">Experiencia Laboral</TD>
    </TR>
    <TR class="tableheader">
    	<TD colspan="9">Empleado: <%=employeeName%></TD>
    </TR>    
    <TR class="tableheader">
      <TD>Empresa donde Trabajo</TD>
      <TD>Pais</TD>
      <TD>Desde</TD>
      <TD>Hasta</TD>
	  <TD>Cargo Desempeñado</TD>
	  <TD>Sueldo</TD>
	  <TD>Moneda</TD>
	  <TD>Causa de Retiro</TD>
	  <TD>Areas Desarrolladas</TD>	              
    </TR>
<%
Date brthDate  = null;

 if (listDBBean.RowCountResult(LEX_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="9"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
		String link1s = link1 + ((BigDecimal)listDBBean.valueAtColumnRowResult(LEEXPRID_COLUMN,i,LEX_CUR)).toString() + "&employeeName=" + employeeName + "&employeeId=" + employeeId;	

		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;
  %>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 80, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(String)(listDBBean.valueAtColumnRowResult(LECENTNM_COLUMN,i,LEX_CUR))%></A></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(COUNTRY_COLUMN,i,LEX_CUR).toString().trim()%></TD>    
      <TD nowrap><%=Format.displayDate(((Date)listDBBean.valueAtColumnRowResult(LEFDATE_COLUMN,i,LEX_CUR)).toString())%></TD>
	  <TD nowrap><%=Format.displayDate(((Date)listDBBean.valueAtColumnRowResult(LETDATE_COLUMN,i,LEX_CUR)).toString())%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(LEJOBPR_COLUMN,i,LEX_CUR).toString().trim()%></TD>  
	  <TD nowrap><%=Format.displayCurrency(((BigDecimal)listDBBean.valueAtColumnRowResult(LEJOBSL_COLUMN,i,LEX_CUR)))%></TD>
	  <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(CURRENCY_COLUMN,i,LEX_CUR).toString().trim()%></TD>
	  <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(LEREAZON_COLUMN,i,LEX_CUR).toString().trim()%></TD>	  
	  <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(LEAREAS_COLUMN,i,LEX_CUR).toString().trim()%></TD>	        
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/employeeexperienceadd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
		  <INPUT type="hidden" name="employeeName" id="employeeName" value="<%=employeeName%>">	
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
	    <%
	    if(i==0)
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