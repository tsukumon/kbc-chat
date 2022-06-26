Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
  #"66824112009-71hducq2oaqu4puum0873beo3e4ngcri.apps.googleusercontent.com", #org
  #"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" #org
  "516137130569-rmi6jhnkokomlgfbv0ugb5fn0bc0mhr0.apps.googleusercontent.com", #test
  "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" #test
end