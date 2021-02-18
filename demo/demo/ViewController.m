//
//  ViewController.m
//  demo
//
//  Created by Phil on 2021/2/5.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@import ReCaptcha_objc;

#define webViewTag 1
#define testLabelTag 2

@interface ViewController ()

@end

@implementation ViewController {
    ReCaptcha *recaptcha;
    UILabel *label;
    WKWebView *webview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    recaptcha = [[ReCaptcha alloc] initWithApiKey:nil baseURL:nil endpoint:0 locale:nil error:nil];
    recaptcha.forceVisibleChallenge = YES;
    
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
}


@end
