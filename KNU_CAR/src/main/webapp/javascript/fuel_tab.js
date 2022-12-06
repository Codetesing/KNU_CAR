function change_btn(e) {
    var un_btns = document.querySelectorAll(".fuel_unselected_input_form");
    var se_btn = document.querySelector(".fuel_selected_input_form");

    se_btn.className = "fuel_unselected_input_form";
    
    un_btns.forEach(function (btn, i) {
      if (e.currentTarget == btn) {
        btn.className = "fuel_selected_input_form";
        fuel.value = btn.value;
      }
    });
  }