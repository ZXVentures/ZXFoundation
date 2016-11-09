Pod::Spec.new do |s|

  s.name         = "ZXFoundation"
  s.version      = "0.22.0"

s.summary      = "Foundation library for iOS @ [ZXVentures](https://zx-ventures.com). Common patterns, helpers, and conveniences for Swift @ ZX Ventures."
  s.description  = <<-DESC
Common patterns, helpers, and conveniences for Swift @ ZX Ventures.
                   DESC

  s.homepage     = "https://zx-ventures.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Wyatt McBain" => "wyatt.mcbain@zx-ventures.com" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "git@github.com:ZXVentures/ZXFoundation.git", :tag => "0.22.0" }
  s.source_files  = "Sources/ZXFoundation/**/*.swift"

end
