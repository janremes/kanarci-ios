//
//  MeasurementCell.h
//  kanarci
//
//  Created by Jan Remes on 14.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeasurementCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *airQualityImageView;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *localityLabel;
@property (strong, nonatomic) IBOutlet UILabel *thoroughfareLabel;

@end
