$(document).on('turbolinks:load', function() {
  $(function() {
    if($.fn.cloudinary_fileupload !== undefined) {
      const fileUploadInput = 'input.cloudinary-fileupload[type=file]'
      $(fileUploadInput).cloudinary_fileupload()
    }
  })
})
