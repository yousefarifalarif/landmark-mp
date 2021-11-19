// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import { toggleDateInputs } from '../components/booking';
import { initStarRating } from '../plugins/init_star_rating';
import AOS from 'aos';
import 'aos/dist/aos.css';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
import "bootstrap"

document.addEventListener('turbolinks:load', ()=> {
  if (document.getElementById("booking_total_price")) {
    console.log("found price input!")
    toggleDateInputs();
  }
  initStarRating();

  AOS.init({ once: true });
});
