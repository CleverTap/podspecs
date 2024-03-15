Pod::Spec.new do |s|
s.name                      = "CleverTap-SignedCall-SDK"
s.version                   = '0.0.7'
s.summary                   = "CleverTap-SignedCall-SDK supports 1-1 voice calls"
s.homepage                  = "https://github.com/CleverTap/clevertap-signedcall-ios-sdk"
s.source                    = { :http => "https://github.com/CleverTap/clevertap-signedcall-ios-sdk/releases/download/#{s.version}/SignedCallSDK.xcframework.zip" }
s.license                   = { :type => 'Commercial', :text => 'Copyright (c) 2022 CleverTap. All rights reserved. Use of this software is subject to the terms and conditions of the CleverTap Terms of Service' }
s.author                    = { "CleverTap" => "http://www.clevertap.com" }
s.module_name               = 'SignedCallSDK'

s.platform                  = :ios
s.ios.deployment_target     = '12.0'
s.swift_version             = "5.0"

s.ios.frameworks            = 'Foundation', 'UIKit', 'Security', 'CoreGraphics', 'CoreImage', 'CoreFoundation', 'AVFoundation', 'AudioToolbox', 'VideoToolbox'

s.vendored_frameworks       = 'SignedCallSDK.xcframework'

s.ios.dependency            'Socket.IO-Client-Swift', '16.1.0'
s.ios.dependency            'Starscream', '4.0.8'
s.ios.dependency            'CTSoftPhone', '0.0.6-alpha'
s.ios.dependency            'CTSimplePing', '1.0.1'
s.ios.dependency            'CleverTap-iOS-SDK'

end
