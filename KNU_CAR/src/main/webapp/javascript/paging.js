function next_page(e) {
	document.getElementById('next_page_num').value =  e.currentTarget.value;
	console.log("aaaaaaaaaaaaaaaaaaa");
	document.getElementById('paging').submit();
}