# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_project02_session',
  :secret      => '046211e64c1683ef6018406d988ad30ba6a2a054ea5457bd72e8b9327394225208b0af79f8d531ff6577c2778d97f15c571e5795a3b9bf2cd54ca21ba4b6408d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
