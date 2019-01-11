$(document).ready(function() {
  // Many thanks to Abhishek Agrawal: http://jsfiddle.net/user/abhiagrawal87/fiddles/
  const BULLET = '• '
  inputElem = $('.free-text-entry-form')
  inputElem.focus(function() {
    console.log(this)
    if (this.value == '') {
      this.value += BULLET
    }
  })

  inputElem.keyup(function(event) {
    let keyCode = event.keyCode ? event.keyCode : event.which
    const ENTER_KEY_CODE = '13'
    if (keyCode == ENTER_KEY_CODE) {
      this.value += BULLET
    }
  })
})
