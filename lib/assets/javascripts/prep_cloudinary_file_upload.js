$(document).on('turbolinks:load', () => {
  $(() => {
    if($.fn.cloudinary_fileupload !== undefined) {
      const fileUploadInput = 'input.cloudinary-fileupload[type=file]'
      $(fileUploadInput).cloudinary_fileupload()
    }
  })
})
