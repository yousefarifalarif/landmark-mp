import flatpickr from 'flatpickr';

// get price of current item
const pricePerDay = parseFloat(document.querySelector(".price-per-day").dataset.pricePerDay);
const priceInput = document.getElementById("booking_total_price");
const totalPrice = document.getElementById("price");
priceInput.hidden = true;

const toggleDateInputs = function () {
  const startDateInput = document.getElementById('booking_start_date');
  const endDateInput = document.getElementById('booking_end_date');


  if (startDateInput && endDateInput) {
    const unavailableDates = JSON.parse(document.querySelector('.widget-content').dataset.unavailable)

    flatpickr(startDateInput, {
      minDate: 'today',
      dateFormat: 'Y-m-d',
      disable: unavailableDates,
      onChange: function (selectedDates, selectedDate) {
        if (selectedDate === '') {
          endDateInput.disabled = true;
        }
        let minDate = selectedDates[0];
        minDate.setDate(minDate.getDate());
        endDateCalendar.set('minDate', minDate);
        endDateInput.disabled = false;
      }
    });
    const endDateCalendar =
      flatpickr(endDateInput, {
        dateFormat: 'Y-m-d',
        disable: unavailableDates,
        onChange: function (_, selectedDate) {
          if (selectedDate === '') {
          } else {
            const diff = Date.parse(endDateInput.value) - Date.parse(startDateInput.value)
            const numOfDays = diff / 1000 / 60 / 60 / 24 + 1

            const newPrice = pricePerDay * numOfDays;
            totalPrice.innerHTML = `£ ${newPrice}`;
            // Update the value of the read - only input
            priceInput.value = newPrice;
          }
        },
      });
  }
};

export { toggleDateInputs }
