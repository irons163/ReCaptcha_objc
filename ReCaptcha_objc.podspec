Pod::Spec.new do |s|
  s.name             = 'ReCaptcha_objc'
  s.version          = '1.6.1'
  s.summary          = 'ReCaptcha for iOS'
  s.swift_version    = '5.0'
  
  s.description      = <<-DESC
Add Google's [Invisible ReCaptcha](https://developers.google.com/recaptcha/docs/invisible) to your project. This library
automatically handles ReCaptcha's events and retrieves the validation token or notifies you to present the challenge if
invisibility is not possible.
                       DESC

  s.homepage          = 'https://github.com/irons163/ReCaptcha_objc'
  s.author            = "irons163"
  s.license           = { :type => 'MIT', :file => 'LICENSE' }
  s.source            = { :git => 'https://github.com/irons163/ReCaptcha_objc.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  s.default_subspecs = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = 'ReCaptcha_objc/Classes/*'
    core.frameworks = 'WebKit'

    core.resource_bundles = {
      'ReCaptcha_objc' => ['ReCaptcha_objc/Assets/**/*']
    }
  end
end
