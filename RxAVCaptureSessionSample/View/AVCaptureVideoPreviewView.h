//
//  AVCaptureVideoPreviewView.h
//  RxAVCaptureSessionSample
//
//  Created by Takeru Chuganji on 8/5/16.
//  Copyright © 2016 Takeru Chuganji. All rights reserved.
//

@import UIKit;
@import AVFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface AVCaptureVideoPreviewView : UIView
@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *layer;
@end

NS_ASSUME_NONNULL_END
