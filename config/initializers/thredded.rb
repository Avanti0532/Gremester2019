# frozen_string_literal: true

# Thredded configuration

# ==> User Configuration
# The name of the class your app uses for your users.
# By default the engine will use 'User' but if you have another name
# for your user class - change it here.
Thredded.user_class = 'Student'

# User name column, used in @mention syntax and *must* be unique.
# This is the column used to search for users' names if/when someone is @ mentioned.
Thredded.user_name_column = :username

# The path (or URL) you will use to link to your users' profiles.
# When linking to a user, Thredded will use this lambda to spit out
# the path or url to your user. This lambda is evaluated in the view context.
# If the lambda returns nil, a span element is returned instead of a link; so
# setting this to always return nil effectively disables all user links.
Thredded.user_path = ->(user) {
  nil
}

# This method is used by Thredded controllers and views to fetch the currently signed-in user
Thredded.current_user_method = :"current_#{Thredded.user_class_name.demodulize.underscore}"

# User avatar URL. rb-gravatar gem is used by default:
Thredded.avatar_url = ->(user) { Gravatar.src(user.email, 156, 'mm') }

# ==> Permissions Configuration
# By default, thredded uses a simple permission model, where all the users can post to all message boards,
# and admins and moderators are determined by a flag on the users table.

# The name of the moderator flag column on the users table.
Thredded.moderator_column = :moderator
# The name of the admin flag column on the users table.
Thredded.admin_column = :moderator

# Whether posts and topics pending moderation are visible to regular users.
Thredded.content_visible_while_pending_moderation = true

# ==> UI configuration

# How to calculate the position of messageboards in a list:
# :position            (default) set the position manually (new messageboards go to the bottom, by creation timestamp)
# :last_post_at_desc   most recent post first
# :topics_count_desc   most topics first
Thredded.messageboards_order = :last_post_at_desc

# Whether users that are following a topic are listed on the topic page.
Thredded.show_topic_followers = false

# Whether the list of users who are currently online is displayed.
Thredded.currently_online_enabled = false

# Whether private messaging functionality is enabled.
Thredded.private_messaging_enabled = false

# The layout for rendering Thredded views.
Thredded.layout = 'thredded/application'

# ==> Email Configuration
# Email "From:" field will use the following
# (this is also used as the "To" address for both email notifcations, as all the recipients are on bcc)
Thredded.email_from = 'Gremestersep2019@gmail.com'

# Emails going out will prefix the "Subject:" with the following string
Thredded.email_outgoing_prefix = '[Gremester] '
#
# The parent mailer for all Thredded mailers
Thredded.parent_mailer = 'ActionMailer::Base'

