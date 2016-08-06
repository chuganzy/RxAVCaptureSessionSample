//
//  AVCaptureVideoPreviewView.m
//  RxAVCaptureSessionSample
//
//  Created by Takeru Chuganji on 8/5/16.
//  Copyright © 2016 Takeru Chuganji. All rights reserved.
//

#import "AVCaptureVideoPreviewView.h"

@implementation AVCaptureVideoPreviewView

@dynamic layer;

+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

@end
