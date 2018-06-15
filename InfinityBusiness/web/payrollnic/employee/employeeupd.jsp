<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Editar Empleado</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.employeeName.focus()">
<%@ page errorPage="../../ERP_COMMON/error.jsp" import="com.cap.util.*,java.math.*" %>
<%! 
 static final String title = "Editar Empleado"; 
 
 static final int JOBPRFL_CUR 	= 1; //JOB PROFILES CURSOR
 static final int EMPLTYP_CUR 	= 2; //EMPLOYEE TYPES CURSOR
 static final int EMPLOY_CUR 	= 3; //EMPLOYEE INFO CURSOR 
 static final int OBJECT_CUR    = 4; //CLIENT OBJECT CURSOR
 
 //CLIENT OBJECT CURSOR
 static final int COOBJID_COLUMN		= 1; //OBJECT ID COLUMN
 static final int COCUSTEID_COLUMN		= 2; //CUSTOMER EID
 static final int CUSTNAME_COLUMN		= 3; //CUSTOMER NAME
 static final int COOBJNAME_COLUMN		= 4; //OBJECT NAME
 static final int COOBJCODE_COLUMN		= 9; //OBJECT CODE 
 
 static final int EMPLYNM_COLUMN	= 1;
 static final int EDEXTID_COLUMN	= 2;
 static final int EDEMPLNUM_COLUMN	= 3;
 static final int EDEMPLFED_COLUMN	= 4;
 static final int EDEMPTYPID_COLUMN	= 5; 
 static final int EDPROFID_COLUMN	= 6;
 static final int EDBRTHDAY_COLUMN	= 7;
 static final int EDYEARS_COLUMN	= 8;
 static final int EDINTDATE_COLUMN	= 9;
 static final int EDENDDATE_COLUMN	= 10;
 static final int EDYEARSWRK_COLUMN	= 11;
 static final int EDAGINGYN_COLUMN	= 12;
 static final int EDEMPLSAL_COLUMN	= 13;
 static final int EDEMPLSEX_COLUMN	= 14;                             
 static final int EDBANK_COLUMN		= 15; 
 static final int EDACCNUM_COLUMN	= 16; 
 static final int EDMARSTATS_COLUMN	= 17; 
 static final int EDDRIVLNUM_COLUMN	= 18; 
 static final int EDDRIVLCAT_COLUMN	= 19; 
 static final int EDBLOODTYP_COLUMN	= 20;  
 static final int EDSALTYPE_COLUMN	= 21;  
 
 //FIELDS FOR ACUM INF
 static final int ACVACDAYTP_COLUMN	= 22;
 static final int ACVACAMTTP_COLUMN	= 23;
 static final int ACDECDAYTP_COLUMN	= 24;
 static final int ACDECAMTTP_COLUMN	= 25;
 static final int ACINCPROM_COLUMN	= 26;
 static final int ACINCMAX_COLUMN	= 27;                                              

 static final int EDOBJCTID_COLUMN	= 28;  
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_addSymbolJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_popcalendarJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/addSymbol.js"></SCRIPT>
<SCRIPT language="javascript" src="../../ERP_COMMON/js/popcalendar.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/employee.js"></SCRIPT>
<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 *******************************************************************************/

 String employeeId		= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String extId 			= request.getParameter("extId")==null?"":request.getParameter("extId"); //USE FOR SOCIAL SECURITY NUMBER
 String employeeNum		= request.getParameter("employeeNum")==null?"":request.getParameter("employeeNum");
 String federalId		= request.getParameter("federalId")==null?"":request.getParameter("federalId"); //USE FOR EMPLOYEE PERSONAL ID
 String employeeTypeId 	= request.getParameter("employeeTypeId")==null?"0":request.getParameter("employeeTypeId"); 
 String jobProfId		= request.getParameter("jobProfId")==null?"0":request.getParameter("jobProfId"); 
 String birthDate		= request.getParameter("birthDate")==null?"":request.getParameter("birthDate");
 String age				= request.getParameter("age")==null?"":request.getParameter("age");
 String intDate			= request.getParameter("intDate")==null?"":request.getParameter("intDate");
 String endDate			= request.getParameter("endDate")==null?"":request.getParameter("endDate"); 
 String ageWrks			= request.getParameter("ageWrks")==null?"":request.getParameter("ageWrks");  
 String gainsAging		= request.getParameter("gainsAging")==null?"N":request.getParameter("gainsAging");  
 String agingAmt		= request.getParameter("agingAmt")==null?"":request.getParameter("agingAmt");  
 String emplSal			= request.getParameter("emplSal")==null?"":request.getParameter("emplSal"); 
 String emplSex			= request.getParameter("emplSex")==null?"M":request.getParameter("emplSex");  
 
 String bank			= request.getParameter("bank")==null?"":request.getParameter("bank");  
 String accNum			= request.getParameter("accNum")==null?"":request.getParameter("accNum"); 
 
 String marSt			= request.getParameter("marSt")==null?"":request.getParameter("marSt");   
 String drivLNum		= request.getParameter("drivLNum")==null?"":request.getParameter("drivLNum");   
 String drivLCat		= request.getParameter("drivLCat")==null?"":request.getParameter("drivLCat");   
 String bloodTyp		= request.getParameter("bloodTyp")==null?"":request.getParameter("bloodTyp"); 

 String salType			= request.getParameter("salType")==null?"":request.getParameter("salType");    
 
 String contextRoot = request.getContextPath();

 String errMsg 	= null;
 String code 	= "";	
 String descr 	= ""; 
 
 String objectId		= request.getParameter("objectId")==null?"":request.getParameter("objectId");

 /*******************************************************************************
 * In case we are comming from the command page due some error, the addCommandDBBean
 * object already exists from that page. It must be create in request scope
 *******************************************************************************/
 if (returnWithError.equals("Y"))
 {
       errMsg = (String)request.getAttribute("ErrorMessage");
 }
 
  /*******************************************************************************
 * build the sqlString with the call to the SP
 *******************************************************************************/
 
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PREMPLSETS('" + 
 					companyID + "',0," + employeeId + ",'','','','',0,0,0,0,'',0,'','',0,0,'',0,0,0,'','','','','',0,0,'','','EMPLOYEDT','','','','','','','',0,'',0,?,?)}"; 
 					
 System.out.println("sqlString = " + sqlString);
%>
<jsp:useBean id="updateDBBean" class="com.cap.erp.SPDBBean" scope="page">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="updateDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="updateDBBean" />
</jsp:useBean>
<%
 updateDBBean.execute();
%>
<jsp:useBean id="errMsgHelper" class="com.cap.util.ErrorMessageHelper" scope="page">
<jsp:setProperty property="errorMessage" value="<%= errMsg%>" name="errMsgHelper" />
<jsp:setProperty property="contextPath" value="<%= contextRoot %>" name="errMsgHelper" />
</jsp:useBean>
<jsp:getProperty property="htmlErrorMessage" name="errMsgHelper" />
<%
BigDecimal vacDTP = new BigDecimal("0.00");
BigDecimal vacAMT = new BigDecimal("0.00");
BigDecimal decDTP = new BigDecimal("0.00");
BigDecimal decAMT = new BigDecimal("0.00");					
BigDecimal incPRO = new BigDecimal("0.00");
BigDecimal incMAX  = new BigDecimal("0.00");		

 if (returnWithError.equals("N"))
 { 
	 try
	 {

		employeeName 	= (String)updateDBBean.valueAtColumnRowResult(EMPLYNM_COLUMN,0,EMPLOY_CUR).toString().trim();
		extId 			= (String)updateDBBean.valueAtColumnRowResult(EDEXTID_COLUMN,0,EMPLOY_CUR).toString().trim();
		employeeNum		= (String)updateDBBean.valueAtColumnRowResult(EDEMPLNUM_COLUMN,0,EMPLOY_CUR).toString().trim();
		federalId		= (String)updateDBBean.valueAtColumnRowResult(EDEMPLFED_COLUMN,0,EMPLOY_CUR).toString().trim();

		employeeTypeId 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(EDEMPTYPID_COLUMN,0,EMPLOY_CUR)).toString().trim();
		jobProfId		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(EDPROFID_COLUMN,0,EMPLOY_CUR)).toString().trim();
  
		birthDate		= Format.date_Str(updateDBBean.valueAtColumnRowResult(EDBRTHDAY_COLUMN,0,EMPLOY_CUR).toString());
		age				= ((BigDecimal)updateDBBean.valueAtColumnRowResult(EDYEARS_COLUMN,0,EMPLOY_CUR)).toString().trim();
		intDate			= Format.date_Str(updateDBBean.valueAtColumnRowResult(EDINTDATE_COLUMN,0,EMPLOY_CUR).toString());
		endDate			= Format.date_Str(updateDBBean.valueAtColumnRowResult(EDENDDATE_COLUMN,0,EMPLOY_CUR).toString());
		if(endDate.equals("01/01/0001"))
			endDate = "";
		ageWrks			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(EDYEARSWRK_COLUMN,0,EMPLOY_CUR)).toString().trim();
		gainsAging		= (String)updateDBBean.valueAtColumnRowResult(EDAGINGYN_COLUMN,0,EMPLOY_CUR).toString().trim();
		emplSal			= Format.formatCurrency((BigDecimal)updateDBBean.valueAtColumnRowResult(EDEMPLSAL_COLUMN,0,EMPLOY_CUR)); 
		emplSex			= (String)updateDBBean.valueAtColumnRowResult(EDEMPLSEX_COLUMN,0,EMPLOY_CUR).toString().trim();
		
 		bank			= (String)updateDBBean.valueAtColumnRowResult(EDBANK_COLUMN,0,EMPLOY_CUR).toString().trim();
		accNum			= (String)updateDBBean.valueAtColumnRowResult(EDACCNUM_COLUMN,0,EMPLOY_CUR).toString().trim();
		
 		marSt			= (String)updateDBBean.valueAtColumnRowResult(EDMARSTATS_COLUMN,0,EMPLOY_CUR).toString().trim();   
 		drivLNum		= (String)updateDBBean.valueAtColumnRowResult(EDDRIVLNUM_COLUMN,0,EMPLOY_CUR).toString().trim();   
 		drivLCat		= (String)updateDBBean.valueAtColumnRowResult(EDDRIVLCAT_COLUMN,0,EMPLOY_CUR).toString().trim();   
 		bloodTyp		= (String)updateDBBean.valueAtColumnRowResult(EDBLOODTYP_COLUMN,0,EMPLOY_CUR).toString().trim(); 		
		salType			= (String)updateDBBean.valueAtColumnRowResult(EDSALTYPE_COLUMN,0,EMPLOY_CUR).toString().trim();
		
		vacDTP			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ACVACDAYTP_COLUMN,0,EMPLOY_CUR));
		vacAMT			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ACVACAMTTP_COLUMN,0,EMPLOY_CUR));
		decDTP			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ACDECDAYTP_COLUMN,0,EMPLOY_CUR));
		decAMT			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ACDECAMTTP_COLUMN,0,EMPLOY_CUR));					
		incPRO			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ACINCPROM_COLUMN,0,EMPLOY_CUR));
		incMAX			= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ACINCMAX_COLUMN,0,EMPLOY_CUR));	
		
		objectId		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(EDOBJCTID_COLUMN,0,EMPLOY_CUR)).toString();
		
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 }
 %>
<FORM method="post" name="myForm" onsubmit="return add_upd_empl(myForm);" action="<%=contextRoot%>/erp/payrollnic/employee/premplsets.jsp">
<INPUT type="hidden" name="action" id="action" value="EMPLOYUPD">
<INPUT type="hidden" name="cDate" id="cDate" value="<%=Format.getSysDate()%>">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">

<TABLE width="750" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="4" class="tableheader">Editar Empleado</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Empleado</TD>
      <TD colspan="3"><%=employeeName%>
		<INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
 		<INPUT type="hidden" name="employeeName" id="employeeName" value="<%=employeeName%>">
      </TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Numero de Empleado</TD>
      <TD><input type="text" name="employeeNum" size="20" maxlength="20" value="<%=employeeNum%>"></TD>
      <TD class="label"><SPAN class="textRed">*</SPAN>Numero de INSS</TD>
      <TD><input type="text" name="extId" size="20" maxlength="20" value="<%=extId%>"></TD>
    </TR>     
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Cedula #</TD>
      <TD><input type="text" name="federalId" size="20" maxlength="20" value="<%=federalId%>" onkeyup="formatCEDID(myForm.federalId)" onkeypress="formatCEDID(myForm.federalId)"></TD>
      <TD class="label"><SPAN class="textRed">*</SPAN>Tipo de Empleado</TD>
      <TD>
	            <SELECT size="1" name="employeeTypeId" class="text">
	            <OPTION value="" <%=employeeTypeId.length()==0?"selected": ""%>></OPTION>
<%
		int numOfEmplyTyp = updateDBBean.getRowsInResult(EMPLTYP_CUR);
		
   		for (int j = 0; j < numOfEmplyTyp; j++) { 
 			code 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,EMPLTYP_CUR)).toString();
			descr	= (String)updateDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,EMPLTYP_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=employeeTypeId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
      
      </TD>
    </TR>      
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Cargo</TD>
      <TD colspan="3">    
	            <SELECT size="1" name="jobProfId" class="text">
	            <OPTION value="" <%=jobProfId.length()==0?"selected": ""%>></OPTION>
<%
		int numOfJobPrfl = updateDBBean.getRowsInResult(JOBPRFL_CUR);
		
   		for (int j = 0; j < numOfJobPrfl; j++) { 
 			code 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,JOBPRFL_CUR)).toString();
			descr	= (String)updateDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL + 1,j,JOBPRFL_CUR) + "/" + (String)updateDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,JOBPRFL_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=jobProfId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
		</TD>
	</TR>   
    <TR class="pcrinfo">
      <TD class="label"><SPAN class="textRed">*</SPAN>Fecha de Nacimiento</TD>
      <TD>
       <INPUT size="12" maxlength="10" type="text" name="birthDate" class="pcrInfo" value="<%=birthDate%>" onblur = "calculate_years(this.value,myForm.age)" onKeyUp="addSlash(myForm.birthDate)" onChange="formatDate(myForm.birthDate);calculate_years(this.value,myForm.age)" onKeyPress="OnlyDigits();addSlash(myForm.birthDate)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.birthDate, 'mm/dd/yyyy', 350, -1);" alt="Calendar">            
      </TD>
      <TD class="label"><SPAN class="textRed">*</SPAN>Edad</TD>
      <TD><input type="text" name="age" size="2" maxlength="2" value="<%=age%>" readOnly></TD>
    </TR>     	 
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Fecha de Inicio</TD>
      <TD>
       <INPUT size="12" maxlength="10" type="text" name="intDate" class="pcrInfo" value="<%=intDate%>" onblur = "calculate_years(this.value,myForm.ageWrks)" onKeyUp="addSlash(myForm.intDate)" onChange="formatDate(myForm.intDate);calculate_years(this.value,myForm.ageWrks)" onKeyPress="OnlyDigits();addSlash(myForm.intDate)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.intDate, 'mm/dd/yyyy', 350, -1);" alt="Calendar">            
      </TD>    
      <TD class="label"><SPAN class="textRed">*</SPAN>Años de Servicio</TD>      
      <TD><input type="text" name="ageWrks" size="2" maxlength="2" value="<%=ageWrks%>" readOnly></TD>
    </TR>     	       
    <TR class="pcrinfo">
      <TD class="label">Fecha de Liquidacion</TD>
      <TD>
       <INPUT size="12" maxlength="10" type="text" name="endDate" class="pcrInfo" value="<%=endDate%>" onKeyUp="addSlash(myForm.endDate)" onChange="formatDate(myForm.endDate)" onKeyPress="OnlyDigits();addSlash(myForm.endDate)" onKeyDown="return checkArrows(this, event)">
       <IMG src="../../ERP_COMMON/images/popcalendar/calendar.gif" border="0" onclick="popUpCalendar(this, myForm.endDate, 'mm/dd/yyyy', 350, -1);" alt="Calendar">            
      </TD>    
      <TD class="label"><SPAN class="textRed">*</SPAN>Sexo</TD>      
      <TD class = "label">
      	<input type="radio" name="emplSex" value="M" <%=emplSex.equals("M")?"checked":""%>>M
      	<input type="radio" name="emplSex" value="F" <%=emplSex.equals("F")?"checked":""%>>F
      </TD>
    </TR>    
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Gana Antiguedad</TD>      
      <TD class = "label">
      	<input type="radio" name="gainsAging" value="N" <%=gainsAging.equals("N")?"checked":""%>>No
      	<input type="radio" name="gainsAging" value="Y" <%=gainsAging.equals("Y")?"checked":""%>>Si
      </TD>
      <TD class="label"><SPAN class="textRed">*</SPAN>Salario de Empleado</TD>
      <TD><input type="text" name="emplSal" size="20" maxlength="21" value="<%=emplSal%>"></TD>      
    </TR>       
    <TR class="pcrinfo">
      <TD class="label">Banco</TD>
      <TD><input type="text" name="bank" size="20" maxlength="50" value="<%=bank%>"></TD>    
      <TD class="label">Numero de Cuenta</TD>
      <TD><input type="text" name=accNum size="20" maxlength="50" value="<%=accNum%>"></TD>
    </TR> 
    <TR class="pcrinfo1">
      	<TD class="label">Estado Civil</TD>
    	<TD>  
			<SELECT size="1" name="marSt" class="text">
				<OPTION value=""   <%=marSt.equals("")?"selected":""%>></OPTION>
				<OPTION value="SN" <%=marSt.equals("SN")?"selected":""%>>Soltero</OPTION>
				<OPTION value="MR" <%=marSt.equals("MR")?"selected":""%>>Casado</OPTION>
				<OPTION value="FN" <%=marSt.equals("FN")?"selected":""%>>Union Libre</OPTION>
			</SELECT>             
		</TD>      
	    <TD class="label"># Licencia de Conducir</TD>
	    <TD><input type="text" name=drivLNum size="10" maxlength="10" value="<%=drivLNum%>"></TD>
    </TR>
    <TR class="pcrinfo">   
	    <TD class="label">Categorias</TD>
	    <TD><input type="text" name="drivLCat" size="5" maxlength="5" value="<%=drivLCat%>"></TD>

	    <TD class="label">Tipo de Sangre</TD>
	    <TD><input type="text" name="bloodTyp" size="3" maxlength="3" value="<%=bloodTyp%>"></TD>
    </TR>    
    <TR class="pcrinfo1">   
	    <TD class="label">Tipo de Salario</TD>
	    <TD>
			<SELECT size="1" name="salType" class="text">
				<OPTION value=""  <%=salType.equals("")?"selected":""%>></OPTION>
				<OPTION value="F" <%=salType.equals("F")?"selected":""%>>Fijo</OPTION>
				<OPTION value="V" <%=salType.equals("V")?"selected":""%>>Variable</OPTION>
			</SELECT> 	    
	    </TD>
	    <TD class="label">Objetivo</TD>
	    <TD>
        <SELECT size="1" name="objectId">
         <OPTION value="0">Seleccionar Objetivo</OPTION>	    
<%
String customerName    = "";
String preCustomerName = "";
int numOfRowsObj = updateDBBean.getRowsInResult(OBJECT_CUR);   	

   for (int j = 0; j < numOfRowsObj ; ) 
   { 
		try 
		{ 
			customerName = (String)(updateDBBean.valueAtColumnRowResult(CUSTNAME_COLUMN,j,OBJECT_CUR));
		 	if(!customerName.equals(preCustomerName) || j==0) 
      		{	
 %>
		<OPTION value="0" disabled="disabled"><%=customerName.trim()%></OPTION>       
<%
			}//END OF IF (!customerName.equals(preCustomerName) || i==0)
%>
		<OPTION value="<%=((BigDecimal)updateDBBean.valueAtColumnRowResult(COOBJID_COLUMN,j,OBJECT_CUR)).toString()%>" <%=objectId.equals(((BigDecimal)updateDBBean.valueAtColumnRowResult(COOBJID_COLUMN,j,OBJECT_CUR)).toString())?"selected":""%>>&nbsp;&nbsp;&nbsp;&nbsp;<%=(String)(updateDBBean.valueAtColumnRowResult(COOBJCODE_COLUMN,j,OBJECT_CUR)) + "-" + ((String)(updateDBBean.valueAtColumnRowResult(COOBJNAME_COLUMN,j,OBJECT_CUR))).toString().trim()%></OPTION>
<%
		preCustomerName = customerName;
		j++; 
		}//END OF TRY
		catch (java.lang.ArrayIndexOutOfBoundsException _e0) { break; }
		
	}//END OF FOR
 %>         
        </SELECT>		    
	    </TD>
    </TR>      
    <TR class="pcrinfo">   
	    <TD class="label">Acumulado de Vacaciones Dias</TD>
	    <TD><input type="text" name="" size="10" maxlength="10" value="<%=vacDTP%>" readOnly></TD>
	    <TD class="label">Acumulado de Vacaciones Monto</TD>
	    <TD><input type="text" name="" size="10" maxlength="10" value="<%=vacAMT%>" readOnly></TD>
    </TR>      
    <TR class="pcrinfo1">   
	    <TD class="label">Acumulado de Aguinaldo Dias</TD>
	    <TD><input type="text" name="" size="10" maxlength="10" value="<%=decDTP%>" readOnly></TD>
	    <TD class="label">Acumulado de Aguinaldo Monto</TD>
	    <TD><input type="text" name="" size="10" maxlength="10" value="<%=decAMT%>" readOnly></TD>
    </TR>          
    <TR class="pcrinfo">   
	    <TD class="label">Salario Promedio Ult. 6 Meses</TD>
	    <TD><input type="text" name="" size="10" maxlength="10" value="<%=incPRO%>" readOnly></TD>
	    <TD class="label">Salario Mas Alto Ult. 6 Meses</TD>
	    <TD><input type="text" name="" size="10" maxlength="10" value="<%=incMAX%>" readOnly></TD>
    </TR>          
<%
  updateDBBean.closeResultSet();
%>		
</TABLE>
<TABLE width="750">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/employee/employeelistactive.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
