//
//  NMBaseWebViewController.m
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/18.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "NMBaseWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface NMBaseWebViewController()<UIWebViewDelegate,UIScrollViewDelegate,NJKWebViewProgressDelegate>
@property(nonatomic,strong) NJKWebViewProgress *webProgress;
@property(nonatomic,strong) NJKWebViewProgressView *progressView;
@end
@implementation NMBaseWebViewController
-(void)viewDidLoad{
    [super viewDidLoad];
     [self createWebView];
}
-(void)createWebView{
    if (!self.webView) {
        self.webView = [UIWebView new];
        [self.view addSubview:self.webView];
        self.webView.frame=CGRectMake(0,NMScreenNavHeight, NMScreenFrameW, NMScreenFrameH-NMScreenNavHeight);
        [self.webView setScalesPageToFit:YES];
        self.webView.scrollView.bounces = NO;
        self.webView.scrollView.delegate = self;
        
        // 网页媒体播放
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = YES;
        self.webView.allowsInlineMediaPlayback = YES;
        self.webView.mediaPlaybackRequiresUserAction = NO;
        self.webView.scrollView.showsHorizontalScrollIndicator = NO;
        self.webView.scrollView.bounces = NO;
        
        self.webProgress = [[NJKWebViewProgress alloc] init];
        self.webView.delegate = self.webProgress;
        self.webProgress.webViewProxyDelegate = self;
        self.webProgress.progressDelegate = self;
        
        
        CGFloat progressBarHeight = 2.f;
        
        CGRect barFrame = CGRectMake(0, NMScreenNavHeight - progressBarHeight, NMScreenFrameW, progressBarHeight);
        self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:self.progressView];

    }
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress<=self.progressView.progress) {
        return;
    }
     NSLog(@"load request:%f",progress);
    [self.progressView setProgress:progress animated:NO];
}
-(void)loadRequest:(NSURLRequest *)request{
   
    [self createWebView];
    [self.webView loadRequest:request];
}
@end
