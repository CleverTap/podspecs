Pod::Spec.new do |s|
s.name                      = "CleverTap-SignedCall-iOS-SDK"
version                     = `0.0.8`
s.version                   =  version
s.summary                   = "CleverTap-SignedCall-iOS-SDK supports 1-1 voice calls"
s.homepage                  = "https://github.com/CleverTap/clevertap-directcall-ios-sdk"
s.source                    = { :http => "https://github.com/CleverTap/clevertap-directcall-ios-sdk/releases/download/#{s.version}/DirectCallSDK.xcframework.zip" }
s.license                   = { :type => 'Commercial', :text => 'Copyright (c) 2022 CleverTap. All rights reserved. Use of this software is subject to the terms and conditions of the CleverTap Terms of Service' }
s.author                    = { "CleverTap" => "http://www.clevertap.com" }
s.module_name               = 'SignedCallSDK'

s.platform                  = :ios, '12.0'
s.ios.deployment_target     = '12.0'
s.swift_version             = "5.0"
s.resources                 = 'SignedCallSDK/*.{xcprivacy}'
s.ios.frameworks            = 'Foundation', 'UIKit', 'Security', 'CoreGraphics', 'CoreImage', 'CoreFoundation', 'AVFoundation', 'AudioToolbox', 'VideoToolbox'

s.vendored_frameworks       = 'SignedCallSDK.xcframework'

s.ios.dependency            'Socket.IO-Client-Swift', '16.1.0'
s.ios.dependency            'Starscream', '4.0.8'
s.ios.dependency            'CTSoftPhone', '0.0.6-alpha'
s.ios.dependency            'CTSimplePing', '1.0.2'
s.ios.dependency            'CleverTap-iOS-SDK'

end
