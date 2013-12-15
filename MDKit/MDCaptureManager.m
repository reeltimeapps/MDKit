//
//  MDCaptureManager.m
//  MDKit
//
//  Created by Matthew Dicembrino on 6/24/12.
//
//

#import "MDCaptureManager.h"
#import "UIImage+WBImage.h"

@interface MDCaptureManager ()


@end

@implementation MDCaptureManager

#pragma mark - Public


- (void)createCaptureSession:(AVCaptureDevicePosition)position {
    self.devicePosition = position;
    [self changeFlashMode:self.flashMode];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self deviceInputAtPosition:position] error:nil];
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc]init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [_stillImageOutput setOutputSettings:outputSettings];
    
    self.session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    if ([_session  canAddInput:_videoInput]) {
        [_session addInput:_videoInput];
    }
    if ([_session canAddOutput:_stillImageOutput]) {
        [_session addOutput:_stillImageOutput];
    }

}

- (void)closeCaptureSession {
    if ([self.session isRunning]) {
        [self.session stopRunning];
    }
}

- (void)changeFlashMode:(AVCaptureFlashMode)mode {
    self.flashMode = mode;
    AVCaptureDevice *device = _videoInput.device;
    
    if ([device hasFlash]) {
        if ([device lockForConfiguration:nil]) {
            if ([device isFlashModeSupported:mode]) {
                [device setFlashMode:mode];
            }
            [device unlockForConfiguration];
        }
    }
}

- (void)captureStillImage {
    //Get connection from image output
    AVCaptureConnection *stillImageConnection = [self connectionWithMediaType:AVMediaTypeVideo fromConnections:_stillImageOutput.connections];
    
    //Set orientation, maybe we will want to support landscape.
    //If so, we will need to take advantage of the orientation propety we created.
    if ([stillImageConnection isVideoOrientationSupported]) {
        [stillImageConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }
    
    //Capture Image
    
    [_stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection
                                                   completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
                                                       if (imageDataSampleBuffer != NULL) {
                                                           NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                                                           ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                                                           [library writeImageDataToSavedPhotosAlbum:imageData
                                                                                            metadata:nil
                                                                                     completionBlock:^(NSURL *assetURL, NSError *error) {
                                                                                         [[[MDAssetsManager sharedInstance] defaultAssetsLibrary] assetForURL:assetURL
                                                                                                                                                  resultBlock:^(ALAsset *asset) {
                                                                                                                                                      self.captureCallback(asset, nil);
                                                                                                                                                  } failureBlock:^(NSError *error) {
                                                                                                                                                      self.captureCallback(nil, error);
                                                                                                                                                  }];
                                                                                     }];
                                                           //Write image to library
                                                                                                                      
                                                           //Notify the delegate that an image was captured successfully.
                                                           if ([self.delegate respondsToSelector:@selector(captureManagerStillImageCaptured:)]) {
                                                               //[self.delegate captureManagerStillImageCaptured:[UIImage rotate:image scale:image.size.width]];
                                                           }
                                                       }
                                                       else {
                                                           self.captureCallback(nil, error);
                                                       }
                                                       
                                                       
                                                   }];
}

#pragma mark - Private

- (AVCaptureDevice *)deviceInputAtPosition:(AVCaptureDevicePosition)position {
    if (position == AVCaptureDevicePositionBack) {
        return [self backFacingCamera];
    }
    return [self frontFacingCamera];
}

//Thanks Apple!

// Find a camera with the specificed AVCaptureDevicePosition, returning nil if one is not found
- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}

// Find a front facing camera, returning nil if one is not found
- (AVCaptureDevice *) frontFacingCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

// Find a back facing camera, returning nil if one is not found
- (AVCaptureDevice *) backFacingCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections {
	for ( AVCaptureConnection *connection in connections ) {
		for ( AVCaptureInputPort *port in [connection inputPorts] ) {
			if ( [[port mediaType] isEqual:mediaType] ) {
				return connection;
			}
		}
	}
	return nil;
}

@end
