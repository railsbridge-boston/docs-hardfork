source "https://rubygems.org"

# ensure github sources are fetched securely
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "3.1.2"

gem "activesupport"
gem "erector", "~> 0.10.0"
gem "sinatra", "~> 1.4.7"
gem "nokogiri"
gem "thin"
gem "eventmachine", "~> 1.0.3"
gem "rack-codehighlighter"
gem "coderay"
gem "deckrb", "~> 0.5.2"
gem "sass"
gem "redcarpet"
gem "rubyzip"
gem "i18n", "~> 0.8.0"
gem "font-awesome-sass"
gem "bootstrap-sass"
gem "jquery-cdn"
gem "sprockets"

group :development do
  gem "wrong", github: "sconover/wrong", ref: "9fae5b82" # remove when 0.7.2+ is released
  gem "rspec"
  gem "rerun"
  gem "rake"
  gem "rack-test"
  gem "files", "~> 0.3.0"
  gem "rb-fsevent", platform: :ruby
end
