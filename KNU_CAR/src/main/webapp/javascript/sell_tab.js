function select_normal() {
    var normal = document.getElementById('normal');
    var special = document.getElementById('special');
    var type = document.getElementById('car_type');

    normal.className = 'submit_tab_selected_form';
    special.className = 'submit_tab_unselected_form';
    type.value = 'normal';
}

function select_special() {
    var normal = document.getElementById('normal');
    var special = document.getElementById('special');
    var type = document.getElementById('car_type');

    normal.className = 'submit_tab_unselected_form';
    special.className = 'submit_tab_selected_form';
    type.value = 'special';
}