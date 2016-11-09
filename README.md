## ZXFoundation

Swift Foundation library @ [ZXVentures](https://zx-ventures.com). Provides common patterns, helpers, and conveniences to quickly bootstrap Swift projects.

#### Table of Contents

* [Integration](#integration)
* [Contributing](#contributing)
* [License](#license)

-----

#### Integration

ZXFoundation supports all Swift platforms and supports [CocoaPods](https://cocoapods.org), [Carthage](https://github.com/Carthage/Carthage), and the [Swift Package Manager](https://github.com/apple/swift-package-manager) for dependency management. Integrations for those platforms is as follows:

##### CocoaPods

In Podfile:

```
pod 'ZXFoundation'
```

Then run `pod install` to update your dependencies. Targeting versions is recommended as it's likely this repo will be volatile for a bit.

##### Carthage

In Cartfile

```
git "git@github.com:ZXVentures/ZXFoundation.git"
```

Then run `carthage update`  to checkout and build the projects dependencies.

##### Swift Package Manager

Run `swift build` and then you will find the dynamic framework in the `.build/debug` directory.

##### Submodules

Alternately you can include the project as a git submodule.

```
git submodule add git@github.com:ZXVentures/ZXFoundation.git
```

##### Notes

* It's recommended to target versions as this project will volatile for awhile. However updates should only include additions and small to changes to the existing API.
* We recommend using git submodules for most scenarios using the following [guide](http://bsn.io/reference/process/2016/06/02/using-carthage-to-add-third-party-code/).

#### Contributing

Please file any bugs under issues explaining the problem. Pull requests are welcome.

#### License

ZXFoundation is license under [The MIT License](https://opensource.org/licenses/MIT).
