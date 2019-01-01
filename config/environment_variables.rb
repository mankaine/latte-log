# DO NOT UPLOAD THIS FILE TO GIT.
if Rails.env.test?
  ENV['GOOGLE_AUTH_CLIENT_ID'] =
  '1007130517054-m7srq21spv5vm9nijvs57v76bn5s90jp.apps.googleusercontent.com'
  ENV['GOOGLE_AUTH_CLIENT_SECRET'] = 'YgVxXfda2rv54JnMG8Z-7HAP'
  ENV['REDIS_URL'] = 'redis://localhost:6379/'
end

if Rails.env.development?
  ENV['GOOGLE_AUTH_CLIENT_ID'] =
  '1007130517054-m7srq21spv5vm9nijvs57v76bn5s90jp.apps.googleusercontent.com'
  ENV['GOOGLE_AUTH_CLIENT_SECRET'] = 'YgVxXfda2rv54JnMG8Z-7HAP'
  ENV['REDIS_URL'] = 'redis://localhost:6379/'
end

