#
#  Be sure to run `pod spec lint CGCusDateChooseTools.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|



spec.name         = "CGCusDateChooseTools"
spec.version      = "0.0.3"
spec.summary      = "自定义时间选择器，默认不能选择今天以后的日期"

spec.description  = <<-DESC

自定义时间选择器，可选择年月，或者年月日。自动适配今年多少月及本月多少日。

DESC

spec.homepage     = "https://github.com/chenhde/CGCusDateChooseTools"

spec.license      = "MIT"

spec.author             = { "chenhd" => "669775990@qq.com" }


spec.platform     = :ios, "10.0"
spec.ios.deployment_target = "10.0"
spec.ios.frameworks = 'Foundation', 'UIKit'
spec.requires_arc = true

spec.source       = { :git => "https://github.com/chenhde/CGCusDateChooseTools.git", :tag => "#{spec.version}" }

spec.source_files  ="CGCusDateChooseTools","CGCusDateChooseTools/*.{h,m,xib}"






end
