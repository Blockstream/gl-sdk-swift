Pod::Spec.new do |spec|
    spec.name                   = "glsdkFFI"
    spec.version                = "${VERSION}"
    spec.license                = { :type => "MIT OR BSD-2-Clause" }
    spec.summary                = "Low-level bindings to the Greenlight API"
    spec.homepage               = "https://blockstream.com"
    spec.authors                = { "Christian Decker" => "decker@blockstream.com" }
    spec.documentation_url      = "https://docs.rs/glsdk"
    spec.source                 = { :http => "https://github.com/Blockstream/gl-sdk-swift/releases/download/${VERSION}/lwkFFI.xcframework.zip" }
    spec.ios.deployment_target  = "13.0"
    spec.vendored_frameworks    = "glsdkFFI.xcframework"
  end
