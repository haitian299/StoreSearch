//
//  DetailViewController.m
//  StoreSearch
//
//  Created by JIN on 15/5/7.
//  Copyright (c) 2015年 JIN. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SearchResult.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface DetailViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *popupView;
@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.popupView.layer.cornerRadius = 10.0f;
    
    UIImage *image = [[UIImage imageNamed:@"PriceButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [self.priceButton setBackgroundImage:image forState:UIControlStateNormal];
    
    self.view.tintColor = [UIColor colorWithRed:20/255.0f green:160/255.0f blue:160/255.0f alpha:1.0f];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    if (self.searchResult != nil) {
        [self updateUI];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return (touch.view == self.view);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self willMoveToParentViewController:nil];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)dealloc{
    NSLog(@"dealloc %@",self);
    
    [self.artworkImageView cancelImageRequestOperation];
}

- (void)updateUI {
    self.nameLabel.text = self.searchResult.name;
    NSString *artistName = self.searchResult.artistName;
    if (artistName == nil) {
        artistName = @"Unknown";
    }
    self.artistNameLabel.text = artistName;
    self.kindLabel.text = [self.searchResult kindForDisplay];
    self.genreLabel.text = self.searchResult.genre;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:self.searchResult.currency];
    NSString *priceText;
    
    if ([self.searchResult.price floatValue] == 0.0f) {
        priceText = @"Free";
    } else {
        priceText = [formatter stringFromNumber:self.searchResult.price];
    }
    
    [self.priceButton setTitle:priceText forState:UIControlStateNormal];
    [self.artworkImageView setImageWithURL:[NSURL URLWithString:self.searchResult.artworkURL100]];
}

- (IBAction)openInStore:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.searchResult.storeURL]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
