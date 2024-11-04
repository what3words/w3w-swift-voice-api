Pod::Spec.new do |s|
  s.name        = "W3WSwiftVoiceApi"
  s.version     = "2.0.0"
  s.summary     = "w3w-swift-voice-api allows you to convert a spoken 3 word address in audio to a list of three word address suggestions"
  s.homepage    = "https://github.com/what3words/w3w-swift-voice-api"
  s.license     = { :type => "MIT" }
  s.authors     = { "what3words" => "support@what3words.com" }

  #s.requires_arc = true
  s.osx.deployment_target = "10.13"
  s.ios.deployment_target = "11.0"
  s.source   = { :git => "https://github.com/what3words/w3w-swift-voice-api.git"}
  s.source_files = "Sources/W3WSwiftVoiceApi/**/*.swift"
  s.swift_version = '5.0'
  s.dependency 'W3WSwiftCore', '~> 1.1.2'
end
