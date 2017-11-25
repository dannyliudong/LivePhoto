//
//  ViewController.swift
//  LivePhoto
//
//  Created by liudong on 2017/11/25.
//  Copyright © 2017年 liudong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer:CALayer!
    var captureDevice: AVCaptureDevice!

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCamera()
    }
    
    func prepareCamera() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        let availableDecices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.front).devices
        captureDevice = availableDecices.first
        beginSession()
    }
    
    func beginSession() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = previewLayer
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.layer.frame
        captureSession.startRunning()
        
        let dataOutput = AVCaptureVideoDataOutput()
//        dataOutput.videoSettings = [String(kCVPixelBufferPixelFormatTypeKey) : Int(forKey: kCVPixelFormatType_32BGRA)]
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32BGRA)]
        dataOutput.alwaysDiscardsLateVideoFrames = true
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        captureSession.commitConfiguration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

