Rails.application.config.generators do |g|
  g.stylesheets false
  g.javascripts false
  g.helper false
  g.skip_routes true
  g.test_framework :rspec,
   fixture: true,
   view_specs: false,
   helper_specs: false,
   routing_specs: false,
   controller_specs: true,
   request_specs: true
end