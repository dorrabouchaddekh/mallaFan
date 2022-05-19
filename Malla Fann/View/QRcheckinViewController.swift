//
//  QRcheckinViewController.swift
//  Malla Fann
//
//  Created by dorra on 16/5/2022.
//

    import UIKit
    import AVFoundation

    class QRcheckinViewController: UIViewController {

        var captureSession = AVCaptureSession()
        var videoPreviewLayer : AVCaptureVideoPreviewLayer?
        var qrcodeFrameView: UIView?
        var users = User()
        var userViewModel = UserViewModel()
        var _id: String?//        var location = Location()
        @IBOutlet weak var messageLabel: UILabel!
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "checkinConfirmation" {
                let destination = segue.destination as! OthersLinkViewController
                destination._id = self._id
                
            }
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            // get the back-facing camera
            guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                print("Failed to get the camera device")
                return
            }
            do {
                // Get an instance of the avCaptureDeviceInput class using the previous device object
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                //Set the input device on the capture session
                captureSession.addInput(input)
                
                //Initialize a AVCaptureMetadataOutput object and set is as the output device to the capture session
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                //Set delegate and use the default dispatch queue to execute the call back
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                
                //Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
                
                //Start video capture
                captureSession.startRunning()
                
                
                //Initialize QR code Frame to highlight the QR code
                qrcodeFrameView = UIView()
                if let qrcodeFrameView = qrcodeFrameView {
                    qrcodeFrameView.layer.borderColor = UIColor.blue.cgColor
                    qrcodeFrameView.layer.borderWidth = 3
                    view.bringSubviewToFront(qrcodeFrameView)
                }
            }
            catch {
                print(error)
                return
            }
        }
    }
    extension QRcheckinViewController : AVCaptureMetadataOutputObjectsDelegate {
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            //Check if the metadataObjects array is not nil and it contains at least one object
            if metadataObjects.count == 0 {
                qrcodeFrameView?.frame = CGRect.zero
                messageLabel.text = "No QR code is detected"
                return
            }
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if metadataObj.type == AVMetadataObject.ObjectType.qr {
                // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
                let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                qrcodeFrameView?.frame = barCodeObject!.bounds
                if metadataObj.stringValue != nil {
                    messageLabel.text = metadataObj.stringValue
                    self._id = metadataObj.stringValue
               
                }
                    //print(metadataObj.stringValue)
                   
                
                    performSegue(withIdentifier: "checkinConfirmation", sender: nil)
                self.captureSession.stopRunning()
                    //                    locationViewModel.retrieveLocById(idLoc: metadataObj.stringValue!){ [self] success, result in
//                        if success {
//                            print(result)
//                            checkin.location = result
//                            performSegue(withIdentifier: "checkinConfirmation", sender: checkin)
//                            }
                            
                      //  }
                    
                    
                
            }
        }
        
    }
