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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [UIImage imageNamed:@"search.png"];
    
    self.colorPalette = [[ColorPalette alloc] init];
    [self.colorPalette setImage:image];
    [self.colorPalette getVibrantColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
