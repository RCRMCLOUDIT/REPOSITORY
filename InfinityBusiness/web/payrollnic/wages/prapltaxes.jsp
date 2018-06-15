<%@ page buffer="64kb" autoFlush="true" import="java.math.*,com.cap.util.*" errorPage="../../ERP_COMMON/error.jsp" %>
<%@ include file="../../ERP_COMMON/session.jspf" %>
<%
 /*******************************************************************************
 * We receive all the parameters for the SP
 *******************************************************************************/
 String Id	 		= request.getParameter("Id")==null?"":request.getParameter("Id");
 String firstTime	= request.getParameter("firstTime")==null?"Y":request.getParameter("firstTime");
 String wageName	= request.getParameter("wageName")==null?"":request.getParameter("wageName"); 
 String action = "";

 String buff = "";
 String buff2 = "";
            
			if (firstTime.equals("Y"))
			{
				action 		= "APTAXADD";
				int count 	= Integer.parseInt(request.getParameter("count"));
				
				String pkapTaxid 		= "";
				String pkSeleccionado 	= "";
				
				for (int i = 0; i < count; i++)
				{
					pkapTaxid 		= request.getParameter("apTaxid" + i);
					pkSeleccionado 	= request.getParameter("seleccionado" + i);

					if (pkapTaxid != null)
					{
						if (pkSeleccionado.equals("true"))
							buff = buff + pkapTaxid + ConstantValue.DELIMITER;
					}
				}//End For
			}//End If
			else if(firstTime.equals("N"))
			{
				action 		= "APTAXUPD";
				int count 	= Integer.parseInt(request.getParameter("count"));
				
				String pkapTaxid 		= "";
				String pkSeleccionado	= "";
				
				for (int i = 0; i < count; i++)
				{
					pkapTaxid = request.getParameter("apTaxid" + i);
					pkSeleccionado = request.getParameter("seleccionado" + i);

					if (pkapTaxid != null)
					{
						if (pkSeleccionado.equals("true"))
							buff = buff + pkapTaxid + ConstantValue.DELIMITER;
						else
							buff2= buff2+ pkapTaxid + ConstantValue.DELIMITER;
					}
				}//End For				
			}
 
 String contextRoot = request.getParameter("contextRoot");
  
 String who = user_ID;
 String ip	= Format.getIPAddress(request).trim(); 
 	
 /*******************************************************************************
 * build the callString with the call to the SP
 *******************************************************************************/
 String sqlString = "{CALL "+ DBLibConstants.UPLIB + "_OBJ.PRAPLTAXES('" + 
 					companyID + "'," +
 					companyEID + "," + 
 					Id +",'" +
 					buff + "','" +
 					buff2 + "','" +
 					who + "','" +
 					ip +  "','" +
 					action + "',?,?)}";
 					
 System.out.println("sqlString = " + sqlString); 
%>
<jsp:useBean id="prapltaxesDBBean" class="com.cap.erp.SPDBBean" scope="request">
<jsp:setProperty property="dataSourceName" value="<%=DBLibConstants.DATASOURCE%>" name="prapltaxesDBBean" />
<jsp:setProperty property="SQLString" value="<%=sqlString%>" name="prapltaxesDBBean" />
</jsp:useBean>
<%
 prapltaxesDBBean.closeResultSet();
 prapltaxesDBBean.execute();
 prapltaxesDBBean.closeResultSet();
 
 String flag   = prapltaxesDBBean.getErrorFlag();
 String errMsg = prapltaxesDBBean.getErrorMessage();
 
System.out.println("Flag :" + flag);
System.out.println("ErrMsg :" + errMsg);
 
 if(flag.equals("S")){
    //call list page
    response.sendRedirect(request.getContextPath() + "/erp/payrollnic/wages/apltaxes.jsp?Id=" + Id + "&wageName=" + wageName);
 }
 else if(flag.equals("F"))
 {
	request.setAttribute("ErrorMessage", errMsg);
	request.setAttribute("returnWithError","Y");   
 %>
 <jsp:forward page="wagelist.jsp"/>
<%
 } 
%>