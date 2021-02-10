# Credit Score MVP
Get your credit rating in style 😎

An application that pulls data from remote server and displays donut progress bar with current credit score out of max possible

![original behaviour gif](orig.gif) ![error handling gif](error.gif) ![low score gif](low.gif)

## Target environment
- Xcode 12.4
- Swift 5
- iOS 13+

## Project highlights
- Animated progress bar with fully customizable colors and ranges
- Counter label with color progression
- SwiftUI
- Combine FRP
- MVVM-C with UI bindings
- Logic separation
- Dependency injection
- Error handling
- Unit tests
- UI snapshot tests

## 3rd party libraries used
Custom SwiftUI wrapper + [Snapshot testing](https://github.com/pointfreeco/swift-snapshot-testing)

### What could be improved given more time
- more UI animations
- add code generation
- accessibility and light/dark mode support

#### UI snapshot tests note
Use iPhone 8 iOS 14.4 as a target device
