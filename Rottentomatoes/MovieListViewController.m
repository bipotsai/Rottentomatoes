//
//  MovieListViewController.m
//  Rottentomatoes
//
//  Created by Bipo Tsai on 6/14/15.
//  Copyright (c) 2015 Bipo Tsai. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieCell.h"
#import "ViewController.h"
#import <UIImageView+AFNetworking.h>
#import "SVProgressHUD.h"
@interface MovieListViewController () <UITableViewDataSource, UITableViewDelegate>{
    UIRefreshControl *refreshControl;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UIView *warningView;
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:@"MyMovieCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, 0, 0)];
    [self.tableView insertSubview:refreshView atIndex:0]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor redColor];
    [refreshControl addTarget:self action:@selector(reloadDatas) forControlEvents:UIControlEventValueChanged];
    /* NSMutableAttributedString *refreshString = [[NSMutableAttributedString alloc] initWithString:@"Pull To Refresh"];
     [refreshString addAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} range:NSMakeRange(0, refreshString.length)];
     refreshControl.attributedTitle = refreshString; */
    [refreshView addSubview:refreshControl];
    
//    self.tableView
//    self.tableView.delegaterefreshControl = [UIRefreshControl new];
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
//    [self.refreshControl addTarget:self action:@selector(bindDatas) forControlEvents:UIControlEventValueChanged];

//    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
//    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
//    [refresh addTarget:self
//    action:@selector(refreshView:)
//    forControlEvents:UIControlEventValueChanged];
//    self.tableView.refreshControl = refresh;
//    
    [self reloadDatas];
    }

-(void)reloadDatas{
    [SVProgressHUD showWithStatus:@"Doing Stuff"];
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=ws32mxpd653h5c8zqfvksxw9&limit=20&country=us";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"connectionError");
            [self showNetworkError];
//             self.navigationItem.title = @"😱 Netwoking ERROR";
//            self.navigationItem.titleView.frame =  CGRectMake(0, 0, 0, 0);
//            [UIView animateWithDuration:0.25 animations:^{
//                self.navigationItem.titleView.frame =  CGRectMake(0, 0, 100, 200);
//            }];
        }else{
            NSLog(@"good");
             [self hideNetworkError];
           // self.navigationItem.title = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = dict[@"movies"];
            [self.tableView reloadData];
            
        }
        
        //NSDictionary * firstMovie = movies[0];
        //NSLog(@"%@",firstMovie);
        //self.movies = object[@"movies"];
        //[self.tableView reloadData];
        
    }];
    [refreshControl endRefreshing];
    [SVProgressHUD dismiss];

}

- (void)showNetworkError{
    UIView *netWorkErrorview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 25)];
    //netWorkErrorview.backgroundColor = [UIColor colorWithRed:0.5 green:0.6 blue:0.9 alpha:0.5];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 25)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"😱 Netwoking ERROR";
    label.textColor = [UIColor redColor];
    [netWorkErrorview addSubview:label];
    [UIView animateWithDuration:2.00 animations:^{
        self.tableView.tableHeaderView =  [netWorkErrorview initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 25)];
    }];
    
}
- (void)hideNetworkError{
    self.tableView.tableHeaderView = nil;
}

-(void)refreshView:(UIRefreshControl *)refresh {
         refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
   
         // custom refresh logic would be placed here...
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         [formatter setDateFormat:@"MMM d, h:mm a"];
       NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",
                                                                      [formatter stringFromDate:[NSDate date]]];
         refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
        [refresh endRefreshing];
     }


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    //NSString *title = movie[@"title"];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    NSString *postURLString = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:postURLString]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *movie = self.movies[indexPath.row];
    ViewController *destinationVC = segue.destinationViewController;
    destinationVC.movie = movie;
    
}

- (NSString *)convertPostUrlStringtohighRes:(NSString *)urlString{
    NSRange range = [urlString rangeOfString:@".*cloundfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = urlString;
    if(range.length > 0){
        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://contents.flixster.com/"];
    }
    return returnValue;
}

@end
