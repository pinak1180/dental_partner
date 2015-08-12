APNS.port = ENV['APNS_PORT']
APNS.pem  = ENV['APNS_PEM']
APNS.host = ENV['APNS_HOST']
APNS.pass = '123456'


GCM.host = Rails.application.secrets.GCM_HOST
GCM.format = Rails.application.secrets.GCM_FORMAT
GCM.key = Rails.application.secrets.GCM_KEY
