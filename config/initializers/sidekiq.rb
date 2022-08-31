require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV.fetch('SIDEKIQ_USER', 'admin'),
                       ENV.fetch('SIDEKIQ_PASSWORD', 'secret')]
end
