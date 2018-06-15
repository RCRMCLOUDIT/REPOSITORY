<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM WebSphere Page Designer V4.0 for Windows">
<META http-equiv="Content-Style-Type" content="text/css">
<TITLE>Editar Cargo</TITLE>
<link rel="stylesheet" href="../../ERP_COMMON/Master.css" type="text/css">
</HEAD> 
<BODY onload="javascript: document.myForm.name.focus()">
<%@ page errorPage="../../ERP_COMMON/error.jsp" import="com.cap.util.*,java.math.*" %>
<%! 
 static final String title = "Editar Cargo"; 
 
 static final int COMPSCT_CUR 	= 1; 
 static final int JOBPROF_CUR 	= 2;
 
 static final int NM_COLUMN		= 1; //DESCRIPTION COLUMN
 static final int EP_COLUMN		= 2; //EMPLOYEE NAME(BOSS) COLUMN
 static final int SL_COLUMN		= 3; //SALARY COLUMN
 static final int CS_COLUMN		= 4; //SECTION ID COLUMN 
 static final int BS_COLUMN		= 5; //BOSS ID COLUMN
 static final int LV_COLUMN		= 6; //LEVEL PROFILE
 static final int CD_COLUMN		= 7; //SIES CODE
 static final int PT_COLUMN		= 8; //PROFILE TYPE  
%>
<%@ include file="../../ERP_COMMON/header.jspf" %>
<%@ include file="../../ERP_COMMON/a_utilJsMsg.jspf" %>
<%@ include file="../../ERP_COMMON/a_dialogBoxJsMsg.jspf" %>

<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/util.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../ERP_COMMON/js/dialogBox.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../js/jobprofile.js"></SCRIPT>
<SCRIPT>
function job_profile_upd(form)
{
	//alert(document.myForm.employeeId.value);
	return true;
}
</SCRIPT>
<%
 /* Variables we need to take from request object in case of error*/
 String returnWithError= request.getAttribute("returnWithError")==null?"N":"Y";

 /*******************************************************************************
 * Parameters for the SP
 *******************************************************************************/

 String name 			= request.getParameter("name")==null?"":request.getParameter("name");
 String Id	 			= request.getParameter("Id")==null?"":request.getParameter("Id");
 String employeeId		= request.getParameter("employeeId")==null?"":request.getParameter("employeeId");
 String employeeName 	= request.getParameter("employeeName")==null?"":request.getParameter("employeeName");
 String salary		 	= request.getParameter("salary")==null?"":request.getParameter("salary"); 
 String sctId		 	= request.getParameter("sctId")==null?"":request.getParameter("sctId"); 
 
 String level		 	= request.getParameter("level")==null?"":request.getParameter("level");
 String codeSies	 	= request.getParameter("codeSies")==null?"":request.getParameter("codeSies");
 String prfType		 	= request.getParameter("prfType")==null?"":request.getParameter("prfType");
 
 String contextRoot = request.getContextPath();

 String errMsg 	= null;
 String code 	= "";	
 String descr 	= ""; 

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
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRJOBPROFS('" + 
 					companyID + "',0," + Id + ",'',0,0,0,0,0,'','','','','JOBPRFEDT',?,?)}"; 
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
 if (returnWithError.equals("N"))
 { 
	 try
	 {
		name 			= (String)updateDBBean.valueAtColumnRowResult(NM_COLUMN,0,JOBPROF_CUR).toString().trim(); 
		employeeId		= ((BigDecimal)updateDBBean.valueAtColumnRowResult(BS_COLUMN,0,JOBPROF_CUR)).toString().trim(); 
		employeeName 	= (String)updateDBBean.valueAtColumnRowResult(EP_COLUMN,0,JOBPROF_CUR).toString().trim();
		salary		 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(SL_COLUMN,0,JOBPROF_CUR)).toString().trim(); 
		sctId		 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(CS_COLUMN,0,JOBPROF_CUR)).toString().trim(); 
		level		 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(LV_COLUMN,0,JOBPROF_CUR)).toString().trim();
		codeSies 		= (String)updateDBBean.valueAtColumnRowResult(CD_COLUMN,0,JOBPROF_CUR).toString().trim();	
		prfType		 	= (String)updateDBBean.valueAtColumnRowResult(PT_COLUMN,0,JOBPROF_CUR).toString().trim();
		
		if(level.equals(""))
			level = "1";	
	 } catch (java.lang.ArrayIndexOutOfBoundsException e){  }
 }
%>
<FORM method="post" name="myForm" action="<%=contextRoot%>/erp/payrollnic/confgeneral/prjobprofs.jsp" onsubmit="return job_profile_upd(myForm);">
<INPUT type="hidden" name="action" id="action" value="JOBPRFUPD">
<INPUT type="hidden" name="Id" id="Id" value="<%=Id%>">
<INPUT type="hidden" name="returnEid" id="returnEid" value="Y">
<INPUT type="hidden" name="contextRoot" id="contextRoot" value="<%=contextRoot%>">

<TABLE width="750" cellpadding="1" cellspacing="1" class="Border">
    <TR>
      <TD colspan="2" class="tableheader">Editar Cargo</TD>
    </TR>
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Descripción</TD>
      <TD width="75%"><input type="text" name="name" size="50" maxlength="50" value="<%=name%>"></TD>
    </TR>
    <TR class="pcrinfo1">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Jefe Inmediato</TD>
      <TD width="75%">
		<INPUT type="hidden" name="employeeId" id="employeeId" value="<%=employeeId%>">
 		<INPUT type="text" class="text"	size="20" maxlength="40" name="employeeName" id="employeeName" value="<%=employeeName%>" onchange="this.form.employeeId.value='';" onkeypress='if(isEnterPressed()) receipt_search(myForm, "EMP","<%=contextRoot%>");'>
		<INPUT type="button" class="hidden-btn" name="searchEmp" value=" v " onclick='receipt_search(myForm,"EMP","<%= contextRoot %>");'>      
      </TD>
    </TR>    
    <TR class="pcrinfo">
      <TD class="label" width="25%"><SPAN class="textRed">*</SPAN>Salario de Cargo</TD>
      <TD width="75%"><input type="text" name="salary" size="21" maxlength="21" value="<%=salary%>"></TD>
    </TR>     
    <TR class="pcrinfo1">
      <TD class="label"><SPAN class="textRed">*</SPAN>Gerencia-Departamento</TD>
      <TD width="75%">    
	            <SELECT size="1" name="sctId" class="text">
	            <OPTION value="" <%=sctId.length()==0?"selected": ""%>></OPTION>
<%
		int numOfSect = updateDBBean.getRowsInResult(COMPSCT_CUR);
		
   		for (int j = 0; j < numOfSect; j++) { 
 			code 	= ((BigDecimal)updateDBBean.valueAtColumnRowResult(ConstantValue.CODE_COL,j,COMPSCT_CUR)).toString();
			descr	= (String)updateDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL + 1,j,COMPSCT_CUR) + "/" + (String)updateDBBean.valueAtColumnRowResult(ConstantValue.DESC_COL,j,COMPSCT_CUR);
%>	            
	              <OPTION value="<%=code%>" <%=sctId.equals(code)?"selected":""%>><%=descr%></OPTION>
<% 		} %>
	            </SELECT>             
		</TD>
	</TR>    
    <TR class="pcrinfo">
      <TD class="label" width="40%"><SPAN class="textRed">*</SPAN>Nivel - Codigo SIES</TD>
      <TD width="60%">
        <SELECT size="1" name="level" class="text">
            <OPTION value="1" <%=level.equals("1")?"selected": ""%>>1</OPTION>
			<OPTION value="2" <%=level.equals("2")?"selected": ""%>>2</OPTION>
			<OPTION value="3" <%=level.equals("3")?"selected": ""%>>3</OPTION>
			<OPTION value="4" <%=level.equals("4")?"selected": ""%>>4</OPTION>
			<OPTION value="5" <%=level.equals("5")?"selected": ""%>>5</OPTION>
			<OPTION value="6" <%=level.equals("6")?"selected": ""%>>6</OPTION>
			<OPTION value="7" <%=level.equals("7")?"selected": ""%>>7</OPTION>
			<OPTION value="8" <%=level.equals("8")?"selected": ""%>>8</OPTION>
			<OPTION value="9" <%=level.equals("9")?"selected": ""%>>9</OPTION>
			<OPTION value="10" <%=level.equals("10")?"selected": ""%>>10</OPTION>
			<OPTION value="11" <%=level.equals("11")?"selected": ""%>>11</OPTION>
			<OPTION value="12" <%=level.equals("12")?"selected": ""%>>12</OPTION>
			<OPTION value="13" <%=level.equals("13")?"selected": ""%>>13</OPTION>			
         </SELECT>   
		<input type="text" name="codeSies" size="6" maxlength="10" value="<%=codeSies%>">      	
      </TD>
    </TR>  
    <TR class="pcrinfo1">
      <TD class="label" width="40%"><SPAN class="textRed">*</SPAN>Tipo de Salario</TD>
      <TD width="60%">
        <SELECT size="1" name="prfType" class="text">
            <OPTION value="SM" <%=prfType.equals("SM")?"selected": ""%>>Salario Minimo</OPTION>
			<OPTION value="SMG" <%=prfType.equals("SMG")?"selected": ""%>>Salario Minimo Guardas</OPTION>
			<OPTION value="SMR" <%=prfType.equals("SMR")?"selected": ""%>>Salario Minimo Relacionado</OPTION>
			<OPTION value="NSMR" <%=prfType.equals("NSMR")?"selected": ""%>>No Salario Minimo Relacionado</OPTION>
         </SELECT>   
     	
      </TD>
    </TR>     	       	
<%
  updateDBBean.closeResultSet();
%>		
</TABLE>
<TABLE width="600">
<TR>
<TD height="30" align="center">
<INPUT type="submit" name="Save" value="<%=rb.getString("B00008")%>" class="button">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="reset" class="button" name="Reset" value="<%=rb.getString("B00009")%>">&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="button" name="Cancel" value="<%=rb.getString("B00010")%>" class="button" onclick="window.location = '<%=contextRoot%>/erp/payrollnic/confgeneral/jobprofilelist.jsp';">
</TD>
</TR>
</TABLE>
</FORM>
<%@ include file="../../ERP_COMMON/footer.jspf" %>
</BODY>
</HTML>
