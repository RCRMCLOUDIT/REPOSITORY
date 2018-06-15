/*******************************************************/
function openSEmployeesDialog(f_name, value_a, label_a, payrollId, contextPath, value_b)
{
	//use System time, make sure page get refreshed
	var cDate = new Date();

  	winModalWindowUrl = 
  		contextPath + "/erp/payrollnic/employee/searchemployees.jsp?search=" + URLEncode(window.document.getElementById(label_a).value) + 
		"&f_name=" + f_name + 
		"&v_id=" + value_a + 
		"&v_name=" + label_a +
		"&v_sal=" + value_b + 
		"&payrollId=" + payrollId;
  	
 //alert(winModalWindowUrl);
  var modalIframe = contextPath + "/erp/ERP_COMMON/dropBox.htm";

  if(contextPath) 

  if (window.showModalDialog)  {
    window.showModalDialog(modalIframe,window, "dialogWidth=750px;dialogHeight=350px;help:no;status:no;scroll:no")    
  } else {
    window.top.captureEvents (Event.CLICK|Event.FOCUS)
    window.top.onclick=IgnoreEvents
    window.top.onfocus=HandleFocus 
    winModalWindow = window.open (modalIframe, "", "dependent=yes,width=750,height=350")
    winModalWindow.focus()
  }
}