# ReCaptcha_objc

[![Version](https://img.shields.io/cocoapods/v/ReCaptcha_objc.svg?style=flat)](http://cocoapods.org/pods/ReCaptcha_objc)
[![License](https://img.shields.io/cocoapods/l/ReCaptcha_objc.svg?style=flat)](http://cocoapods.org/pods/ReCaptcha_objc)
[![Platform](https://img.shields.io/cocoapods/p/ReCaptcha_objc.svg?style=flat)](http://cocoapods.org/pods/ReCaptcha_objc)

-----

#### This project is an Objc version of [ReCaptcha](https://github.com/fjcaetano/ReCaptcha).

-----

Add Google's [Invisible ReCaptcha v2](https://developers.google.com/recaptcha/docs/invisible) to your project. This library
automatically handles ReCaptcha's events and retrieves the validation token or notifies you to present the challenge if
invisibility is not possible.

![Example Gif 2](https://raw.githubusercontent.com/fjcaetano/ReCaptcha/master/example2.gif)  ![Example Gif](https://raw.githubusercontent.com/fjcaetano/ReCaptcha/master/example.gif)

#### _Warning_ ⚠️

Beware that this library only works for ReCaptcha v2 Invisible keys! Make sure to check the reCAPTCHA
v2 Invisible badge option when creating your [API Key](https://www.google.com/recaptcha/admin/create).

![ReCaptcha v2 invisible key example](https://raw.githubusercontent.com/fjcaetano/ReCaptcha/master/example-v2-key.png)

You won't be able to use a ReCaptcha v3 key because it requires server-side validation. On v3, all
challenges succeed into a token which is then validated in the server for a score. For this reason,
a frontend app can't know on its own wether or not a user is valid since the challenge will always
result in a valid token.

## Installation

ReCaptcha_objc is available through [CocoaPods](http://cocoapods.org)
To install it, simply add the following line to your dependencies file:

#### Cocoapods
``` ruby
pod "ReCaptcha_objc"
```

## Usage

The reCAPTCHA keys can be specified as Info.plist keys or can be passed as parameters when instantiating ReCaptcha().

For the Info.plist configuration, add `ReCaptchaKey` and `ReCaptchaDomain` (with a protocol ex. http:// or https://) to your Info.plist and run:

``` objc
ReCaptcha *recaptcha = [[ReCaptcha alloc] initWithApiKey:nil baseURL:nil endpoint:EndpointDefault locale:nil error:nil];

[recaptcha configureWebView:^(WKWebView * _Nonnull webview) {
    self->webview = webview;
    self->webview.frame = self.view.bounds;
    self->webview.tag = webViewTag;

    // For testing purposes
    // If the webview requires presentation, this should work as a way of detecting the webview in UI tests
    self->label = [[UILabel alloc] initWithFrame:self.view.bounds];
    self->label.numberOfLines = 0;
    self->label.tag = testLabelTag;
    [self.view addSubview:self->label];
}];

dispatch_async(dispatch_get_main_queue(), ^{
    [self->recaptcha validateOn:nil resetOnError:YES completion:^(NSString * _Nonnull result) {
        [self->webview removeFromSuperview];
        self->label.text = result;
        NSLog(@"Result:%@", result);
    }];
});
```

If instead you prefer to keep the information out of the Info.plist, you can use:
``` objc
ReCaptcha *recaptcha = [[ReCaptcha alloc] initWithApiKey:"YOUR_RECAPTCHA_KEY" baseURL:"YOUR_RECAPTCHA_DOMAIN" endpoint:EndpointDefault locale:nil error:nil];
...
```

#### Alternte endpoint

If your app has firewall limitations that may be blocking Google's API, the JS endpoint may be changed on initialization.
It'll then point to `https://www.recaptcha.net/recaptcha/api.js`:

``` objc
typedef SWIFT_ENUM(NSInteger, Endpoint, closed) {
/// Google’s default endpoint. Points to
/// https://www.google.com/recaptcha/api.js
  EndpointDefault = 0,
/// Alternate endpoint. Points to https://www.recaptcha.net/recaptcha/api.js
  EndpointAlternate = 1,
};

ReCaptcha *recaptcha = [[ReCaptcha alloc] initWithApiKey:"YOUR_RECAPTCHA_KEY" baseURL:"YOUR_RECAPTCHA_DOMAIN" endpoint:EndpointAlternate locale:nil error:nil];
```

## Help Wanted

Do you love ReCaptcha and work actively on apps that use it? We'd love if you could help us keep improving it!
Feel free to message us or to start contributing right away!

## License

ReCaptcha/ReCaptcha_objc is available under the MIT license. See the LICENSE file for more info.
