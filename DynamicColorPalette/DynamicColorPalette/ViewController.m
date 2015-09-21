//
//  ViewController.m
//  DynamicColorPalette
//
//  Created by Filipe Faria on 9/14/15.
//  Copyright (c) 2015 Filipe Faria. All rights reserved.
//

#import "ViewController.h"
#import "ColorPalette.h"



@interface ViewController ()

@property (nonatomic, strong) ColorPalette *colorPalette;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIView *vibrant;
@property (strong, nonatomic) IBOutlet UIView *vibrantLight;
@property (strong, nonatomic) IBOutlet UIView *vibrantDark;

@property (strong, nonatomic) IBOutlet UIView *muted;
@property (strong, nonatomic) IBOutlet UIView *mutedLight;
@property (strong, nonatomic) IBOutlet UIView *mutedDark;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = nil;
//    image = [UIImage imageNamed:@"photo-06.jpg"];
//    image = [UIImage imageNamed:@"search.png"];
//    image = [UIImage imageNamed:@"Chrome.png"];
//    image = [UIImage imageNamed:@"3.jpg"];
//    image = [UIImage imageNamed:@"2.jpg"];
//    image = [UIImage imageNamed:@"1.jpg"];
    image = [UIImage imageNamed:@"0.jpg"];
    
    self.colorPalette = [[ColorPalette alloc] init];
    [self.colorPalette setImage:image];
    [self.image setImage:image];
    self.vibrant.backgroundColor = [self.colorPalette getVibrantColor];
    self.muted.backgroundColor = [self.colorPalette getMutedColor];
    
    self.vibrantLight.backgroundColor = [self.colorPalette getVibrantLightColor];
    self.mutedLight.backgroundColor = [self.colorPalette getMutedLightColor];
    
    self.vibrantDark.backgroundColor = [self.colorPalette getVibrantDarkColor];
    self.mutedDark.backgroundColor = [self.colorPalette getMutedDarkColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
