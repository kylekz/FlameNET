//
//  AboutViewController.m
//  FlameNET
//
//  Created by Kaikz on 1/1/11.
//  Copyright Kaikz 2011. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController
@synthesize devButton;

NSString *version = @"By Kaikz - v1.4";

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"About/Settings";
	UIBarButtonItem *about = [[UIBarButtonItem alloc]
							   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
							   target:self
							   action:@selector(dismiss)];
	self.navigationItem.rightBarButtonItem = about;
	[about release];
	[devButton setTitle:version forState:UIControlStateNormal];

}

-(void)dismiss {
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)devSite {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://kaikz.com/"]];
}



// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
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
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
