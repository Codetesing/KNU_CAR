function next_page(e) {
	document.getElementById('next_page_num').value =  e.currentTarget.value;
	document.getElementById('paging').submit();
}

function detail_info(e) {
	document.getElementById(e.currentTarget.id).submit();
}