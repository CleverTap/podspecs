# CleverTap CocoaPods specs repo

This is CleverTap's own [CocoaPods](https://cocoapods.org/) specs repository. It is a
catalog of podspecs that point at the real source code in each pod's own repo. We
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
   ```

2. Pin the CleverTap pod to a version:

   ```ruby
   pod 'CleverTap-iOS-SDK', '7.9.0'
   ```

3. Install, refreshing the spec repos first:

   ```bash
   pod install --repo-update
   ```

If a version is in both this repo and trunk, CocoaPods resolves it from trunk. That is
fine. The only versions you can get solely from here are the ones released after trunk
closes.

## Publishing to this repo (for CleverTap engineers)

Order per release: push here first, validate, then push to trunk. Pushing here first
gives a clean validation window, because the new version exists only in this repo until
the trunk push happens.

### 1. Register this repo once

```bash
pod repo add clevertap-podspecs https://github.com/CleverTap/podspecs.git
```

Check it is registered with `pod repo list`. You need git push access to
`github.com/CleverTap/podspecs` for the push to succeed.

### 2. Refresh the local clone

```bash
pod repo update clevertap-podspecs
```

### 3. Hardcode the version (CleverTap-iOS-SDK and CleverTapLocation only)

These two podspecs read their version by running `cat sdk-version.txt`. That works inside
the SDK repo. It fails when a client reads the raw podspec from this repo, because the
client has no `sdk-version.txt`. Replace the command with the literal version and write a
copy to a temp directory. The temp filename must match `s.name` exactly.

```bash
VERSION=$(cat sdk-version.txt)
mkdir -p /tmp/ct-podspecs/main /tmp/ct-podspecs/location
sed "s/\`cat sdk-version.txt\`/\"$VERSION\"/" CleverTap-iOS-SDK.podspec > /tmp/ct-podspecs/main/CleverTap-iOS-SDK.podspec
sed "s/\`cat sdk-version.txt\`/\"$VERSION\"/" CleverTapLocation.podspec > /tmp/ct-podspecs/location/CleverTapLocation.podspec
```

Pods with a literal version in their podspec skip this step and push the file directly.

### 4. Push (main pod before Location)

Push CleverTap-iOS-SDK first. CleverTapLocation depends on it, so it must resolve during
the lint.

```bash
pod repo push clevertap-podspecs /tmp/ct-podspecs/main/CleverTap-iOS-SDK.podspec     --allow-warnings --skip-tests
pod repo push clevertap-podspecs /tmp/ct-podspecs/location/CleverTapLocation.podspec --allow-warnings --skip-tests
```

- `--allow-warnings`: the push does not fail on warnings.
- `--skip-tests`: skips the test spec lint, which can fail when all dependencies are not
  resolvable in the push environment.

### 5. Validate (optional but recommended)

While the version is here and not yet on trunk, a test app that requests it can only
resolve from this repo. That proves this repo serves the pod.

```bash
mkdir -p ~/ct-pod-validate && cd ~/ct-pod-validate
cat > Podfile <<EOF
source 'https://github.com/CleverTap/podspecs.git'
source 'https://cdn.cocoapods.org/'
platform :ios, '12.0'
target 'TestApp' do
  pod 'CleverTap-iOS-SDK', '$VERSION'
end
EOF
pod install
grep -A6 "SPEC REPOS" Podfile.lock   # the pod must appear under github.com/CleverTap/podspecs
```

Do this before the trunk push. After the trunk push the same version is also on the CDN,
and the CDN will satisfy the request, so the result is no longer a clean proof.

### 6. Push to trunk (while trunk is still writable)

Use the original podspec files, not the sed copies. Trunk evaluates the podspec at upload
time, so the `cat sdk-version.txt` version works there.

```bash
pod trunk push CleverTap-iOS-SDK.podspec  --allow-warnings
pod trunk push CleverTapLocation.podspec  --allow-warnings
```

After December 2, 2026 there is no trunk push. Do steps 1 to 5 only.

## Notes

- Push a pod only when its version changed in a given release.
- SDWebImage and Analytics are third-party pods. They stay on trunk and resolve from the
  CDN. They are not added here. That is why the client `Podfile` keeps the
  `cdn.cocoapods.org` source line.
- You may see `Found multiple specifications for SDWebImage` warnings during a push. They
  are non-fatal. They happen because more than one local specs source carries SDWebImage.
