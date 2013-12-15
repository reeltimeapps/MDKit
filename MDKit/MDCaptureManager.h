//
//  MDCaptureManager.h
//  MDKit
//
//  Created by Matthew Dicembrino on 6/24/12.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MDAssetsManager.h"

typedef void (^MDCaptureManagerCaptureBlock)(ALAsset *asset, NSError *error);

@protocol MDCaptureManagerDelegate;

@interface MDCaptureManager : NSObject

@property (nonatomic, copy) void (^captureCallback)(ALAsset *asset, NSError *error);
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (assign, nonatomic) AVCaptureVideoOrientation orientation;
@property AVCaptureDevicePosition devicePosition;
@property AVCaptureFlashMode flashMode;

@property (assign) id <MDCaptureManagerDelegate> delegate;

- (void)createCaptureSession:(AVCaptureDevicePosition)position;
- (void)captureStillImage;
- (void)changeFlashMode:(AVCaptureFlashMode)mode;
- (void)closeCaptureSession;
@end


@protocol MDCaptureManagerDelegate <NSObject>
@optional
- (void) captureManager:(MDCaptureManager *)captureManager didFailWithError:(NSError *)error;
- (void) captureManagerStillImageCaptured:(UIImage *)image;
- (void) captureManagerDeviceConfigurationChanged:(MDCaptureManager *)captureManager;


@end