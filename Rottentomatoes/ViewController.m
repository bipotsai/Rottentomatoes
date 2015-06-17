//
//  ViewController.m
//  Rottentomatoes
//
//  Created by Bipo Tsai on 6/14/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+AFNetworking.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    NSString *postURLString = [self.movie valueForKeyPath:@"posters.detailed"];
    postURLString = [self convertPosterUrlStringToHighRes:postURLString];
    [self.posterView setImageWithURL:[NSURL URLWithString:postURLString]];
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (NSString *)convertPostUrlStringtohighRes:(NSString *)urlString{
//    NSRange range = [urlString rangeOfString:@".*cloundfront.net/" options:NSRegularExpressionSearch];
//    NSString *returnValue = urlString;
//    if(range.length > 0){
//        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://contents.flixster.com/"];
//    }
//    return returnValue;
//}
- (NSString *)convertPosterUrlStringToHighRes:(NSString *)urlString {
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = urlString;
    if (range.length > 0) {
        returnValue = [urlString stringByReplacingCharactersInRange:range withString: @"https://content6.flixster.com/"];
    }
    return returnValue;
}
@end
