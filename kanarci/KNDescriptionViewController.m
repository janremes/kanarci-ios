//
//  KNDescriptionViewController.m
//  kanarci
//
//  Created by Jan Remes on 26.03.13.
//  Copyright (c) 2013 Jan Remes. All rights reserved.
//

#import "KNDescriptionViewController.h"

@interface KNDescriptionViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
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
     [self.tabBarItem setFinishedSelectedImage: [UIImage imageNamed: @"tab4"] withFinishedUnselectedImage: [UIImage imageNamed: @"tab4"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://kanarci.cz/legenda"]];
    
   // [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad] ;
    
    [self.webView loadRequest:request];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.view addSubview:self.activityIndicatorView];
    
    [self.activityIndicatorView centerInSuperview];
    
    [self.activityIndicatorView startAnimating];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web view delegates 


-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = YES;
    [self.activityIndicatorView removeFromSuperview];
}

@end
