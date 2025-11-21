Pod::Spec.new do |spec|
    spec.name                   = "GreenlightSDK"
    spec.version                = "${VERSION}"
    spec.license                = { :type => "MIT OR BSD-2-Clause" }
    spec.summary                = "Swift bindings to Greenlight"
    spec.homepage               = "https://blockstream.com"
    spec.authors                = { "Christian Decker" => "decker@blockstream.com" }
    spec.documentation_url      = "https://docs.rs/glsdk"
    spec.source                 = { :git => 'https://github.com/Blockstream/gl-sdk-swift.git', :tag => spec.version }
    spec.ios.deployment_target  = "13.0"
    spec.source_files           = [
      "Sources/GreenlightSDK/*.swift", 
      "Sources/GreenlightSDK/**/*.swift"
    ]
    spec.static_framework       = true
    spec.dependency "glsdkFFI", "= #{spec.version}"
  end
