# Moa, an image downloader written in Swift for iOS and OS X

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/moa.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/moa.svg?style=flat)][cocoadocs]
[![Platform](https://img.shields.io/cocoapods/p/moa.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/moa
[carthage]: https://github.com/Carthage/Carthage

Moa is an image download library written in Swift for iOS and OS X.
It allows to download and show an image in an image view by setting its `moa.url` property.

* Images are downloaded asynchronously.
* Uses NSURLSession for networking and caching.
* Allows to configure cache size and policy.
* Can be used without an image view.
* Provides closure properties for image manipulation and error handling.
* Includes unit testing mode for faking network responses.

<img src='https://raw.githubusercontent.com/evgenyneu/moa/master/Graphics/Hunting_Moa.jpg' alt='Moa hunting' width='400'>

> "Lost, like the Moa is lost" - Maori proverb

*'Hunting Moa' drawing by Joseph Smit (1836-1929). File source: [Wikimedia Commons](http://commons.wikimedia.org/wiki/File:Hunting_Moa.jpg).*

## Setup

There are three ways you can add Moa to your Xcode project.

**Add source (iOS 7+)**

Simply add [MoaDistrib.swift](https://github.com/evgenyneu/moa/blob/master/Distrib/MoaDistrib.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Alternatively, add `github "evgenyneu/moa" ~> 2.1` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'moa', '~> 2.1'


#### Setup in Xcode 6

Moa is written in Swift 2 for Xcode 7. See [Swift 1.2 setup instuctions](https://github.com/evgenyneu/moa/wiki/Setup-with-Xcode-6-and-Swift-1.2) for Xcode 6 projects.

## Usage

1. Add `import moa` to your source code if you used Carthage or CocoaPods setup methods.

1. Drag an Image View to your view in the storyboard. Create an outlet property for this image view in your view controller. Alternatively, instead of using the storyboard you can create a `UIImageView` object in code.

1. Set `moa.url` property of the image view to start asynchronous image download. The image will be automatically displayed when download is finished.

```Swift
imageView.moa.url = "https://site.com/image.jpg"
```

## Loading images from insecure HTTP hosts

If your image URLs are not *https* you will need to [add an exception](http://evgenii.com/blog/loading-data-from-non-secure-hosts-in-ios9-with-nsurlsession/) to the **Info.plist** file. This will allow the App Transport Security to load the images from insecure HTTP hosts.

## Canceling download

Ongoing image download for the image view is automatically canceled when:

1. Image view is deallocated.
2. New image download is started: `imageView.moa.url = ...`.

Call `imageView.moa.cancel()` to manually cancel the download.


## Supply error image

You can supply an error image that will be used if an error occurs during image download.

```Swift
imageView.moa.errorImage = UIImage(named: "ImageNotFound.jpg")
imageView.moa.url = "http://site.com/image.jpg"
```

Alternatively, one can supply a global error image that will be used for all failed image downloads.

```Swift
Moa.errorImage = UIImage(named: "ImageNotFound.jpg")
```



## Advanced features


### Supplying completion closure

Assign a closure that will be called when image is received.

```Swift
imageView.moa.onSuccess = { image in
  return image
}

imageView.moa.url = "http://site.com/image.jpg"
```

* The closure will be called after download finishes and before the image is assigned to the image view.
* This is a good place to manipulate the image before it is shown.
* The closure returns an image that will be shown in the image view. Return nil if you do not want the image to be shown.
* The closure as called in the *main queue*. Use `onSuccessAsync` property instead if you need to do time consuming operations.
* When `errorImage` is supplied and an error occurs the success closures are called.


### Supplying error closure

```Swift
imageView.moa.onError = { error, response in
  // Handle error
}

imageView.moa.url = "http://site.com/image.jpg"
```

* The closure is called in the *main queue* if image download fails. Use `onErrorAsync` property instead if you need to do time consuming operations.
* Use `error.localizedDescription` to get a human-readable error description.


### Download an image without an image view

An instance of `Moa` class can also be used without an image view. A strong reference to `Moa` instance needs to be kept.

```Swift
let moa = Moa()
moa.onSuccess = { image in
  // image is loaded
  return image
}
moa.url = "http://site.com/image.jpg"
```


## Image caching

Use the `Moa.settings.cache` to change caching settings. For more information please refer to the [moa image caching manual](https://github.com/evgenyneu/moa/wiki/Moa-image-caching).

```Swift
// By default images are cached according to their response HTTP headers.
Moa.settings.cache.requestCachePolicy = .UseProtocolCachePolicy

// Always cache images locally regardless of their response HTTP headers
Moa.settings.cache.requestCachePolicy = .ReturnCacheDataElseLoad
```

## Settings

Use `Moa.settings` property to change moa image download settings.

```Swift

// Set the maximum number of simultaneous image downloads. Default: 4.
Moa.settings.maximumSimultaneousDownloads = 5

// Change timeout for image requests. Default: 10.
Moa.settings.requestTimeoutSeconds = 20
```

## Logging

Assign a closure to `Moa.logger` and it will be called during image requests, responses, errors and when requests are cancelled. You can also use a pre-made `MoaConsoleLogger` function to see the log messages in the Xcode console. See [logging manual](https://github.com/evgenyneu/moa/wiki/Logging-with-Moa) for more information.


```Swift
Moa.logger = MoaConsoleLogger
```


## Unit testing

Sometimes it is useful to prevent code from making real HTTP requests. Moa includes `MoaSimulator` class for testing image downloads and faking network responses. See [unit test manual](https://github.com/evgenyneu/moa/wiki/Unit-testing-with-Moa) for more information.

```Swift
// Autorespond with the given image to all image requests
MoaSimulator.autorespondWithImage("www.site.com", image: UIImage(named: "35px.jpg")!)
```

## Demo app

The demo iOS app shows how to load images in a collection view with Moa.

<img src='https://raw.githubusercontent.com/evgenyneu/moa/master/Graphics/demo_app_screenshot.png'
alt='Moa image downloader demo iOS app' width='250'>



## Alternative solutions

Here is the list of other image download libraries for Swift.

* [cbot/Vincent](https://github.com/cbot/Vincent)
* [daltoniam/Skeets](https://github.com/daltoniam/Skeets)
* [Haneke/HanekeSwift](https://github.com/Haneke/HanekeSwift)
* [hirohisa/ImageLoaderSwift](https://github.com/hirohisa/ImageLoaderSwift)
* [natelyman/SwiftImageLoader](https://github.com/natelyman/SwiftImageLoader)
* [onevcat/Kingfisher](https://github.com/onevcat/Kingfisher)
* [zalando/MapleBacon](https://github.com/zalando/MapleBacon)

## Credits

* Demo app includes other drawings by Joseph Smit. Source: [Wikimedia Commons](http://commons.wikimedia.org/w/index.php?title=Category:Joseph_Smit&fileuntil=FuligulaNationiSmit.jpg#mw-category-media).

* OS X support is added by [phimage](https://github.com/phimage).


## License

Moa is released under the [MIT License](LICENSE).

## Feedback is welcome

If you notice any issue, got stuck or just want to chat feel free to create an issue. I will be happy to help you.

## •ᴥ•

This project is dedicated to [the moa](https://en.wikipedia.org/wiki/Moa), species of flightless birds that lived in New Zealand and became extinct in 15th century.

