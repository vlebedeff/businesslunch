Rails.application.config.secret_token = 'x' * 30 || ENV['SECRET_KEY_BASE']
Rails.application.config.secret_key_base = 'x' * 30 || ENV['SECRET_KEY_BASE']
