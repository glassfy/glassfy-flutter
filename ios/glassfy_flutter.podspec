#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint glassfy_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'glassfy_flutter'
  s.version          = '1.4.0'
  s.summary          = 'Glassfy SDK'
  s.description      = <<-DESC
Glassfy SDK.
                       DESC
  s.homepage         = 'https://glassfy.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Glassfy' => 'support@glassfy.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'GlassfyGlue', '1.4.0'
  s.platform = :ios, '10.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
