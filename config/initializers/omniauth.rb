OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :dropbox, ENV['DROPBOX_KEY'], ENV['DROPBOX_SECRET']
end

existing_on_failure = OmniAuth.config.on_failure

OmniAuth.config.on_failure = Proc.new do |env|
  exception = env['omniauth.error']

  if exception
    if Rails.env.development?
      raise exception
    else
      existing_on_failure.call env
    end
  else
    existing_on_failure.call env
  end
end
