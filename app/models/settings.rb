class Settings < Settingslogic
  source "#{Rails.root}/config/client_secrets.yml"
  namespace Rails.env
end
