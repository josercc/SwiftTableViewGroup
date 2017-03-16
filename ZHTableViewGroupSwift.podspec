#
# Be sure to run `pod lib lint ZHTableViewGroupSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZHTableViewGroupSwift'
  s.version          = '0.1.0'
  s.summary          = 'ZHTableViewGroup为 UITableView 而生'
  s.homepage         = 'https://github.com/josercc/ZHTableViewGroupSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '15038777234' => '15038777234@163.com' }
  s.source           = { :git => 'https://github.com/josercc/ZHTableViewGroupSwift.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'ZHTableViewGroupSwift/Classes/**/*'
  # s.resource_bundles = {
  #   'ZHTableViewGroupSwift' => ['ZHTableViewGroupSwift/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
