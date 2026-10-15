# CleverTap CocoaPods specs repo

This is CleverTap's own [CocoaPods](https://cocoapods.org/) specs repository. It is a
catalog of podspecs that points at the real source code in each pod's own repo. We
control it permanently.

## Why this repo exists

CocoaPods trunk becomes permanently read-only on December 2, 2026. After that date no
one can publish new pod versions to trunk. This repo replaces trunk as the place
CleverTap publishes new releases. Every CleverTap release is pushed here so you keep
receiving updates after trunk closes.

The trunk CDN (`cdn.cocoapods.org`) stays online after the read-only date. Every version
already on trunk keeps resolving from it. We do not copy old versions into this repo.
This repo only carries versions released from now on.

## Using this repo (for app developers)

1. Add this repo as a source in your `Podfile`, and keep the CocoaPods CDN source so
   third-party pods such as SDWebImage still resolve:

   ```ruby
   source 'https://github.com/CleverTap/podspecs.git'
   source 'https://cdn.cocoapods.org/'
