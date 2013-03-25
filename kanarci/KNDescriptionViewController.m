//
//  KNDescriptionViewController.m
//  kanarci
//
//  Created by Jan Remes on 26.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNDescriptionViewController.h"

@interface KNDescriptionViewController ()

@end

@implementation KNDescriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
      
    }
    return self;
}
-(void)awakeFromNib {
     [self.tabBarItem setFinishedSelectedImage: [UIImage imageNamed: @"tab_legend"] withFinishedUnselectedImage: [UIImage imageNamed: @"tab_legend"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
