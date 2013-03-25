//
//  ProfileViewController.m
//  kanarci
//
//  Created by Jan Remes on 14.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileHeaderView.h"
#import "MeasurementCell.h"
#import "Measurement.h"

@interface ProfileViewController ()
    

@end

@implementation ProfileViewController{
    NSArray *_measurements;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
       
    }
    return self;
}

-(void)awakeFromNib {
    [self.tabBarItem setFinishedSelectedImage: [UIImage imageNamed: @"tab_profile"] withFinishedUnselectedImage: [UIImage imageNamed: @"tab_profile"]];
}


#pragma mark -
#pragma mark Table view data source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MeasurementCell";
    
    MeasurementCell *cell = (MeasurementCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MeasurementCell" owner:self options:nil];
		
		for (id currentObject in topLevelObjects){
			if ([currentObject isKindOfClass:[UITableViewCell class]]){
				cell =  (MeasurementCell *) currentObject;
				break;
			}
		}
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 85.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     return [[ProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 85)];
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_measurements count];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -
#pragma mark View controllers delegates

- (void)viewDidLoad
{
    [super viewDidLoad];
	
     _measurements = @[[Measurement new],[Measurement new], [Measurement new]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
