function onImageUpload(input) {
  let preview = $('div.preview')
  if (preview.firstChild) {
    preview.removeChild(preview.firstChild)
  }

  $('div.preview').on('change', 'img', function() {
    console.log('change')
  })

  fileReader = buildFileReader()
  fileReader.readAsDataURL(input.files[0])
}

function buildFileReader() {
  let fileReader = new FileReader()
  fileReader.onload = function(event) {
    if ($('div.preview > img').length == 0) {
      $('div.preview').append('<img>')
    }
    let imageQuery = $('div.preview > img')
    let h = 350
    let w = h * 3 / 4
    imageQuery.attr('src', event.target.result).height(w).width(h)
    rotateImage(imageQuery)
  }
  return fileReader
}

function rotateImage(imageQuery) {
  image = imageQuery[0]
  EXIF.getData(image, function() {
    let orientation = EXIF.getTag(this, 'Orientation')
    switch(orientation) {
      case 2:
        imageQuery.addClass('flip')
        break
      case 3:
        imageQuery.addClass('rotate-180')
        break
      case 4:
        imageQuery.addClass('flip-and-rotate-180')
        break
      case 5:
        imageQuery.addClass('flip-and-rotate-270')
        break
      case 6:
        imageQuery.addClass('rotate-90')
        break
      case 7:
        imageQuery.addClass('flip-and-rotate-90')
        break
      case 8:
        imageQuery.addClass('rotate-270')
        break
    }
  })
}