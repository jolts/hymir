# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hymir_session',
  :secret      => '419242ab4cc09c4e29d25a37dc59b283026666d8cc531b78578af0adfe8af381063e269c3cd8d90593ca6f7e0aa028fb03451d454d3779a55e523f30882d2d52'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
