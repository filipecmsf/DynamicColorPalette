//
//  ColorPaletteObject.h
//  ColorPalette
//
//  Created by Filipe Faria on 9/11/15.
//  Copyright (c) 2015 Filipe Faria. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorPaletteObject : NSObject

- (void)setRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

- (CGFloat) getRed;
- (CGFloat) getGreen;
- (CGFloat) getBlue;
- (CGFloat) getAlpha;

- (CGFloat) getRGBRed;
- (CGFloat) getRGBGreen;
- (CGFloat) getRGBBlue;
- (CGFloat) getRGBAlpha;

- (CGFloat) getHue;
- (CGFloat) getSaturation;
- (CGFloat) getBrightness;

- (UIColor *) getUIColor;

@end
