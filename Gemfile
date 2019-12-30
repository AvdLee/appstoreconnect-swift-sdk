# frozen_string_literal: true
source "https://rubygems.org"

# Needed for Fastlane & Danger
gem 'danger'
gem 'danger-junit'
gem 'danger-swiftlint'
gem 'danger-xcode_summary'
gem 'danger-xcov'
gem 'fastlane'
gem 'xcpretty'
gem 'xcpretty-json-formatter'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
