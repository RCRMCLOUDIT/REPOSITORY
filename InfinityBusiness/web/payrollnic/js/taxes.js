/*****************************************************
 Function to Enable/Disable Fields Calculate Base On
 *****************************************************/
function check_cal_base_on(form)
{
		if(form.calBSON.options[form.calBSON.selectedIndex].value == "PR")
		{
			form.compRT.disabled = false;
			form.emplRT.disabled = false;
			form.compAM.disabled = true;
			form.emplAM.disabled = true;
		}
		else if(form.calBSON.options[form.calBSON.selectedIndex].value == "AM")
		{
			form.compRT.disabled = true;
			form.emplRT.disabled = true;
			form.compAM.disabled = false;
			form.emplAM.disabled = false;
		}
		else
		{
			form.compRT.disabled = true;
			form.emplRT.disabled = true;
			form.compAM.disabled = true;
			form.emplAM.disabled = true;
		}
		return;		
}
