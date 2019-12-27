# frozen_string_literal: true
source "https://rubygems.org"

# Needed for Fastlane & Danger
gem 'fastlane'
gem 'danger'
gem 'danger-swiftlint'
gem 'danger-xcov'
gem 'danger-xcode_summary'
gem 'xcpretty'
gem 'xcpretty-json-formatter'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
