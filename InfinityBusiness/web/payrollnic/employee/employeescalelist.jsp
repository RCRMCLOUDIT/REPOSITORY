<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Solicitud de Vacaciones o Justificacion de Ausencia</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Solicitud de Vacaciones o Justificacion de Ausencia";

 static final int SCALE_CUR = 1;

static final int RAAUSID_COLUMN		= 1;
static final int RAAUSLNID_COLUMN	= 2;
static final int RAEMPLID_COLUMN	= 3;
static final int EMPLNM_COLUMN		= 4;
static final int RATYPE_COLUMN		= 5;
static final int RASTATUS_COLUMN	= 6;
static final int RAAPPRBY_COLUMN	= 7;
static final int RAAPPRBYNM_COLUMN	= 8;
static final int RACHCKBY_COLUMN	= 9;
static final int RACHCKBYNM_COLUMN	= 10;
static final int RAFDATE_COLUMN		= 11;
static final int RATDATE_COLUMN		= 12;
static final int RADAYS_COLUMN		= 13;
static final int RAMEMO_COLUMN		= 14;
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
 					companyID + "',0," + employeeId + ",'','','','',0,0,0,0,'',0,'','',0,0,'',0,0,0,'','','','','',0,0,'','','EMPSCLLST','','','','','','','',0,'',?,?)}";
 
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
 					
 String link1 = baseLink + "employeescaleadd.jsp?scaleId=";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(SCALE_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="6">Solicitud de Vacaciones o Justificacion de Ausencia</TD>
    </TR>
    <TR class="tableheader">
    	<TD colspan="6">Empleado: <%=employeeName%></TD>
    </TR>    
    <TR class="tableheader">
      <TD>Id</TD>
      <TD>Tipo</TD>
      <TD>Desde</TD>
      <TD>Hasta</TD>
      <TD>Dias</TD>
	  <TD>Memo</TD>            
    </TR>
<%
String scaleType = "";
String status	 = "";
Date fDate  	 = null;
Date tDate  	 = null;

 if (listDBBean.RowCountResult(SCALE_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="5"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
		String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(RAAUSID_COLUMN,i,SCALE_CUR)).toString() + "&employeeName=" + employeeName + "&employeeId=" + employeeId + "&callF=" + request.getParameter("callF");	

		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;					
		
		scaleType  = (String)listDBBean.valueAtColumnRowResult(RATYPE_COLUMN,i,SCALE_CUR).toString().trim();
		status	   = (String)listDBBean.valueAtColumnRowResult(RASTATUS_COLUMN,i,SCALE_CUR).toString().trim();
		fDate 	   = (Date)listDBBean.valueAtColumnRowResult(RAFDATE_COLUMN,i,SCALE_CUR);
		tDate 	   = (Date)listDBBean.valueAtColumnRowResult(RATDATE_COLUMN,i,SCALE_CUR);
		
		if(scaleType.equals("VP"))
			scaleType = "Vacaciones Pagadas";
		else if(scaleType.equals("VD"))
			scaleType = "Vacaciones Descansadas";
		else if(scaleType.equals("SB"))
			scaleType = "Subsidio";
		else if(scaleType.equals("PS"))
			scaleType = "Permiso S/Goce de Salario";	
		else if(scaleType.equals("AI"))
			scaleType = "Ausencia Injustificada";				
		else
			scaleType = "";				
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 80, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(BigDecimal)(listDBBean.valueAtColumnRowResult(RAAUSLNID_COLUMN,i,SCALE_CUR))%></A></TD>
      <TD nowrap><%=scaleType%></TD>      
      <TD nowrap><%=Format.displayDate(fDate.toString())%></TD>    
      <TD nowrap><%=Format.displayDate(tDate.toString())%></TD>
      <TD nowrap><%=(BigDecimal)listDBBean.valueAtColumnRowResult(RADAYS_COLUMN,i,SCALE_CUR)%></TD>
      <TD nowrap><%=(String)listDBBean.valueAtColumnRowResult(RAMEMO_COLUMN,i,SCALE_CUR)%></TD>
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/employee/employeescaleadd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
		  <INPUT type="hidden" name="callF" id="callF" value="<%=request.getParameter("callF")%>">
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
 		  <INPUT type="button" name="addnew" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/employee/employeelist.jsp?contextRoot=<%=request.getContextPath()%>';">
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