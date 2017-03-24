//
//  FoundViewController.m
//  IOSFramework
//
//  Created by xu on 16/3/14.
//
//

#import "FoundViewController.h"
#import "RDVTabBarController.h"

@interface FoundViewController ()

@end

@implementation FoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    NSString * URL = [NSString stringWithFormat:@"file://%@/index.html#/discovery",Bundle2];
    NSURL *url = [NSURL URLWithString:URL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:request];
    NSDictionary *lat=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginInformation"];
    NSLog(@"取出的字典为%@",lat);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.rdv_tabBarController setTabBarHidden:NO animated:NO];
}
@end
