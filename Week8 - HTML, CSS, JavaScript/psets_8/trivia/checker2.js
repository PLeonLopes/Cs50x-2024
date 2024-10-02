// Code to check the answers
document.addEventListener('DOMContentLoaded', function() {

    document.querySelector('#input2').addEventListener('click', function(){
        let input = document.querySelector('input');
        if (input.value == 'Milky Way' || input.value == 'MILKY WAY' || input.value == 'milky way') {
            input.style.backgroundColor = 'green';
            document.querySelector('#checker2').innerHTML = 'CORRECT!';
        } else {
            input.style.backgroundColor = 'red';
            document.querySelector('#checker2').innerHTML = 'INCORRECT';
        }
     });
});
