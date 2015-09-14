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

- (NSArray*)setImage:(UIImage*)image;
-(UIColor *) getVibrantColor;
@end
