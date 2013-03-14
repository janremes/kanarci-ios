//
//  ProfileViewController.h
//  kanarci
//
//  Created by Jan Remes on 14.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
   IBOutlet UITableView *_tableView;
}

@end
