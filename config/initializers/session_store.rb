# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_siitcollab_session',
  :secret      => '39130f810be7f03eebb0bd8140631eeccdaa0d385da06f6a8093a3e8d476db0e8c56d8eb157224af3c37a4aba4a4ed783f1e3a994a7d5865ceeaf4dd714c14e0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
