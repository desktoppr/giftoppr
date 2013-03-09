# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "actionmailer"
  s.version = "3.2.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Heinemeier Hansson"]
  s.date = "2013-03-09"
  s.description = "Email on Rails. Compose, deliver, receive, and test emails using the familiar controller/view pattern. First-class support for multipart email and attachments."
  s.email = "david@loudthinking.com"
  s.files = ["CHANGELOG.md", "README.rdoc", "MIT-LICENSE", "lib/action_mailer", "lib/action_mailer/base.rb", "lib/action_mailer/collector.rb", "lib/action_mailer/delivery_methods.rb", "lib/action_mailer/log_subscriber.rb", "lib/action_mailer/mail_helper.rb", "lib/action_mailer/railtie.rb", "lib/action_mailer/test_case.rb", "lib/action_mailer/test_helper.rb", "lib/action_mailer/version.rb", "lib/action_mailer.rb", "lib/rails", "lib/rails/generators", "lib/rails/generators/mailer", "lib/rails/generators/mailer/mailer_generator.rb", "lib/rails/generators/mailer/templates", "lib/rails/generators/mailer/templates/mailer.rb", "lib/rails/generators/mailer/USAGE"]
  s.homepage = "http://www.rubyonrails.org"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.requirements = ["none"]
  s.rubygems_version = "2.0.0"
  s.summary = "Email composition, delivery, and receiving framework (part of Rails)."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, ["= 3.2.12"])
      s.add_runtime_dependency(%q<mail>, ["~> 2.5.3"])
    else
      s.add_dependency(%q<actionpack>, ["= 3.2.12"])
      s.add_dependency(%q<mail>, ["~> 2.5.3"])
    end
  else
    s.add_dependency(%q<actionpack>, ["= 3.2.12"])
    s.add_dependency(%q<mail>, ["~> 2.5.3"])
  end
end
