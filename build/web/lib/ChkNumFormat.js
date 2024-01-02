function chkNum(input) {
	s = input.value;
	filteredValues = "1234567890";     // Characters stripped out
//	filteredValues = "~!@#$%^&*()_-=+.<>\\?|/";     // Characters stripped out
	var i;
	var returnString = "";
	for (i = 0; i < s.length; i++) {  // Search through string and append to unfiltered values to returnString.
	var c = s.charAt(i);
		if (filteredValues.indexOf(c) != -1) 
			returnString += c;
		else
			{
				alert('ป้อนได้เฉพาะตัวเลขเท่านั้น');
				returnString = "";
				input.value = returnString;
				input.focus();
				return false;
			}
	}
	input.value = returnString;
	return true;
}

function chkNumPointFive(input) {
	s = input.value;
	filteredValues = "1234567890.";     // Characters stripped out
//	filteredValues = "~!@#$%^&*()_-=+.<>\\?|/";     // Characters stripped out
	var i;
	var returnString = "";
	for (i = 0; i < s.length; i++) {  // Search through string and append to unfiltered values to returnString.
	var c = s.charAt(i);
		if (filteredValues.indexOf(c) != -1) {
			returnString += c;
		}
		else
			{
				alert('ป้อนได้เฉพาะตัวเลขเท่านั้น');
				returnString = "";
				input.value = returnString;
				input.focus();
				return false;
			}
	}
	input.value = returnString;
	return true;
}