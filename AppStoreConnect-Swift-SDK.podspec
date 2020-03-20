Pod::Spec.new do |s|
  s.name             = 'AppStoreConnect-Swift-SDK'
  s.version          = '1.0.1'
  s.summary          = 'The Swift SDK to work with the App Store Connect API from Apple.'

  s.description      = <<-DESC
The Swift SDK to work with the App Store Connect API from Apple. See for more information the readme file on https://github.com/AvdLee/appstoreconnect-swift-sdk.
                       DESC

  s.homepage         = 'https://github.com/AvdLee/appstoreconnect-swift-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Antoine van der Lee' => 'contact@avanderlee.com' }
  s.source           = { :git => 'https://github.com/AvdLee/appstoreconnect-swift-sdk.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/twannl'

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.12'

  s.source_files = 'Sources/**/*'
end
