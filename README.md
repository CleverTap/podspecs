# Beta release podspecs

This repository is for [CocoaPods](https://cocoapods.org) podspecs for beta distribution (not ready for CocoaPods `trunk` yet).

## Using this repo 

1. Add this pod spec repo as a source in your `Podfile`:
   ```
   source 'https://github.com/CleverTap/podspecs.git'
   source 'https://github.com/CocoaPods/Specs.git'
   ```
   (Be sure to also add the main CocoaPods trunk repo to continue installing other pods.)

1. In your `Podfile`, bump the pod you want to use to a version that exists in this repo.
1. `pod install --repo-update`

## Pushing to this repo

1. `pod repo add clevertap-specs https://github.com/CleverTap/podspecs` (only do once initially)
1. Make sure your `podspec` file has the name and and custom version you expect. 
1. `pod repo push clevertap-specs <podspec-name>.podspec`
