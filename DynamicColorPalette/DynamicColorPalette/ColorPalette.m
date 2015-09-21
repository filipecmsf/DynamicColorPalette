//
//  ColorPalette.m
//  ColorPalette
//
//  Created by Filipe Faria on 9/11/15.
//  Copyright (c) 2015 Filipe Faria. All rights reserved.
//

#import "ColorPalette.h"
#import "ColorPaletteObject.h"

#define TARGET_DARK_BRIGHTNESS 0.26f
#define MAX_DARK_BRIGHTNESS 0.45f

#define MIN_LIGHT_BRIGHTNESS 0.55f
#define TARGET_LIGHT_BRIGHTNESS 0.74f

#define MIN_NORMAL_BRIGHTNESS 0.3f
#define TARGET_NORMAL_BRIGHTNESS 0.5f
#define MAX_NORMAL_BRIGHTNESS 0.7f

#define TARGET_MUTED_SATURATION 0.3f
#define MAX_MUTED_SATURATION 0.4f

#define TARGET_VIBRANT_SATURATION  1.0f
#define MIN_VIBRANT_SATURATION 0.35f

#define WEIGHT_SATURATION 3.0f
#define WEIGHT_BRIGHTNESS 6.0f
#define WEIGHT_POPULATION 1.0f

@interface ColorPalette()

@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, assign) float highestSame;

@property(nonatomic, strong) UIColor *vibrant;
@property(nonatomic, strong) UIColor *vibrantLight;
@property(nonatomic, strong) UIColor *vibrantDark;
@property(nonatomic, strong) UIColor *muted;
@property(nonatomic, strong) UIColor *mutedLight;
@property(nonatomic, strong) UIColor *mutedDark;


@end

@implementation ColorPalette

- (void)setImage:(UIImage*)image
{
    
    self.highestSame = 0;
    
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    int size = height * width;
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    NSUInteger byteIndex = (bytesPerRow * 0) + 0 * bytesPerPixel;
    
    self.colors = [NSMutableArray arrayWithCapacity:size];
    
    for (int i = 0 ; i < size ; ++i)
    {
        
        CGFloat red   = (rawData[byteIndex]     * 1.0);
        CGFloat green = (rawData[byteIndex + 1] * 1.0);
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0);
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0);
        byteIndex += bytesPerPixel;
        
         ColorPaletteObject *colorPaletteObj = [[ColorPaletteObject alloc] init];
        [colorPaletteObj setRed:red green:green blue:blue alpha:alpha];
        
        if(![self hasColorAlready:colorPaletteObj]){
            [self.colors addObject:colorPaletteObj];
        }
    }
    
    free(rawData);
}

-(UIColor *) getVibrantColor{

    if(!self.vibrant){
        self.vibrant = [self findColorWithMinBri:MIN_NORMAL_BRIGHTNESS andMaxBri:MAX_NORMAL_BRIGHTNESS andTargetBri:TARGET_NORMAL_BRIGHTNESS andMinSat:MIN_VIBRANT_SATURATION andMaxSat:1.0f andTargetSat:TARGET_VIBRANT_SATURATION];
    }
    
    return self.vibrant;
}

-(UIColor *) getVibrantLightColor{
    
    if(!self.vibrantLight){
        self.vibrantLight =  [self findColorWithMinBri:MIN_LIGHT_BRIGHTNESS andMaxBri:1.0f andTargetBri:TARGET_LIGHT_BRIGHTNESS andMinSat:MIN_VIBRANT_SATURATION andMaxSat:1.0f andTargetSat:TARGET_VIBRANT_SATURATION];
    }
    
    return self.vibrantLight;
}

-(UIColor *) getVibrantDarkColor{
    if(!self.vibrantDark){
        self.vibrantDark = [self findColorWithMinBri:0.0f andMaxBri:MAX_DARK_BRIGHTNESS andTargetBri:TARGET_DARK_BRIGHTNESS andMinSat:MIN_VIBRANT_SATURATION andMaxSat:1.0f andTargetSat:TARGET_VIBRANT_SATURATION];
    }
    
    return self.vibrantDark;
}

-(UIColor *) getMutedColor{
    if(!self.muted){
        self.muted = [self findColorWithMinBri:MIN_NORMAL_BRIGHTNESS andMaxBri:1.0f andTargetBri:TARGET_NORMAL_BRIGHTNESS andMinSat:0.0f andMaxSat:MAX_MUTED_SATURATION andTargetSat:TARGET_MUTED_SATURATION];
    }
    
    return self.muted;
}

-(UIColor *) getMutedLightColor{
    if(!self.mutedLight){
        self.mutedLight = [self findColorWithMinBri:MIN_LIGHT_BRIGHTNESS andMaxBri:1.0f andTargetBri:TARGET_LIGHT_BRIGHTNESS andMinSat:0.0f andMaxSat:MAX_MUTED_SATURATION andTargetSat:TARGET_MUTED_SATURATION];
    }
    
    return self.mutedLight;
}

-(UIColor *) getMutedDarkColor{
    if(!self.mutedDark){
        self.mutedDark = [self findColorWithMinBri:0.0f andMaxBri:MAX_DARK_BRIGHTNESS andTargetBri:TARGET_DARK_BRIGHTNESS andMinSat:0.0f andMaxSat:MAX_MUTED_SATURATION andTargetSat:TARGET_MUTED_SATURATION];
    }
    return self.mutedDark;
}

#pragma mark - internal methods

- (BOOL) hasColorAlready:(ColorPaletteObject *) currentColor{
    
    if(currentColor.getAlpha < 0.5f || ([currentColor getRed] + [currentColor getGreen] + [currentColor getBlue] >= 600)){
        return YES;
    }
    
    int margin = 10;
    for (ColorPaletteObject *color in self.colors) {
        if(currentColor.getRed > color.getRed - margin && currentColor.getRed < color.getRed + margin &&
           currentColor.getGreen > color.getGreen - margin && currentColor.getGreen < color.getGreen + margin &&
           currentColor.getBlue > color.getBlue - margin && currentColor.getBlue < color.getBlue + margin){
            
            [color incrementSameColorCounter];
            if(self.highestSame < [color getSameColorCounter]){
                self.highestSame = [color getSameColorCounter];
            }
            
            return YES;
        }
        
    }
    
    return NO;
}

- (UIColor *) findColorWithMinBri:(float) minBri andMaxBri:(float) maxBri andTargetBri:(float) targetBri andMinSat:(float) minSat andMaxSat:(float) maxSat andTargetSat:(float) targetSat{
    
    float best = -1;
    ColorPaletteObject *vibrant;
    
    
    
    for (ColorPaletteObject *colorPaletteObj in self.colors) {
        if( colorPaletteObj.getRGBAlpha > 0.5 ){

            
            if(([colorPaletteObj getBrightness] < maxBri
                 && [colorPaletteObj getBrightness] > minBri
                 && [colorPaletteObj getSaturation] < maxSat
                 && [colorPaletteObj getSaturation] > minSat)){

                
                [self showDetails:colorPaletteObj];

                
                float balance = [self doBalanceWithSat:[colorPaletteObj getSaturation] andTargetSat:targetSat andBri:[colorPaletteObj getBrightness] andTargetBri:targetBri andPop:[colorPaletteObj getSameColorCounter]/self.highestSame andTargetPop:self.highestSame];
                if( balance > best){
                    vibrant = colorPaletteObj;
                    best = balance;
                }
            }
            else if(!vibrant){
                vibrant = colorPaletteObj;
            }
        }
    }
    
    NSLog(@"-----------\nhue = %f saturation = %f brightness = %f sameColor = %f", vibrant.getHue,vibrant.getSaturation, vibrant.getBrightness, vibrant.getSameColorCounter);
    return vibrant.getUIColor;
//    return nil;
}

- (float) doBalanceWithSat:(float)sat andTargetSat:(float)targetSat andBri:(float)bri andTargetBri:(float)targetBri andPop:(float)pop andTargetPop:(float)targetPop{

    float value = sat * WEIGHT_SATURATION + bri * WEIGHT_BRIGHTNESS + pop * WEIGHT_POPULATION;
    float total = targetSat + targetSat + targetPop;
    
    return fabsf(value / total);
}

- (void)showDetails:(ColorPaletteObject*) colorPaletteObj{
    
    NSLog(@"\n-----------------\nhue = %f \nsaturation = %f \nbrightness = %f \nsameColor = %f\n-----------------", colorPaletteObj.getHue, colorPaletteObj.getSaturation, colorPaletteObj.getBrightness, colorPaletteObj.getSameColorCounter);
}



@end
