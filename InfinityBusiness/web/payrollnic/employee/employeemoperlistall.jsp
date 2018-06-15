<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.cap.util.*,java.util.*, java.math.*, com.cap.billing.invoice.Constants" errorPage="../../ERP_COMMON/error.jsp" %>
<HTML>
<HEAD>
 <META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
 <META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
 <META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
<TITLE>Reporte de Movimientos de Colaboradores</TITLE>
</HEAD> 
 <BODY>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Reporte Movimientos Operativos de Colaboradores";

 static final int MOPER_CUR 	= 1;
 static final int NEWEMP_CUR 	= 2;
 static final int OLDEMP_CUR	= 3;

 static final int HSOLDSAL_COLUMN	= 1; //OLD SALARY  COLUMN
 static final int HSNEWSAL_COLUMN	= 2; //NEW SALARY COLUMN
 static final int HSOLDCC_COLUMN	= 3; //OLD COST CENTER COLUMN
 static final int HSNEWCC_COLUMN	= 4; //NEW COST CENTER COLUMN
 static final int HSOLDPR_COLUMN	= 5; //OLD PROFILE COLUMN
 static final int HSNEWPR_COLUMN	= 6; //NEW PROFILE COLUMN 
 static final int HSEMPLNAM_COLUMN	= 7; //EMPLOYEE NAME
 static final int HSEMPLNUM_COLUMN	= 8; //EMPLOYEE NUM
 static final int HSCHGDATE_COLUMN	= 9; //CHANGE DATE
 static final int HSINTDATE_COLUMN	= 10; //INT DATE
 static final int HSENDDATE_COLUMN	= 11; //END DATE
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
 
 String fDate		= request.getParameter("fDate")==null?"":request.getParameter("fDate");
 String tDate		= request.getParameter("tDate")==null?"":request.getParameter("tDate");
 String employeeTypeId 	= request.getParameter("employeeTypeId")==null?"0":request.getParameter("employeeTypeId"); 
 
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "',0,0,'','','',''," + employeeTypeId + ",0,0,0,'',0,'" + 
 					Format.strDatetoSQLDate(fDate) + "','" +
 					Format.strDatetoSQLDate(tDate) + "',0,0,'',0,0,0,'','','','','',0,0,'','','EMPLMPBDT','','','','','','','',0,'',0,?,?)}";
 
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
 
 listDBBean.execute(); 

 int numOfRows 	= listDBBean.getRowsInResult(MOPER_CUR);
 int numOfRows2 = listDBBean.getRowsInResult(NEWEMP_CUR);
 int numOfRows3 = listDBBean.getRowsInResult(OLDEMP_CUR); 
%>
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="12">Reporte Movimientos Operativos de Colaboradores</TD>
    </TR>
    <TR class="tableheader">
      <TD># Empleado</TD>      
      <TD>Nombre Completo</TD>      
      <TD>Puesto Anterior</TD>      
      <TD>Salario Anterior</TD>
      <TD>Centro de Costo Anterior</TD>
      <TD>Puesto Actual</TD>      
      <TD>Salario Actual</TD>
      <TD>Centro de Costo Actual</TD>
	  <TD>Tipo de Operacion</TD>      
	  <TD>Fecha de Operacion</TD>      
      <TD>Fecha de Alta</TD>
      <TD>Fecha de Baja</TD>            	  
    </TR>
<% 
 if (listDBBean.RowCountResult(MOPER_CUR)==0 && listDBBean.RowCountResult(NEWEMP_CUR)==0 && listDBBean.RowCountResult(OLDEMP_CUR)==0) 
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

%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSEMPLNUM_COLUMN,i,MOPER_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSEMPLNAM_COLUMN,i,MOPER_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSOLDPR_COLUMN,i,MOPER_CUR))%></TD>
      <TD nowrap><%=Format.displayCurrency((BigDecimal)(listDBBean.valueAtColumnRowResult(HSOLDSAL_COLUMN,i,MOPER_CUR)))%></TD>    
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSOLDCC_COLUMN,i,MOPER_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSNEWPR_COLUMN,i,MOPER_CUR))%></TD>
      <TD nowrap><%=Format.displayCurrency((BigDecimal)(listDBBean.valueAtColumnRowResult(HSNEWSAL_COLUMN,i,MOPER_CUR)))%></TD>    
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSNEWCC_COLUMN,i,MOPER_CUR))%></TD>
	  <TD nowrap>Cambio</TD>
	  <TD nowrap><%=Format.date_Str(listDBBean.valueAtColumnRowResult(HSCHGDATE_COLUMN,i,MOPER_CUR).toString())%></TD>
	  <TD nowrap><%=Format.date_Str(listDBBean.valueAtColumnRowResult(HSINTDATE_COLUMN,i,MOPER_CUR).toString())%></TD>
	  <TD nowrap></TD>	        
    </TR>
<%
			i++; 
		}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
	}
	
	for (i = 0; i < numOfRows2 ; ) 
	{ 
		try 
		{
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSEMPLNUM_COLUMN,i,NEWEMP_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSEMPLNAM_COLUMN,i,NEWEMP_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSOLDPR_COLUMN,i,NEWEMP_CUR))%></TD>
      <TD nowrap><%=Format.displayCurrency((BigDecimal)(listDBBean.valueAtColumnRowResult(HSOLDSAL_COLUMN,i,NEWEMP_CUR)))%></TD>    
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSOLDCC_COLUMN,i,NEWEMP_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSNEWPR_COLUMN,i,NEWEMP_CUR))%></TD>
      <TD nowrap><%=Format.displayCurrency((BigDecimal)(listDBBean.valueAtColumnRowResult(HSNEWSAL_COLUMN,i,NEWEMP_CUR)))%></TD>    
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSNEWCC_COLUMN,i,NEWEMP_CUR))%></TD>
	  <TD nowrap>Alta</TD>      
	  <TD nowrap><%=Format.date_Str(listDBBean.valueAtColumnRowResult(HSCHGDATE_COLUMN,i,NEWEMP_CUR).toString())%></TD>
	  <TD nowrap><%=Format.date_Str(listDBBean.valueAtColumnRowResult(HSINTDATE_COLUMN,i,NEWEMP_CUR).toString())%></TD>
	  <TD nowrap></TD>
    </TR>
<%
			i++; 
		}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
	}
	
	for (i = 0; i < numOfRows2 ; ) 
	{ 
		try 
		{
%>
    <TR class="<%=i%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSEMPLNUM_COLUMN,i,OLDEMP_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSEMPLNAM_COLUMN,i,OLDEMP_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSOLDPR_COLUMN,i,OLDEMP_CUR))%></TD>
      <TD nowrap><%=Format.displayCurrency((BigDecimal)(listDBBean.valueAtColumnRowResult(HSOLDSAL_COLUMN,i,OLDEMP_CUR)))%></TD>    
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSOLDCC_COLUMN,i,OLDEMP_CUR))%></TD>
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSNEWPR_COLUMN,i,OLDEMP_CUR))%></TD>
      <TD nowrap><%=Format.displayCurrency((BigDecimal)(listDBBean.valueAtColumnRowResult(HSNEWSAL_COLUMN,i,OLDEMP_CUR)))%></TD>    
      <TD nowrap><%=(String)(listDBBean.valueAtColumnRowResult(HSNEWCC_COLUMN,i,OLDEMP_CUR))%></TD>
	  <TD nowrap>Baja</TD>      
	  <TD nowrap><%=Format.date_Str(listDBBean.valueAtColumnRowResult(HSCHGDATE_COLUMN,i,OLDEMP_CUR).toString())%></TD>
	  <TD nowrap><%=Format.date_Str(listDBBean.valueAtColumnRowResult(HSINTDATE_COLUMN,i,OLDEMP_CUR).toString())%></TD>
	  <TD nowrap><%=Format.date_Str(listDBBean.valueAtColumnRowResult(HSENDDATE_COLUMN,i,OLDEMP_CUR).toString())%></TD>
    </TR>
<%
			i++; 
		}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
	} 	 	 	 
}
listDBBean.closeResultSet();
%>
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR>
    <TD width="30%" height="30">
	</TD>
    <TD width="20%" align="center" height="30" class="label">
 		  <INPUT type="button" name="addnew" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/employee/employeemoperentry.jsp?contextRoot=<%=request.getContextPath()%>';">
    </TD>
    <TD width="20%" align="center" height="30" class="label">
  
    </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>