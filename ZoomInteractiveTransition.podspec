Pod::Spec.new do |s|

  s.name         = "ZoomInteractiveTransition"
  s.version      = "0.1.0"
  s.summary      = "Simple zoom transition using iOS 7 Custom View Controller Transitions API "

  s.homepage     = "https://github.com/DenHeadless/ZoomInteractiveTransition"
  s.license      = "MIT"

  s.author             = { "Denys Telezhkin" => "denys.telezhkin@yandex.ru" }
  s.social_media_url   = "http://twitter.com/DTCoder"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/DenHeadless/ZoomInteractiveTransition.git", :tag => s.version.to_s }
  s.source_files  = "ZoomTransition"

  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true

end
