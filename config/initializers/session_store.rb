Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 1.day

# Rails.application.config.session_store :cookie_store, key: '_infra-test-app_session'
