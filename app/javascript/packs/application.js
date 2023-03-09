// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// require("channels/shopping_list")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import {shoppingList, toggleButton} from '../plugins/shopping_list'
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  if (window.location.pathname.includes("shopping_list")) {
    shoppingList();
  }

  // Call your functions here, e.g:
  // initSelect2();
  $('#range').on("input", function() {
    $('.output').val(this.value +"€" );
    }).trigger("change");
  
    const dailist = document.querySelectorAll(".dayli-list");
    dailist.forEach(list => {
      list.addEventListener("click", event => {
      console.log("coucou")
      list.classList.toggle("active");
      })
    })

// Need to stay the last script !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Write your code up stair
  $(function() {
    $('.pop-up').hide();
    $('.pop-up').fadeIn(1000);

        $('.close-button').click(function (e) {

        $('.pop-up').fadeOut(700);
        $('#overlay').removeClass('blur-in');
        $('#overlay').addClass('blur-out');
        e.stopPropagation();

      });
    });
});
