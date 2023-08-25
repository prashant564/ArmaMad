#
# Be sure to run `pod lib lint ArmaMad.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ArmaMad'
  s.version          = '0.1.3'
  s.summary          = 'ArmaMad is a powerful tool that helps you to do everything.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "This project contains cocoapods for integrating asdas asdasdasd asdasdasd asdasd in client's native ios applications"

  s.homepage         = 'https://github.com/prashant564/ArmaMad.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'prashant564' => 'prashantdixit600@gmail.com' }
  s.source           = { :git => 'https://github.com/prashant564/ArmaMad.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = '4.1'

  s.source_files = 'Classes/**/*.swift'
  
   s.resource_bundles = {
     'ArmaMad' => ['Classes/**/*.storyboard']
   }
  
  # s.resource_bundles = {
  #   'ArmaMad' => ['ArmaMad/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
