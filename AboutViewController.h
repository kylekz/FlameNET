//
//  AboutViewController.h
//  FlameNET
//
//  Created by Kaikz on 1/1/11.
//  Copyright Kaikz 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController {
	IBOutlet UIButton *devButton;
}

@property (nonatomic, retain) UIButton *devButton;

-(IBAction)devSite;

@end