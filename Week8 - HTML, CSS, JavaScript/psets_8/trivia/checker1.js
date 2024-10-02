// Code to check the answers
document.addEventListener('DOMContentLoaded', function() {
    
    // WHEN CORRECT ANSWER -> GREEN
    let correct = document.querySelector('#correct');
    correct.addEventListener('click', function(event) {
        correct.style.backgroundColor = 'green';
        document.querySelector('#checker1').innerHTML = 'CORRECT!';
    });

    // WHEN INCORRECT ANSWER -> RED
    let incorrects = document.querySelectorAll('#incorrect');
    for (let i = 0; i < incorrects.length; i++) {
        incorrects[i].addEventListener('click', function(event) {
        incorrects[i].style.backgroundColor = 'red';
        document.querySelector('#checker1').innerHTML = 'INCORRECT';
        });
    }
});
