//
//  ColorPaletteObject.m
//  ColorPalette
//
//  Created by Filipe Faria on 9/11/15.
//  Copyright (c) 2015 Filipe Faria. All rights reserved.
//

#import "ColorPaletteObject.h"

@interface ColorPaletteObject()

@property (nonatomic, assign) CGFloat RGBRed;
@property (nonatomic, assign) CGFloat RGBGreen;
@property (nonatomic, assign) CGFloat RGBBlue;
@property (nonatomic, assign) CGFloat RGBAlpha;

@property (nonatomic, assign) CGFloat red;
@property (nonatomic, assign) CGFloat green;
@property (nonatomic, assign) CGFloat blue;
@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, assign) CGFloat hue;
@property (nonatomic, assign) CGFloat saturation;
@property (nonatomic, assign) CGFloat brightness;

@property (nonatomic, strong) UIColor *color;


@end

@implementation ColorPaletteObject

- (void)setRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    self.red = red;
    self.green = green;
    self.blue = blue;
    self.alpha = alpha;
    
    self.RGBRed = red / 255;
    self.RGBGreen = green / 255;
    self.RGBBlue = blue / 255;
    self.RGBAlpha = alpha / 255;
    
    self.color = [UIColor colorWithRed:self.RGBRed green:self.RGBGreen blue:self.RGBBlue alpha:self.RGBAlpha];
    
    self.hue = 0;
    self.saturation = 0;
    self.brightness = 0;
    
    CGFloat minRGB = MIN(self.RGBRed, MIN(self.RGBGreen,self.RGBBlue));
    CGFloat maxRGB = MAX(self.RGBRed, MAX(self.RGBGreen,self.RGBBlue));
    
    if (minRGB == maxRGB) {
      
        self.hue = 0;
        self.saturation = 0;
        self.brightness = minRGB;
        
    } else {
       
        if(maxRGB == self.RGBRed){
            
            self.hue = (self.RGBGreen - self.RGBBlue) / (maxRGB-minRGB) * 60 / 360;
        
        }
        else if(maxRGB == self.RGBGreen){
            
            self.hue = (2.0 + (self.RGBBlue - self.RGBRed) / (maxRGB - minRGB)) * 60 / 360;
        
        }
        else{
            
            self.hue = (4.0 + (self.RGBRed - self.RGBGreen) / (maxRGB - minRGB)) * 60 / 360;
        }

        self.saturation = (maxRGB - minRGB) / maxRGB;
        self.brightness = maxRGB;
        
    }
}

- (CGFloat) getRed
{
    return self.red;
}

- (CGFloat) getGreen
{
    return self.green;
}

- (CGFloat) getBlue
{
    return self.blue;
}

- (CGFloat) getAlpha
{
    return self.alpha;
}

- (CGFloat) getRGBRed
{
    return self.RGBRed;
}

- (CGFloat) getRGBGreen
{
    return self.RGBGreen;
}

- (CGFloat) getRGBBlue
{
    return self.RGBBlue;
}

- (CGFloat) getRGBAlpha
{
    return self.RGBAlpha;
}

- (CGFloat) getHue
{
    return self.hue;
}

- (CGFloat) getSaturation
{
    return self.saturation;
}

- (CGFloat) getBrightness
{
    return self.brightness;
}

- (UIColor *) getUIColor
{
    return self.color;
}

@end
