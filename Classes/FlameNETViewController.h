//
//  FlameNETViewController.h
//  FlameNET
//
//  Created by Kaikz on 1/1/11.
//  Copyright Kaikz 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface FlameNETViewController : UIViewController <MBProgressHUDDelegate, UIActionSheetDelegate> {
	IBOutlet UIWebView *webView;
	IBOutlet UITextField *addressBar;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UIBarButtonItem *actionButton;
	MBProgressHUD *HUD;
	UIPasteboard *pasteboard;
	NSString *string;
}

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) UITextField *addressBar;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain) UIBarButtonItem *actionButton;
@property (nonatomic,retain) NSString *string;

-(IBAction) gotoAddress:(id)sender;
-(IBAction)Info;
-(IBAction) actions;
-(IBAction) downloads;

@end

