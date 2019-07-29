Pod::Spec.new do |spec|
  spec.name         = "SwiftTableViewGroup"
  spec.version      = "2.0.0"
  spec.summary      = "SwiftTableViewGroup 是符合 SwiftUI 设计的 UITableView 数据驱动（SwiftTableViewGroup is a UITableView data driver compliant with SwiftUI design）"
  # spec.description  = <<-DESC
  # SwiftTableViewGroup 是符合 SwiftUI 设计的 UITableView 数据驱动（SwiftTableViewGroup is a UITableView data driver compliant with SwiftUI design）
  #                  DESC

  spec.homepage     = "https://github.com/josercc/SwiftTableViewGroup"
  spec.license      = "MIT"
  spec.author       = { "张行" => "josercc@163.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/josercc/SwiftTableViewGroup.git", :tag => "#{spec.version}" }
  spec.source_files  = "SwiftTableViewGroup/Sources/SwiftTableViewGroup/**/*.{swift}"
  spec.swift_versions = '5.1'
end
