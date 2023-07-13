# Frucht

This is an iOS app that allows users to create custom fruit shakes and order them straight away. This app is based on the Fruta App built by Apple during the WWDC21 sessions meant to implement the SwiftUI platform features. Any user can can order smoothies, save favorite drinks, collect rewards, and browse recipes. 
The Frucht sample app leverages Sign in with Apple and PassKit (Apple Pay and Wallet) to provide a streamlined user experience. In addition, it offers others features like widgets, App Clips, and localization.
The Frucht does not entirely leverage [Sign in with Apple](https://developer.apple.com/documentation/sign_in_with_apple) and [Apple Pay](https://developer.apple.com/documentation/passkit) although they are encouraged by Apple so as to to provide a streamlined user experience on the Apple platform.

### Targets.
Frucht contains two flavors of app targets:
-Simple iOS and macOS app targets.
-Full featured iOS All and macOS All app targets.

Frucht implements a rich, localized SwiftUI interface. Users can browse and order smoothies, and save favorite drinks.
Frucht also includes widget extensions that enable users to add a widget to their iOS Home Screen or the macOS Notification Center, and to view their rewards or a favorite smoothie. The app also embeds an App Clip. With the App Clip, users can discover and instantly launch some of the app’s functionality on their iPhone or iPad without installing the app.

##### App Clips.
As an App Clip, the Frucht app provides part of its capabilities to users who do not have the complete app loaded. The app's Xcode project includes an App Clip target that, rather than duplicating code, builds the App Clip using code that is shared across all platforms. The project uses the Active Compilation Condition build option in shared code to omit code for targets that do not declare the 'APPCLIP' value. Only the software Clip target, for example, displays an App Store overlay to persuade the user to download the entire software.

``` swift

VStack(spacing: 0) {
    Spacer()
    
    orderStatusCard
    
    Spacer()
    
    #if EXTENDED_ALL
    if presentingBottomBanner {
        bottomBanner
    }
    #endif
    
    #if APPCLIP
    Text(verbatim: "App Store Overlay")
        .hidden()
        .appStoreOverlay(isPresented: $presentingAppStoreOverlay) {
            SKOverlay.AppClipConfiguration(position: .bottom)
        }
    #endif
}
.onChange(of: model.hasAccount) { _ in
    #if APPCLIP
    if model.hasAccount {
        presentingAppStoreOverlay = true
    }
    #endif
}
```

##### Widgets.
The Xcode project includes widget extension targets to allow users to see part of the app's content as a widget on their iOS Home screen or in the macOS Notification Centre. Both make use of code that is common by all targets.

###### Note: 
The Fruta app was a sample project associated with WWDC21 sessions [10107: Platforms State of the Union](https://developer.apple.com/wwdc21/10107/), [10012: What's New in App Clips](https://developer.apple.com/wwdc21/10012/), [10013: Build Light and Fast App Clips](https://developer.apple.com/wwdc21/10013/), [10220: Localize your SwiftUI App](https://developer.apple.com/wwdc21/10220/). 
It's also associated with WWDC20 sessions [10637: Platforms State of the Union](https://developer.apple.com/wwdc20/10637/), [10146: Configure and Link Your App Clips](https://developer.apple.com/wwdc20/10146/), [10120: Streamline Your App Clip](https://developer.apple.com/wwdc20/10120/), [10118: Create App Clips for Other Businesses](https://developer.apple.com/wwdc20/10118/), [10096: Explore Packages and Projects with Xcode Playgrounds](https://developer.apple.com/wwdc20/10096/), and [10028: Meet WidgetKit](https://developer.apple.com/wwdc20/10028/).
