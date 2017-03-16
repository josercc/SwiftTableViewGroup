Pod::Spec.new do |s|
  s.name = 'ZHTableViewGroupSwift'
  s.version = '0.1.3'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'ZHTableViewGroup为 UITableView 而生'
  s.homepage         = 'https://github.com/josercc/ZHTableViewGroupSwift'
  s.authors = { 'josercc' => 'm15038777234@163.com' }
  s.source = { :git => 'https://github.com/josercc/ZHTableViewGroupSwift.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Source/*.swift'
  s.resource_bundles = {
    'ZHTableViewGroupSwift' => ['Resources/**/*.{png}']
  }
end
