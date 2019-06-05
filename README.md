<!-- PROJECT SHIELDS -->
[![Build Status][build-shield]]()
[![CocoaPods](https://img.shields.io/cocoapods/v/MightyTabBar.svg)](https://cocoapods.org/pods/MightyTabBar)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift v4](https://img.shields.io/badge/Swift-4-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Contributors][contributors-shield]]()
[![MIT License][license-shield]](https://github.com/timshim/MightyTabBar/blob/master/LICENSE)
[![Twitter](https://img.shields.io/twitter/url/https/github.com/timshim/MightyTabBar.svg?style=social)](https://twitter.com/timshim)

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/timshim/MightyTabBar">
    <img src="logo.png" alt="Logo" width="300" height="180">
  </a>
</p>

MightyTabBar is a customizable tab bar that doubles as a menu drawer. Instead of being limited to 5 tab bar items, MightyTabBar allows your app to have many more tab bar items, all positioned within the thumb zone and easily accessible via swipe up.

The original tab bar has always been one of the best UI controls for navigation. It's simple, clear and easy to reach on a mobile device. However, one of the main issues with it is the limited space it affords. The current solution uses a 'More...' tab item to reveal a list of additional menu items, often on another screen. Another solution has been the dreaded hamburger menu, of which there have been [many](https://uxplanet.org/the-ultimate-guide-to-the-hamburger-menu-and-its-alternatives-e2da8dc7f1db), [many](https://medium.muz.li/3-good-reason-why-you-might-want-to-remove-that-hamburger-menu-from-your-product-69b9499ba7e2), [many](https://medium.com/search?q=hamburger%20menu) articles written about.

MightyTabBar is a simple solution to this. It uses a UI element which we are all familliar with (the tab bar) and combines it with another UI element we've probably come across before - the card or drawer UI. Drawers are used in apps like Music, Maps and Uber to display more information about an activity in the main view. Combining the tab bar and drawer allows MightyTabBar to have the best of both worlds - a simple, familliar navigation control which can be expanded to show additional tab bar items.

Some ideas for the future of MightyTabBar:
* Allow drag and drop to reposition tab bar items
* Indicators for selected tab bar items below the fold
* Support UIVisualEffectView for the background
* Better iPad support
* Better horizontal layout support
* Testing! 😅
* Refactor to use SwiftUI

As always, if you like where this project is going, please feel free to suggest new features, fixes, improvements and maybe even contribute if you can!


<!-- TABLE OF CONTENTS -->
## Table of Contents

* [Screenshots](#screenshots)
* [Getting Started](#getting-started)
  * [Requirements](#requirements)
  * [Demo](#demo)
* [Installation](#installation)
* [Usage](#usage)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)

<!-- ABOUT THE PROJECT -->
## Screenshots

![Product Name Screen Shot][screen01] ![Product Name Screen Shot][screen02]

<!-- GETTING STARTED -->
## Getting Started

Follow the instructions below to get started.

### Requirements

* Xcode 10 or later
* iOS 10.0 or later
* Swift 4 or later

### Demo

Run `pod install` in the MightTabBarExample folder. Open the MightyTabBarExample workspace. Build and run.

## Installation

### CocoaPods

``` 
pod MightyTabBar
```

### Carthage

```
github "timshim/MightyTabBar"
```

### Manually

```
git clone https://github.com/timshim/MightyTabBar.git
```

<!-- USAGE EXAMPLES -->
## Usage

This example initializes MightyTabBar in didFinishLaunching method in AppDelegate:

```
window = UIWindow(frame: UIScreen.main.bounds)

// Initialize MightyTabBar
let tabBarController = MightyTabBarController()

// MightyTabBar configuration
tabBarController.itemCountInRow = 4 // Number of tab bar items on each row
tabBarController.bgColor = .white // Background color of the tab bar
tabBarController.handleColor = UIColor(displayP3Red: 149/255, green: 165/255, blue: 166/255, alpha: 0.5) // Color of the drag handle
tabBarController.selectedColor = .red // Set highlighted color
tabBarController.deselectedColor = .black // Set normal color

// Add the tab bar items as an array of dictionary with keys "name" and "image"
tabBarController.tabBarItems = [
    ["name": "Home", "image": "home"],
    ["name": "Explore", "image": "rocket"],
    ["name": "Camera", "image": "camera"],
    ["name": "Gift", "image": "gift"],
    ["name": "Settings", "image": "gear"],
    ["name": "Award", "image": "gift"],
    ["name": "Profile", "image": "home"],
    ["name": "Gear", "image": "gear"],
    ["name": "Discover", "image": "rocket"],
    ["name": "Photos", "image": "camera"]
]

// Add the ViewControllers for each item
let vc01 = ViewController01()
let vc02 = ViewController02()
let vc03 = ViewController03()
let vc04 = ViewController04()
let vc05 = ViewController05()
let vc06 = ViewController06()
let vc07 = ViewController07()
let vc08 = ViewController08()
let vc09 = ViewController09()
let vc10 = ViewController10()
tabBarController.viewControllers = [vc01, vc02, vc03, vc04, vc05, vc06, vc07, vc08, vc09, vc10]

window?.rootViewController = tabBarController
window?.makeKeyAndVisible()
```

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Tim Shim - [@timshim](https://twitter.com/timshim) - timshim@gmail.com

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
* [Img Shields](https://shields.io)
* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Pages](https://pages.github.com)
* [Font Awesome](https://fontawesome.com)

<!-- MARKDOWN LINKS & IMAGES -->
[build-shield]: https://img.shields.io/badge/build-passing-brightgreen.svg?style=flat-square
[contributors-shield]: https://img.shields.io/badge/contributors-1-orange.svg?style=flat-square
[license-shield]: https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square
[license-url]: https://choosealicense.com/licenses/mit
[product-screenshot]: https://raw.githubusercontent.com/othneildrew/Best-README-Template/master/screenshot.png
[screen01]: https://raw.githubusercontent.com/timshim/MightyTabBar/master/screen-01.gif
[screen02]: https://raw.githubusercontent.com/timshim/MightyTabBar/master/screen-02.gif
