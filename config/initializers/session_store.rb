# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_x5er_session',
  :secret      => 'e12488530a3e32900d6f4bdd565f6e01d42220e5895cde89a26f5d3d10f00b173be545cd92885e4701f5bd2fa55c8340812e32365de43581588c9d9b2442847c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
