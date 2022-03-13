Pod::Spec.new do |s|
s.name                      = "CleverTap-DirectCall-iOS-SDK"
s.version                   = '0.0.3-alpha'
s.summary                   = "CleverTap-DirectCall-iOS-SDK supports 1-1 voice calls"
s.homepage                  = "https://github.com/CleverTap/clevertap-directcall-ios-sdk"
s.source                    = { :http => "https://github.com/CleverTap/clevertap-directcall-ios-sdk/releases/download/#{s.version}/DirectCallSDK.xcframework.zip" }
s.license                   = { :type => 'Commercial', :text => 'Copyright (c) 2022 CleverTap. All rights reserved. Use of this software is subject to the terms and conditions of the CleverTap Terms of Service' }
s.author                    = { "CleverTap" => "http://www.clevertap.com" }
s.module_name               = 'DirectCallSDK'

s.platform                  = :ios, '10.0'
s.ios.deployment_target     = '10.0'
s.pod_target_xcconfig       = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
s.user_target_xcconfig      = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}

s.swift_version             = "5.0"

s.ios.frameworks            = 'Foundation', 'UIKit', 'Security', 'CoreGraphics', 'CoreImage', 'CoreFoundation', 'AVFoundation', 'AudioToolbox', 'VideoToolbox'

s.vendored_frameworks       = 'DirectCallSDK.xcframework'

s.ios.dependency            'Socket.IO-Client-Swift', '15.2.0'
s.ios.dependency            'CTSoftPhone', '0.0.2-alpha'
s.ios.dependency            'CTSimplePing', '1.0.0'
s.ios.dependency            'CleverTap-iOS-SDK', '4.1.0-dc.beta.1'

end
