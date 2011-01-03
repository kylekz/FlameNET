//
//  FlameNETViewController.m
//  FlameNET
//
//  Created by Kaikz on 1/1/11.
//  Copyright Kaikz 2011. All rights reserved.
//

#import "FlameNETViewController.h"
#import "AboutViewController.h"
#import "Downloads.h"

@implementation FlameNETViewController
@synthesize webView, addressBar, activityIndicator;

// Remember to bump version number.

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	NSString *urlAddress = @"http://google.com/pacman";
	
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	[webView loadRequest:requestObj];
	[addressBar setText:urlAddress];
}

-(IBAction)gotoAddress:(id)sender {
	if (! [addressBar.text hasPrefix:@"http://"]) {
		[addressBar setText:[NSString stringWithFormat:@"http://%@", addressBar.text]];
	}
	NSURL *url = [NSURL URLWithString:[addressBar text]];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	[webView loadRequest:requestObj];
	[addressBar resignFirstResponder];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[addressBar setText:self.webView.request.URL.absoluteString];
	[activityIndicator stopAnimating];	
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
	
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		NSURL *URL = [request URL];
		if ([[URL scheme] isEqualToString:@"http"]) {
			[addressBar setText:[URL absoluteString]];
			[self gotoAddress:nil];
		}
		if ([[URL scheme] isEqualToString:@"https"]) {
			[addressBar setText:[URL absoluteString]];
			[self gotoAddress:nil];
		}
		return NO;
	}
	return YES;
}

// Info view
-(IBAction)Info {
		AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:aboutViewController];
		[self presentModalViewController:navigationController animated:YES];
}

-(IBAction) downloads {
	Downloads *downloads = [[Downloads alloc] initWithNibName:@"Downloads" bundle:nil];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:downloads];
	[self presentModalViewController:navigationController animated:YES];
}	

// Action sheet
-(IBAction) actions {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"" 
															 delegate:self 
													cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
											   destructiveButtonTitle:nil 
													otherButtonTitles:@"Print",@"Shorten URL", nil];
	[actionSheet setActionSheetStyle:UIBarStyleBlackTranslucent];
	[actionSheet showInView:self.view];
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	if([sheet buttonTitleAtIndex:buttonIndex] == @"Print")
	{
		UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
		if(!controller){
			NSString *errorMsg = [NSString stringWithFormat: @"Couldn't get shared UIPrintInteractionController!\n\nSorry, your %@, iOS %@ doesn't support AirPrint.", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion]];
			UIAlertView *error1 = [[UIAlertView alloc]
								   initWithTitle:@"Error!"
								   message:errorMsg
								   delegate:self
								   cancelButtonTitle:@"Ok"
								   otherButtonTitles:nil];
			[error1 show];
			[error1 release];
			return;
		}
		void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
		^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
			if(!completed && error){
				UIAlertView *error2 = [[UIAlertView alloc]
									   initWithTitle:@"Error!"
									   message:@"FAILED! Due to error in domain %@ with error code %u", error.domain, error.code, nil
									   delegate:self
									   cancelButtonTitle:@"Ok"
									   otherButtonTitles:nil];
				[error2 show];
				[error2 release];
			}
		};
		UIPrintInfo *printInfo = [UIPrintInfo printInfo];
		printInfo.outputType = UIPrintInfoOutputGeneral;
		printInfo.jobName = [addressBar text];
		printInfo.duplex = UIPrintInfoDuplexLongEdge;
		controller.printInfo = printInfo;
		controller.showsPageRange = YES;
		UIViewPrintFormatter *viewFormatter = [self.webView viewPrintFormatter];
		viewFormatter.startPage = 0;
		controller.printFormatter = viewFormatter;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			[controller presentFromBarButtonItem:actionButton animated:YES completionHandler:completionHandler];
		}else
			[controller presentAnimated:YES completionHandler:completionHandler];
	}
	else if([sheet buttonTitleAtIndex:buttonIndex] == @"Shorten URL")
	{
		HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
		[self.view.window addSubview:HUD];
		HUD.delegate = self;
		HUD.labelText = @"Shortening...";
		[HUD showWhileExecuting:@selector(shortenURL) onTarget:self withObject:nil animated:YES];
	}
}

-(void)shortenURL {
	NSString *urlToShorten = [addressBar text];
	NSString *api = [NSString stringWithFormat:@"http://is.gd/api.php?longurl=%@",urlToShorten];
	NSString *shortedURL = [NSString stringWithContentsOfURL:[NSURL URLWithString:api] encoding:NSASCIIStringEncoding error:nil];
	sleep(2);
	if (shortedURL == @"") {
		HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crossmark.png"]] autorelease];
		HUD.mode = MBProgressHUDModeCustomView;
		HUD.labelText = @"Failed!";
	} else {
	HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]] autorelease];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = @"Complete!";
		addressBar.text = [NSString stringWithFormat:shortedURL];
		}
	sleep(1);
}
- (void)hudWasHidden {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
}
	
/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[AboutViewController dealloc];
}

@end
