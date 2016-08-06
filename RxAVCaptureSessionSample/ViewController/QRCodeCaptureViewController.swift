//
//  QRCodeCaptureViewController.swift
//  RxAVCaptureSessionSample
//
//  Created by Takeru Chuganji on 8/5/16.
//  Copyright © 2016 Takeru Chuganji. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class QRCodeCaptureViewController: UIViewController {
    
    @IBOutlet private weak var previewView: AVCaptureVideoPreviewView! {
        didSet {
            previewView.layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        }
    }
    @IBOutlet private weak var qrCodeValueLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session: AVCaptureSession
        do {
            let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            let deviceInput = try AVCaptureDeviceInput(device: device)
            session = AVCaptureSession()
            session.addInput(deviceInput)
        } catch _ {
            assertionFailure()
            return
        }
        let running = Variable(false)
        let metadataOutput = AVCaptureMetadataOutput()
        session.addOutput(metadataOutput)
        metadataOutput
            .rx_metadataObjectsDelegate(dispatch_get_main_queue())
            .observeDidOutputMetadataObjects()
            .map { objects, _ in
                (objects.first as? AVMetadataMachineReadableCodeObject)?.stringValue ?? ""
            }
            .bindTo(qrCodeValueLabel.rx_text)
            .addDisposableTo(disposeBag)
        metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        previewView.layer.session = session
        rx_sentMessage(#selector(viewWillAppear(_:)))
            .subscribeNext { _ in
                running.value = true
            }
            .addDisposableTo(disposeBag)
        rx_sentMessage(#selector(viewDidDisappear(_:)))
            .subscribeNext { _ in
                running.value = false
            }
            .addDisposableTo(disposeBag)
        running
            .asObservable()
            .observeOn(SerialDispatchQueueScheduler(
                internalSerialQueueName: "com.hoppenichu.rxavcapturesessionsample.qrcodecaptureviewcontroller.sessionqueue"
                ))
            .distinctUntilChanged()
            .bindTo(session.rx_runnning)
            .addDisposableTo(disposeBag)
    }
    
}
