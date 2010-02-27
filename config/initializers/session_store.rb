# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_inventory_session',
  :secret      => 'e2383b9251c5a032aa02038f839aa10fdf82871028f639080c9de397593c4727f5e07698124e5d9ea01a28a3a5fadeca21f78219348138502cd8c4d452ef7d10'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
