//
//  ColorPalette.h
//  ColorPalette
//
//  Created by Filipe Faria on 9/11/15.
//  Copyright (c) 2015 Filipe Faria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorPalette : NSObject

- (void)setImage:(UIImage*)image;

-(UIColor *) getVibrantColor;
-(UIColor *) getVibrantLightColor;
-(UIColor *) getVibrantDarkColor;
-(UIColor *) getMutedColor;
-(UIColor *) getMutedLightColor;
-(UIColor *) getMutedDarkColor;
@end
