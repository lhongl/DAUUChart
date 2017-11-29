

Pod::Spec.new do |s|


  s.name         = "DAUUChart"
  s.version      = "1.0.0"
  s.summary      = "all kinds of categories for iOS develop"

  s.description  = <<-DESC
                      this project provide all kinds of categories for iOS developer 
                   DESC

  s.homepage     = "https://github.com/lihongliangAndliyan/DAUUChart"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "lihongliangAndliyan" => "wf201506@163.com" }


  s.platform     = :ios

  s.source       = { :git => "https://github.com/lihongliangAndliyan/DAUUChart.git", :tag => "1.0.0" }


  s.source_files  = "Classes", "*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "MeTest/Classes/UIKit/UI_Categories.h","MeTest/Classes/Foundation/Foundation_Category.h","MeTest/Classes/**/*.h"

  s.requires_arc = true


end
