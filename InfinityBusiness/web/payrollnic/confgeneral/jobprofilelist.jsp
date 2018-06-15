<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Lista de Cargos</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Lista de Cargos";

 static final int JOBPROF_CUR = 1;

 static final int ID_COLUMN		= 1; //ID COLUMN
 static final int NM_COLUMN		= 2; //DESCRIPTION COLUMN
 static final int BS_COLUMN		= 3; //BOSS COLUMN
 static final int SL_COLUMN		= 4; //SALARY SOLUMN
 static final int TM_COLUMN		= 5; //TOP MANAGER DS 
 static final int CS_COLUMN		= 6; //SECTION DS
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

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRJOBPROFS('" + 
 					companyID + "',0,0,'',0,0,0,0,0,'','','','','JOBPRFLST',?,?)}"; 
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
 					
 String link1 = baseLink + "jobprofileupd.jsp?startIndex=" + startIndex + "&Id=";
 
 listDBBean.execute(); 

 int numOfRows = listDBBean.getRowsInResult(JOBPROF_CUR);
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="5">Lista de Cargos</TD>
    </TR>
    <TR class="tableheader">
      <TD width="20%">Gerencia - Departamento</TD>
      <TD width="10%">Id de Cargo</TD>
      <TD width="20%">Descripción</TD>
      <TD width="30%">Jefe Inmediato</TD>      
      <TD width="20%">Salario de Cargo</TD>            
    </TR>
<%
 if (listDBBean.RowCountResult(JOBPROF_CUR)==0) 
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
		String link1s = link1 + ((java.math.BigDecimal)listDBBean.valueAtColumnRowResult(ID_COLUMN,i,JOBPROF_CUR)).toString() ;	

		link = ConstantValue.PRE_TAG + link1s + ConstantValue.MID_TAG + "Editar" + ConstantValue.END_TAG;			
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(TM_COLUMN,i,JOBPROF_CUR)) + "-" + (String)(listDBBean.valueAtColumnRowResult(CS_COLUMN,i,JOBPROF_CUR))%></TD>
      <TD align="center" nowrap><A href="javascript:void(0);" class="link_alt_underline" onmouseover="this.className='link_over_alt_underline';return overlib('<%=link%>', STICKY, WIDTH, 80, BORDER, 1, HAUTO, OFFSETY, -5,OFFSETX,20, TIMEOUT,3000);" onmouseout='this.className="link_alt_underline";return nd();'><%=(BigDecimal)listDBBean.valueAtColumnRowResult(ID_COLUMN,i,JOBPROF_CUR)%></A></TD>    
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(NM_COLUMN,i,JOBPROF_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(BS_COLUMN,i,JOBPROF_CUR))%></TD>      
      <TD nowrap><%=Format.formatCurrency((BigDecimal)(listDBBean.valueAtColumnRowResult(SL_COLUMN,i,JOBPROF_CUR)))%></TD>      
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
		<FORM name="Add" method="post" action="<%=contextRoot%>/erp/payrollnic/confgeneral/jobprofileadd.jsp">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" value="<%=rb.getString("B00001")%>" class="button">
		</FORM>
	</TD>
    <TD align="center" width="35%" height="30"> 
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>