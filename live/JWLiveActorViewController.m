//
//  JWLiveActorViewController.m
//  live
//
//  Created by Jungle Wind on 6/12/16.
//  Copyright © 2016 Jungle Wind. All rights reserved.
//

#import "JWLiveActorViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface JWLiveActorViewController()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong, nonatomic) AVCaptureSession *captureSession;

@end

@implementation JWLiveActorViewController

- (void)viewDidLoad {
    [self startRecording];
}

- (void)startRecording {
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]){
        self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    }
    // TODO: handle failure of high preset
    
    // in
    NSArray *devices = [AVCaptureDevice devices];
    for (AVCaptureDevice *d in devices){
        NSLog(@"Device name: %@",[d localizedName]);
        if ([d hasMediaType:AVMediaTypeVideo]){
            if ([d position] == AVCaptureDevicePositionFront){
                NSLog(@"Device position: front");
                // add front camera
                NSError *error;
                AVCaptureDeviceInput *videoDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:d error:&error];
                if ([self.captureSession canAddInput:videoDeviceInput]){
                    [self.captureSession addInput:videoDeviceInput];
                    NSLog(@"video device input added");
                }
            }else{
                NSLog(@"Device position: back");
                continue;
            }
        }else if ([d hasMediaType:AVMediaTypeAudio]){
            // add microphone
            NSError *error;
            AVCaptureDeviceInput *audioDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:d error:&error];
            if ([self.captureSession canAddInput:audioDeviceInput]){
                [self.captureSession addInput:audioDeviceInput];
                NSLog(@"audio device input added");
            }
        }
    }
        
    // out
    AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    videoDataOutput.videoSettings = nil;
    [videoDataOutput setSampleBufferDelegate:self queue:dispatch_queue_create("video_frames_queue", NULL)];
    if ([self.captureSession canAddOutput:videoDataOutput]){
        [self.captureSession addOutput:videoDataOutput];
        NSLog(@"video data output added");
    }
    
    // preview
    AVCaptureVideoPreviewLayer *videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    videoPreviewLayer.frame = self.view.bounds;
    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:videoPreviewLayer];
    
    [self.captureSession startRunning];
}

- (void)stopRecording {
    if (self.captureSession.isRunning){
        [self.captureSession stopRunning];
    }
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"%@ - %@  ",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    NSLog(@"sampleBuffer : %@",sampleBuffer);
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"%@ - %@  ",NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


#pragma mark - Getters & Setters
- (AVCaptureSession *)captureSession {
    if (!_captureSession){
        _captureSession = [[AVCaptureSession alloc] init];
    }
    return _captureSession;
}

@end
