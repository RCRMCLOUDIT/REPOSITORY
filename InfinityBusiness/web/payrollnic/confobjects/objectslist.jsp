<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Lista de Objetivos</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Lista de Objetivos";

 static final int OBJECT_CUR = 1;

 static final int COOBJID_COLUMN		= 1; //OBJECT ID COLUMN
 static final int COCUSTEID_COLUMN		= 2; //CUSTOMER EID
 static final int CUSTNAME_COLUMN		= 3; //CUSTOMER NAME
 static final int COOBJNAME_COLUMN		= 4; //OBJECT NAME
 static final int COOBJADDR_COLUMN		= 5; //OBJECT ADDRRESS 
 static final int COSUPVR_COLUMN		= 6; //SUPERVISOR 
 static final int COHOURS_COLUMN		= 7; //HOURS
 static final int COPOST_COLUMN			= 8; //POSITIONS  
 static final int COOBJCODE_COLUMN		= 9; //OBJECT CODE
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
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String custEid = request.getParameter("custEid")==null?"0":request.getParameter("custEid");
 String proyId  = request.getParameter("proyId")==null?"0":request.getParameter("proyId");
 
 String onlyReport = request.getParameter("onlyReport")==null?"N":request.getParameter("onlyReport");

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRCLOBJS('" + 
 					companyID + "',0," + custEid + ",0,0,0,0,'','','','','OBJECTLST','',?,?)}"; 
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

 String baseLink = contextRoot + "/erp/payrollnic/confobjects/";
 					
 String link1 = baseLink + "objectupd.jsp?startIndex=" + startIndex + "&objectId=";
 String link2 = baseLink + "detailFRAME.jsp?startIndex=" + startIndex + "&objectId=";
 
 String link3 = contextRoot + "/servlet/com.cap.erp.report.PayRollInfoPDF?action=PRTPRG&objectId=";
 
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(OBJECT_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="7">Lista de Objetivos</TD>
    </TR>
    <TR class="tableheader">
      <TD width="10%">Id de Objetivos</TD>
      <TD width="20%">Cliente</TD>
      <TD width="40%">Nombre de Objetivo</TD>      
      <TD width="30%">Direccion de Objetivo</TD>
      <TD width="30%">Supervisor</TD>
      <TD width="30%">Fondo Horario</TD>
      <TD width="30%">Puesto</TD>            
    </TR>
<%
 if (listDBBean.RowCountResult(OBJECT_CUR)==0) 
 {
%>
	<TR>
	 <TH colspan="7"><IMG src="../../ERP_COMMON/images/info.gif" width="16" border="0"> <%= rb.getString("B00007") %></TH>
	</TR>
<%
 }
 else
 {
   for (i = 0; i < numOfRows ; ) 
   { 
	try 
	{ 
		String link1s = link1 + ((BigDecimal)listDBBean.valueAtColumnRowResult(COOBJID_COLUMN,i,OBJECT_CUR)).toString() + "&proyId=" + proyId;	
		String link2s = link2 + ((BigDecimal)listDBBean.valueAtColumnRowResult(COOBJID_COLUMN,i,OBJECT_CUR)).toString() + "&custEid=" + ((BigDecimal)listDBBean.valueAtColumnRowResult(COCUSTEID_COLUMN,i,OBJECT_CUR)).toString() + "&proyId=" + proyId + "&custName=" + (String)(listDBBean.valueAtColumnRowResult(CUSTNAME_COLUMN,i,OBJECT_CUR)) + "&objName=" + (String)(listDBBean.valueAtColumnRowResult(COOBJNAME_COLUMN,i,OBJECT_CUR));

		String link3s = link3 + ((BigDecimal)listDBBean.valueAtColumnRowResult(COOBJID_COLUMN,i,OBJECT_CUR)).toString() + "&proyId=" + proyId;
		
		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;
		
		if(!proyId.equals("0") && onlyReport.equals("N"))
		{
			link = link+ ConstantValue.PRE_TAG + link2s + ConstantValue.MID_TAG + "Agregar Detalle" + ConstantValue.END_TAG;
		}			
		else if(!proyId.equals("0") && onlyReport.equals("Y"))
		{
			link = link+ ConstantValue.PRE_TAG + link3s + ConstantValue.MID_TAG + "Imprimir Programacion para Objetivo" + ConstantValue.END_TAG;
		}
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      	<TD align="center" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 200, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(BigDecimal)listDBBean.valueAtColumnRowResult(COOBJID_COLUMN,i,OBJECT_CUR)%></A></TD>    
      	<TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(CUSTNAME_COLUMN,i,OBJECT_CUR))%></TD>
      	<TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(COOBJCODE_COLUMN,i,OBJECT_CUR)) + "-" + (String)(listDBBean.valueAtColumnRowResult(COOBJNAME_COLUMN,i,OBJECT_CUR))%></TD>      
      	<TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(COOBJADDR_COLUMN,i,OBJECT_CUR))%></TD>
		<TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(COSUPVR_COLUMN,i,OBJECT_CUR))%></TD>
		<TD nowrap><%=(BigDecimal)(listDBBean.valueAtColumnRowResult(COHOURS_COLUMN,i,OBJECT_CUR))%></TD>
		<TD nowrap><%=(BigDecimal)(listDBBean.valueAtColumnRowResult(COPOST_COLUMN,i,OBJECT_CUR))%></TD>		
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/confobjects/objectadd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="hidden" name="proyId" value="<%=proyId%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD align="center" width="35%" height="30">
    <%
    if(!proyId.equals("0")) 
    {
    %>
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/confobjects/programlist.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="hidden" name="proyId" value="<%=proyId%>">
		  <INPUT type="submit" name="back" value="Volver a Programaciones" class="button">
		</FORM>
    <%
    }
     %>
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>