//
//  ColorPalette.m
//  ColorPalette
//
//  Created by Filipe Faria on 9/11/15.
//  Copyright (c) 2015 Filipe Faria. All rights reserved.
//

#import "ColorPalette.h"
#import "ColorPaletteObject.h"

@interface ColorPalette()

@property (nonatomic, strong) NSMutableArray *colors;

@end

@implementation ColorPalette

- (NSArray*)setImage:(UIImage*)image
{
    
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
    
    return self.colors;
}



-(UIColor *) getVibrantColor{
    
    CGFloat biggerSaturation = 0;
    ColorPaletteObject *vibrant;
    
    for (ColorPaletteObject *colorPaletteObj in self.colors) {
        
        if(colorPaletteObj.getRGBAlpha > 0.5 && colorPaletteObj.getHue){
            if(biggerSaturation < colorPaletteObj.getSaturation){
                vibrant = colorPaletteObj;
                biggerSaturation = colorPaletteObj.getSaturation;
            }
        }
    }
    
    NSLog(@"hue = %f saturation = %f brightness = %f", vibrant.getHue,vibrant.getSaturation, vibrant.getBrightness);
    return vibrant.getUIColor;
}

-(UIColor *) getVibrantLightColor{
    return nil;
}

-(UIColor *) getVibrantDarkColor{
    return nil;
}

-(UIColor *) getMutedColor{
    return nil;
}

-(UIColor *) getMutedLightColor{
    return nil;
}

-(UIColor *) getMutedDarkColor{
    return nil;
}

#pragma mark - internal methods{

-(BOOL) hasColorAlready:(ColorPaletteObject *) color{
    ///TODO: implement validation
    return NO;
}

@end
