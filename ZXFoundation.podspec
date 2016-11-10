Pod::Spec.new do |s|

  s.name         = "ZXFoundation"
  s.version      = "0.24.0"

  s.summary      = "Foundation library for iOS @ [ZXVentures](https://zx-ventures.com). Common patterns, helpers, and conveniences for Swift @ ZX Ventures."
  s.description  = <<-DESC
Common patterns, helpers, and conveniences for Swift @ ZX Ventures.

This 'Foundation' library is designed to only depend on Apple's `Foundation` and other Apple frameworks that are available across all platforms such as `Core Graphics`. Included are extensions on top of `Foundation` and patterns for networking, errors, and testing that we use to quickly Bootstrap projects.
                   DESC

  s.homepage     = "https://zx-ventures.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Wyatt McBain" => "wyatt.mcbain@zx-ventures.com" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/ZXVentures/ZXFoundation.git", :tag => "0.24.0" }
  s.source_files  = "Sources/ZXFoundation/**/*.swift"

end
