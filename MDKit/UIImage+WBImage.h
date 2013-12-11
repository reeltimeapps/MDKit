// WBImage.h -- extra UIImage methods
// by allen brunson  march 29 2009

#import <UIKit/UIKit.h>

@interface UIImage (WBImage)

+ (UIImage *)rotate:(UIImage *)image scale:(NSInteger)scale;

@end