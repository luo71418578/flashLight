Pod::Spec.new do |s|
  s.name         = "flashLight"
  s.version      = "0.0.1"
  s.summary      = "手电筒🔦."
  s.description  = <<-DESC
                    带闪光灯的手电筒
                   DESC
  s.homepage     = "https://github.com/luo71418578/flashLight"
  s.license      = "MIT"
  s.author       = { "luo71418578" => "921257813@qq.com" }
  s.source       = { :git => "https://github.com/luo71418578/flashLight.git", :tag => "#{s.version}" }
  s.platform     = :ios, '5.0'
  s.source_files = "PaperFold/*.{h,m}"

  s.framework    = "UIKit"
  s.requires_arc = true
end
