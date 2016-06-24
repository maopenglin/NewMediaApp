//
//  NMBaseWebViewController.h
//  NewMediaApp
//
//  Created by PengLinmao on 16/5/18.
//  Copyright © 2016年 pengLin. All rights reserved.
//

#import "NMBaseViewController.h"

@interface NMBaseWebViewController : NMBaseViewController
@property(nonatomic,strong)UIWebView *webView;

-(void)loadRequest:(NSURLRequest *)request;
@end
