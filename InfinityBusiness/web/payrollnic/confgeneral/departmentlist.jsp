<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Lista de Departamentos</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Lista de Departamentos";

 static final int DEPARTMENT_CUR = 1;

 static final int ID_COLUMN		= 1; //ID COLUMN
 static final int AV_COLUMN		= 2; //ABBREVIATION COLUMN
 static final int NM_COLUMN		= 3; //DESCRIPTION COLUMN
 static final int CC_COLUMN		= 4; //COST CENTER COLUMN 
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
 
 String tpMngrId = request.getParameter("tpMngrId")==null?"0":request.getParameter("tpMngrId");
 String tpMngrDS = request.getParameter("tpMngrDS")==null?"0":request.getParameter("tpMngrDS");

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRSETUPPYS('" + 
 					companyID + "',0,0,'',''," + tpMngrId + ",'','','',0,0,'','','DEPARTLST',?,?)}"; 
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

 String baseLink = contextRoot + "/erp/payrollnic/confgeneral/";
 					
 String link1 = baseLink + "departmentupd.jsp?startIndex=" + startIndex + "&Id=";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(DEPARTMENT_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="4">Lista de Departamentos</TD>
    </TR>
    <TR class="tableheader">
    	<TD colspan="4">Gerencia: <%=tpMngrDS%></TD>
    </TR>
    
    <TR class="tableheader">
      <TD width="10%">Id de Departamento</TD>
      <TD width="20%">Abreviatura</TD>
      <TD width="40%">Descripción</TD>      
      <TD width="30%">Centro de Costo</TD>            
    </TR>
<%
 if (listDBBean.RowCountResult(DEPARTMENT_CUR)==0) 
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
		String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(ID_COLUMN,i,DEPARTMENT_CUR)).toString() + "&tpMngrId=" + tpMngrId + "&tpMngrDS=" + tpMngrDS;	

		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;		
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD align="center" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 80, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(BigDecimal)listDBBean.valueAtColumnRowResult(ID_COLUMN,i,DEPARTMENT_CUR)%></A></TD>    
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(AV_COLUMN,i,DEPARTMENT_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(NM_COLUMN,i,DEPARTMENT_CUR))%></TD>      
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(CC_COLUMN,i,DEPARTMENT_CUR))%></TD>      
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/confgeneral/departmentadd.jsp?tpMngrId=<%=tpMngrId%>&tpMngrDS=<%=tpMngrDS%>">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD align="center" width="35%" height="30">
		<FORM name="Cancel" method="post" action="<%=contextRoot%>/erp/payrollnic/confgeneral/topmanagerlist.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00012")%>" class="button">
		</FORM>    
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>