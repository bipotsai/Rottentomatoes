//
//  MovieCell.h
//  Rottentomatoes
//
//  Created by Bipo Tsai on 6/15/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end
