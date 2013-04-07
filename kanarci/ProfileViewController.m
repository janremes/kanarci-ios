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
#import "KNDataManager.h"
#import "KNMeasureHelper.h"

@interface ProfileViewController ()
    

@end

@implementation ProfileViewController{
    NSArray *_measurements;
    NSDateFormatter *_dateFormatter;
    NSDateFormatter *_timeFormatter;
    
    


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
    [self.tabBarItem setFinishedSelectedImage: [UIImage imageNamed: @"tab5"] withFinishedUnselectedImage: [UIImage imageNamed: @"tab5"]];
    addNotificationObserver(self, measurementDataChangedWithNotification:, KNMeasureDataChangedNotification, nil);
    _dateFormatter = [[NSDateFormatter alloc] init];
    _timeFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"EE d/MM/yy"];
    [_timeFormatter setDateFormat:@"HH:mm"];

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
    
    Measurement *currentMeasure = [_measurements objectAtIndex:[_measurements count] - indexPath.row -1];
    
    
    
    [cell.airQualityImageView setImage:[UIImage imageNamed:[KNMeasureHelper getImageNameForBucketValue:currentMeasure.bucketValue]]];
    
    cell.dateLabel.text = [_dateFormatter stringFromDate:currentMeasure.date];
    cell.timeLabel.text = [_timeFormatter stringFromDate:currentMeasure.date];
    
    [cell.dateLabel sizeToFit];
    [cell.timeLabel sizeToFit];
    
    cell.timeLabel.left = cell.dateLabel.right + 4;
    cell.timeLabel.center = CGPointMake(cell.timeLabel.center.x, cell.dateLabel.center.y) ;
    
  //  [cell.timeLabel centerVertically];
  //  [cell.dateLabel centerVertically];
    
    if (currentMeasure.locationDataAvailable) {
        cell.thoroughfareLabel.text = currentMeasure.thoroughfare;
        cell.localityLabel.text = currentMeasure.locality;
        
    } else {
        cell.thoroughfareLabel.text = @"Lokace neznámá.";
        cell.localityLabel.text = @"";
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

-(void) measurementDataChangedWithNotification:(NSNotification *) notification {
    _measurements = [[KNDataManager sharedInstance] getAllMeasures];
    [_tableView reloadData];
}

#pragma mark -
#pragma mark View controllers delegates

- (void)viewDidLoad
{
    [super viewDidLoad];
	
     _measurements = [[KNDataManager sharedInstance] getAllMeasures];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    removeNotificationObserver(self);
}

@end
