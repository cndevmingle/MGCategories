#
# Be sure to run `pod lib lint MGCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MGCategories'
  s.version          = '0.0.2'
  s.summary          = '常用类的Category.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 不定期添加一些常用Category，方便开发。
                       DESC

  s.homepage         = 'https://github.com/cndevmingle/MGCategories'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mingle' => 'cndevmingle@gmail.com' }
  s.source           = { :git => 'https://github.com/cndevmingle/MGCategories.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.subspec 'MGDate' do |ss|
  	ss.source_files = 'MGCategories/MGCategories/Classes/MGDate/**/*.{h,m}'
  	ss.frameworks = 'Foundation'
  end

  s.subspec 'MGView' do |ss|
  	ss.source_files = 'MGCategories/MGCategories/Classes/MGView/**/*.{h,m}'
  	ss.frameworks = 'UIKit'
  end

  s.subspec 'MGString' do |ss|
  	ss.source_files = 'MGCategories/MGCategories/Classes/MGString/**/*.{h,m}'
  end

  # s.subspec 'MGCache' do |ss|
  # 	ss.source_files = 'MGCategories/Classes/MGCache/**/*.{h,m}'
  # end
  
  # s.resource_bundles = {
  #   'MGCategories' => ['MGCategories/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
