#
# Be sure to run `pod lib lint CPYPageViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CPYPageViewController'
  s.version          = '0.1.11'
  s.summary          = 'A page view controller with tab integration.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A page view controller with tab integration. Also you can use page view controller only.'
  s.homepage         = 'https://github.com/cielpy/CPYPageViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cielpy' => 'beijiu572@gmail.com' }
  s.source           = { :git => 'https://github.com/cielpy/CPYPageViewController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/cielpy5'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CPYPageViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CPYPageViewController' => ['CPYPageViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
