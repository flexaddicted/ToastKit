Pod::Spec.new do |s|

  s.name          = "ToastKit"
  s.version       = "1.0.0"
  s.summary       = "ToastKit, a framework for making toasts!"
  s.description   = "ToastKit is a framework that allows to display toasts when you
  need to notify users of your app."
  s.homepage      = "https://lorenzoboaro.io"

  s.license       = "MIT"

  s.author        = "Lorenzo Boaro"

  s.platform      = :ios, "12.0"

  s.source        = { :git => "https://github.com/flexaddicted/ToastKit.git", :tag => "#{s.version}" }

  s.source_files  = "ToastKit"

  s.swift_version = "4.2"

end
