function search() {
	$('#page').val(1);
	$('#logForm').submit();
}

function searchSort(type, direction) {
	$('#sortType').val(type);
	$('#sortDirection').val(direction);

	search();
}
