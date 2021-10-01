function search() {
	$('#page').val(1);
	$('#searchTrnasForm').submit();
}

function searchSort(type, direction) {
	$('#sortType').val(type);
	$('#sortDirection').val(direction);

	search();
}


