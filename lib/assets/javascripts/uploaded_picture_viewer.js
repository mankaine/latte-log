const onImageUpload = (input) => {
  let preview = $('.preview')
  if (preview.firstChild) {
    preview.removeChild(preview.firstChild)
  }

  let fileReader = new FileReader()
  fileReader.onload = (event) => {
    if ($('.preview > img').length == 0) {
      $('.preview').append('<img>')
    }
    $('.preview > img').attr('src', event.target.result).width(150).height(200)
  }
  fileReader.readAsDataURL(input.files[0]);
}
