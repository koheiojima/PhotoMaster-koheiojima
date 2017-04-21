//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 小島光平 on 2017/04/21.
//  Copyright © 2017年 小島光平. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentPickerController(sourceType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
self.dismiss(animated: true, completion: nil)
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    @IBAction func onTappedCamerabutton() {
        presentPickerController(sourceType: .camera)
    }
    
    @IBAction func onTappedAlnumButton() {
        presentPickerController(sourceType: .photoLibrary)
    }
    
    
    func drawText(image: UIImage) -> UIImage {
        
    let text = "LifeisTech!\niPhoneアプリ開発コース"
    let textFontAttributes = [
        NSFontAttributeName: UIFont(name: "Arial", size: 120)!,
        NSForegroundColorAttributeName: UIColor.red]
        
    UIGraphicsBeginImageContext(image.size)
    
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 5.0
        let textRect = CGRect(x: margin, y:margin, width: image.size.width - margin, height: image.size.height - margin)
        
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()

return newImage!
    }
    
    func drawMaskImage(image: UIImage) -> UIImage {
        
        let maskImage = UIImage(named: "icon1")!
        
        UIGraphicsBeginImageContext(image.size)
        
        image.draw(in: CGRect(x: 0,y:0, width: image.size.width, height: image.size.height))
        
        let margin: CGFloat = 5.0
        
        let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin,
                              y: image.size.height - maskImage.size.height - margin,
                              width: maskImage.size.width, height: maskImage.size.height)
        maskImage.draw(in: maskRect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func onTappedTextButton() {
        if photoImageView.image != nil {
            photoImageView.image = drawText(image: photoImageView.image!)
        } else {
            print("画像がありません")
        }
    }
    @IBAction func onTappedIllustButton() {
        if photoImageView.image != nil {
            photoImageView.image = drawMaskImage(image: photoImageView.image!)
        }else{
            print("画像がありません")
        }
    }
    
    @IBAction func onTappedUploadButton() {
        if photoImageView.image != nil {
            let activityVC = UIActivityViewController(activityItems: [photoImageView.image!,"#PhotoMaster"],
                                                      applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }else{
            print("画像がありません")
        }
    }
    
}



















