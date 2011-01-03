//
//  Downloads.m
//  FlameNET
//
//  Created by Kaikz on 1/1/11.
//  Copyright Kaikz 2011. All rights reserved.
//

#import "Downloads.h"
#import "FlameNETAppDelegate.h"
#import "ASIHTTPRequest.h"
#import "PDColoredProgressView.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
#import <QuickLook/QuickLook.h>
#endif

@implementation Downloads


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Downloads";
	UIBarButtonItem *done = [[UIBarButtonItem alloc]
							  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
							  target:self
							  action:@selector(dismiss)];
	self.navigationItem.rightBarButtonItem = done;
	[done release];
}

-(void)dismiss {
	[self dismissModalViewControllerAnimated:YES];
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

/*
 - (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
 
 // When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
 
 //    detailViewController.detailItem = [NSString stringWithFormat:@"%@", [linksArray objectAtIndex:indexPath.row]];
 }
 */

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

