require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-idfa-idfv-gaid"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = "https://github.com/Chirag069/react-native-idfa-idfv-gaid"
  s.license      = "MIT"
  s.authors      = { "Chirag069" => "" }
  s.platforms    = { :ios => "12.0" }
  s.source       = { :git => "https://github.com/Chirag069/react-native-idfa-idfv-gaid.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm}"

  s.dependency "React-Core"

  # Required frameworks for IDFA/IDFV
  s.frameworks = "AdSupport", "AppTrackingTransparency"
end
