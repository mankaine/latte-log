if Rails.env.test?
  ENV['CLOUDINARY_URL'] = 'cloudinary://645449441246574:_9l6Nv0aPtypQx1LSgITbtH0ZZ4@hou6ji06l'
end

if Rails.env.development?
  ENV['CLOUDINARY_URL'] = 'cloudinary://645449441246574:_9l6Nv0aPtypQx1LSgITbtH0ZZ4@hou6ji06l'
end