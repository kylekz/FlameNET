//
//  FlameNETAppDelegate.h
//  FlameNET
//
//  Created by Kaikz on 1/1/11.
//  Copyright Kaikz 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Downloads.h"

@class FlameNETViewController;

@interface FlameNETAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FlameNETViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FlameNETViewController *viewController;

@end
