function search() {
    $('#logForm').submit();
}

function searchSort(type, direction) {
    $('#sortType').val(type);
    $('#sortDirection').val(direction);

    search();
}