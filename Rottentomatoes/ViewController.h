//
//  ViewController.h
//  Rottentomatoes
//
//  Created by Bipo Tsai on 6/14/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titlLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property (strong, nonatomic) NSDictionary *movie;
@end

