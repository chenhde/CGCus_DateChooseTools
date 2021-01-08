#
#  Be sure to run `pod spec lint CGCustomDateChooseTools.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|



spec.name         = "CGCustomDateChooseTools"
spec.version      = "0.0.2"
spec.summary      = "自定义时间选择器，默认不能选择今天以后的日期"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
spec.description  = <<-DESC

自定义时间选择器，可选择年月，或者年月日。自动适配今年多少月及本月多少日。

DESC

spec.homepage     = "https://github.com/chenhde/CGCustomDateChooseTools"

spec.license      = "MIT"

spec.author             = { "chenhd" => "669775990@qq.com" }


spec.platform     = :ios, "10.0"
spec.ios.deployment_target = "10.0"
spec.ios.frameworks = 'Foundation', 'UIKit'
spec.requires_arc = true

spec.source       = { :git => "https://github.com/chenhde/CGCustomDateChooseTools.git", :tag => "#{spec.version}" }

spec.source_files  ="CGCustomDateChooseTools","CGCustomDateChooseTools/*.{h,m,xib}"






end
