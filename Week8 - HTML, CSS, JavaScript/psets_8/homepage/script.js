function blink() {
    let titleText = document.querySelector('.title-text');
    if (titleText.style.visibility === 'hidden') {
        titleText.style.visibility = 'visible';
    } else {
        titleText.style.visibility = 'hidden';
    }
  }
  // Blink every 500ms
  window.setInterval(blink, 500);
