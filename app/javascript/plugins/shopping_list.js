// Create a "close" button and append it to each list item
function toggleButton(inputs, inputsChecked, finishButton) {
    // if (inputs.length === inputsChecked.length) {
    //   finishButton.classList.remove('d-none');
    // }
    // else if (inputs.length !== inputsChecked.length) {
    //   finishButton.classList.add('d-none');
    // }
}

const shoppingList = () => {
  const listButton = document.querySelector('#list-finish');
const inputs = document.querySelectorAll('.ingredient-input');
let inputsChecked = document.querySelectorAll('.ingredient-input:checked');
inputs.forEach(function(input){
  input.addEventListener("click", () => {
    inputsChecked = document.querySelectorAll('.ingredient-input:checked');
    const label = input.parentNode.querySelector('.ingredient-label');
    const data = input.parentNode.parentNode.parentNode.parentNode;
    const id = data.dataset.id;
    const form = data.querySelector('form');
    const button = form.querySelector('.ingredient-button');
    label.classList.toggle('ingredient-check');
    button.click();
    toggleButton(inputs, inputsChecked, listButton);
  });
});
 toggleButton(inputs, inputsChecked, listButton);
}
export {shoppingList, toggleButton};
