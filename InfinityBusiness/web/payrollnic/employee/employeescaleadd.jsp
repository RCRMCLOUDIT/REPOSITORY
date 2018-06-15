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
 <BODY onload="javascript: document.myForm.scaleType0.focus()">
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
<%! 
 static final String title = "Solicitud de Vacaciones o Justificacion de Ausencia";

 static final int INFDTA = 1;
 static final int VACDY  = 2;

static final int DAYSTP_COLUMN		= 1;
    
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
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/overlib_mini.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/searchemployees.js"></SCRIPT>
<script language="JavaScript">
function valScale(form)
{
	//alert("Entro a la Funcion");
	//alert(form);
	//alert(form.addnew.value);
	var rows	= 0;
	for(var i = 0; i < form.linesNumber.value; i++)
	{
		if(eval("form.scaleType"+i+".selectedIndex") != 0)
		{
    		if ((eval("form.fDate" + i + ".value.length == 0")) || (!isValidDate(eval("form.fDate" + i))))  
    		{
    		    eval("form.fDate" + i + ".focus()");
    			eval("form.fDate" + i + ".select()");
    			alert("Por Favor digite Fecha Desde valida para continuar.");
    			return false;
    		}  
    	
    		if ((eval("form.tDate" + i + ".value.length == 0")) || (!isValidDate(eval("form.tDate" + i))))  
			{
    		    eval("form.tDate" + i + ".focus()");
    			eval("form.tDate" + i + ".select()");
				alert("Por Favor ingrese Fecha Hasta valida para continuar.");
				return false;
			}
			
			if ((eval("form.days" + i + ".value.length == 0")) ||  (eval("form.days" + i + ".value")==""))
			{
			    eval("form.days" + i + ".focus()");
    			eval("form.days" + i + ".select()");
				alert("Por Favor ingrese Dias validos para continuar.");
				return false;
			}		
		
			if ((eval("form.memo" + i + ".value.length == 0")) ||  (eval("form.memo" + i + ".value")==""))
			{
			    eval("form.memo" + i + ".focus()");
    			eval("form.memo" + i + ".select()");
				alert("Por Favor ingrese Memo valido para continuar.");
				return false;
			}

			rows++;
		}
	}	
	
	if(rows == 0)
	{
		alert("Ingrese al menos una linea para Continuar.")
		return false;
	}	
	else
	{
    	form.addnew.disabled = true;
    	form.addnew.value = "Por Favor Esperar...";
    	return true;
    }	
}
</script>
<%
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";
 String errMsg=null;
 String contextRoot = request.getContextPath(); 
 
 String employeeId 		= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 
 String action	  		= request.getParameter("action")==null?"EMPSCLNEW":request.getParameter("action");
  
 int linesNumber = request.getParameter("linesNumber")==null?10:((new Integer(request.getParameter("linesNumber"))).intValue());
 
 String scaleId	= request.getParameter("scaleId")==null?"0":request.getParameter("scaleId");
 
 if(!scaleId.equals("0"))
  action = "EMPSCLEDT";

 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "',0," + employeeId + ",'','','','',0,0,0,0,'',0,'','',0,0,'',0,0,0,'','','','','',0,0,'','','" + action + "','','','','','','','',0,'',?,?)}";
  					
 System.out.println("sqlString = " + sqlString); 					
%>
<jsp:useBean id="listDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="listDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="listDBBean" />
</jsp:useBean>
<%
 String link = null;

 String baseLink = contextRoot + "/erp/payrollnic/mainpayroll/";
	
String lineId		= "";

String scaleType	= "";
String scaleStatus	= "";
String fDate		= "";
String tDate		= "";
String days			= "";
String memo			= "";

String authId		= "";
String authName		= "";
 					
 listDBBean.execute(); 
	 
int detRows = 0;

int detDAYS = listDBBean.getRowsInResult(VACDY);

if(action.equals("EMPSCLEDT"))
	detRows = listDBBean.getRowsInResult(INFDTA);	

if(detRows > 0 && !action.equals("ALINESSCA"))
	linesNumber = detRows; 
%>
<FORM name = "myForm" method="POST" action="<%=contextRoot%>/erp/payrollnic/employee/premplsets.jsp" onsubmit="return valScale(myForm);">
<TABLE width="750" cellpadding="0" cellspacing="1" class="Border" border="0">
    <TR class="tableheader">
    	<TD colspan="7">Solicitud de Vacaciones o Justificacion de Ausencia</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label">Nombre de Empleado</TD>
      <TD colspan="7"><%=employeeName%></TD>
	</TR>       
    <%
    	if(detDAYS > 0)
    	{
    %>	
    <TR class="pcrinfo">
      <TD class="label">Vacaciones Acumuladas</TD>
      <TD colspan="7"><%=((BigDecimal)listDBBean.valueAtColumnRowResult(DAYSTP_COLUMN,0,VACDY)).toString().trim()%></TD>
	</TR>       	
    <% } %>
    <TR class="tableheader">
      <TD>Tipo de Ausencia</TD>
      <TD>Desde</TD>      
      <TD>Hasta</TD> 
      <TD>Dias</TD>
	  <TD>Memo</TD>       
	  <TD>Autorizado Por</TD>
	  <TD>Estado</TD>	         	           
    </TR>
<%
	String updRec = "";
	for(int j=0;j<linesNumber;j++)
  	{ 
	try 
	{ 
		scaleStatus		= request.getParameter("scaleStatus"+j)==null?"":request.getParameter("scaleStatus"+j);
		scaleType		= request.getParameter("scaleType"+j)==null?"":request.getParameter("scaleType"+j);	
		days			= request.getParameter("days"+j)==null?"":request.getParameter("days"+j);	
		memo			= request.getParameter("memo"+j)==null?"":request.getParameter("memo"+j);			
		fDate			= request.getParameter("fDate"+j)==null?"":request.getParameter("fDate"+j);			
		tDate			= request.getParameter("tDate"+j)==null?"":request.getParameter("tDate"+j);
		lineId			= request.getParameter("lineId"+j)==null?String.valueOf(j):request.getParameter("lineId"+j);
		updRec			= request.getParameter("updRec"+j)==null?String.valueOf(j):request.getParameter("updRec"+j);
		authId			= request.getParameter("authId"+j)==null?"":request.getParameter("authId"+j);
		authName		= request.getParameter("authName"+j)==null?"":request.getParameter("authName"+j);

		if(action.equals("EMPSCLEDT"))
		{
			memo			= (String)listDBBean.valueAtColumnRowResult(RAMEMO_COLUMN,j,INFDTA).toString().trim();
			days			= ((BigDecimal)listDBBean.valueAtColumnRowResult(RADAYS_COLUMN,j,INFDTA)).toString().trim();			
			scaleType		= ((String)listDBBean.valueAtColumnRowResult(RATYPE_COLUMN,j,INFDTA)).toString().trim();	
			scaleStatus		= (String)listDBBean.valueAtColumnRowResult(RASTATUS_COLUMN,j,INFDTA).toString().trim();
			fDate 	   		= ((Date)listDBBean.valueAtColumnRowResult(RAFDATE_COLUMN,j,INFDTA)).toString().trim();
			tDate 	   		= ((Date)listDBBean.valueAtColumnRowResult(RATDATE_COLUMN,j,INFDTA)).toString().trim();						
			lineId			= ((BigDecimal)listDBBean.valueAtColumnRowResult(RAAUSLNID_COLUMN,j,INFDTA)).toString().trim();	
			authId			= ((BigDecimal)listDBBean.valueAtColumnRowResult(RAAPPRBY_COLUMN,j,INFDTA)).toString().trim();	
			authName		= (String)listDBBean.valueAtColumnRowResult(RAAPPRBYNM_COLUMN,j,INFDTA).toString().trim();
			updRec			= "Y";		
			
			fDate = Format.displayDate(fDate);
			tDate = Format.displayDate(tDate);						
		}	
%>
    <TR class="<%=j%2==0?"pcrinfo":"pcrinfo1"%>">
      <TD nowrap align="left">
        <INPUT type="hidden" name="updRec<%=j%>" value="<%=updRec%>"> 
    	<INPUT type="hidden" name="lineId<%=j%>" value="<%=lineId%>">
      	<select size="1" name="scaleType<%=j%>">
      		<option value="" <%=scaleType.equals("")?"selected":""%>>Seleccione Una Opcion</option>
       		<option value="VP" <%=scaleType.equals("VP")?"selected":""%>>Vacaciones Pagadas</option>
			<option value="VD" <%=scaleType.equals("VD")?"selected":""%>>Vacaciones Descansadas</option>
			<option value="SB" <%=scaleType.equals("SB")?"selected":""%>>Subsidio</option>
			<option value="PS" <%=scaleType.equals("PS")?"selected":""%>>Permiso S/Goce de Salario</option>
			<option value="AI" <%=scaleType.equals("AI")?"selected":""%>>Ausencia Infustificada</option>			
		</select>
	  </TD>
      <TD nowrap align=center>
       <INPUT size="12" maxlength="10" type="text" name="fDate<%=j%>" class="pcrInfo" value="<%=fDate%>" onKeyUp="addSlash(myForm.fDate<%=j%>)" onChange="formatDate(myForm.fDate<%=j%>)" onKeyPress="OnlyDigits();addSlash(myForm.fDate<%=j%>)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.fDate<%=j%>, 'mm/dd/yyyy', 350, -1);" alt="Calendar">        
      </TD>
      <TD nowrap align=center>
       <INPUT size="12" maxlength="10" type="text" name="tDate<%=j%>" class="pcrInfo" value="<%=tDate%>" onKeyUp="addSlash(myForm.tDate<%=j%>)" onChange="formatDate(myForm.tDate<%=j%>)" onKeyPress="OnlyDigits();addSlash(myForm.tDate<%=j%>)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.tDate<%=j%>, 'mm/dd/yyyy', 350, -1);" alt="Calendar">        
      </TD>
	  <TD>
		<INPUT size="5" maxlength="5" type="text" name="days<%=j%>" class="pcrInfo" value="<%=days%>">	   
	  </TD>	      
	  <TD>
	   <INPUT size="100" maxlength="250" type="text" name="memo<%=j%>" class="pcrInfo" value="<%=memo%>">
	  </TD>	      
      <TD nowrap align="left">
		<INPUT type="hidden" name="authId<%=j%>" id="authId<%=j%>" value="<%=authId%>">
 		<INPUT size="30" name="authName<%=j%>" type="text" class="text"	maxlength="40" value="<%=authName%>" id="authName<%=j%>"  onchange="this.form.authId<%=j%>.value='';" onkeypress='if(isEnterPressed()) openSEmployeesDialog("myForm", "authId<%=j%>", "authName<%=j%>", "0", "<%= request.getContextPath()%>","","");'>
		<INPUT type="button" name="searchEmp<%=j%>" value=" v " onclick='openSEmployeesDialog("myForm", "authId<%=j%>", "authName<%=j%>", "0" , "<%= request.getContextPath()%>","","");'>      
      </TD>	  
      <TD nowrap align="left">
      	<select size="1" name="scaleStatus<%=j%>">
      		<option value="DR" <%=scaleStatus.equals("DR")?"selected":""%>>Borrador</option>
			<option value="AP" <%=scaleStatus.equals("AP")?"selected":""%>>Aprobado</option>
			<option value="VD" <%=scaleStatus.equals("VD")?"selected":""%>>Anulado</option>
		</select>
	  </TD>
    </TR>  
<%
	}catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
 } 
listDBBean.closeResultSet();
%>
    <TR>
		<TD colspan="7">
			<TABLE width="100%" border="0" cellpadding="0" cellspacing="1" height="30">
				<TR>
					<TD><INPUT type="button" name="addLines" value="<%=rb.getString("B00034")%>" class="button" onclick="document.myForm.action.value='ALINESSCA';document.myForm.linesNumber.value='<%=linesNumber+4%>';document.myForm.submit();"></TD>
					<TD align="right" class="label"></TD>
                </TR>
            </TABLE>
		</TD>
	</TR>  
</TABLE>
<TABLE border="0" width="750" cellspacing="0" cellpadding="0">
    <TR>
    <TD width="30%" height="30">
		  <INPUT type="hidden" name="linesNumber" id="linesNumber" value="<%=linesNumber%>">
		  <INPUT type="hidden" name="action" value="EMPSCLADD">
		  <INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
		  <INPUT type="hidden" name="employeeName" id="employeeName" value="<%=employeeName%>">	
		  <INPUT type="hidden" name="callF" id="callF" value="<%=request.getParameter("callF")==null?"":request.getParameter("callF")%>">
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="submit" name="addnew" id ="addnew" value="<%=rb.getString("B00008")%>" class="button">
	</TD>
    <TD align="center" width="35%" height="30"> 
		  <INPUT type="hidden" name="contextRoot" value="<%=contextRoot%>">  
		  <INPUT type="hidden" name="userLang" value="<%=userLang%>">
		  <INPUT type="button" name="cancel" value="<%=rb.getString("B00010")%>" class="button" onClick="window.location='<%=contextRoot%>/erp/payrollnic/employee/employeescalelist.jsp?contextRoot=<%=request.getContextPath()%>&employeeId=<%=employeeId%>&employeeName=<%=employeeName%>&callF=<%=request.getParameter("callF")==null?"":request.getParameter("callF")%>';">
    </TD>
    <TD width="18%" align="center" height="30">
     </TD>
      <TD width="17%" align="right" height="30">
      </TD>
    </TR>
  </TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>    
</HTML>