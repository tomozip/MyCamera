//
//  ViewController.swift
//  MyCamera
//
//  Created by 島田智貴 on 2018/02/08.
//  Copyright © 2018年 hakusan-labo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBOutlet weak var pictureImage: UIImageView!
  
  @IBAction func cameraButtonAction(_ sender: Any) {
    let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: { (action:UIAlertAction) in
        let ipc : UIImagePickerController = UIImagePickerController()
        ipc.sourceType = .camera
        ipc.delegate = self
        self.present(ipc, animated: true, completion: nil)
      })
      alertController.addAction(cameraAction)
    }
    
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      let photoLibraryAction = UIAlertAction(title: "フォトライブラリ", style: .default, handler: { (action:UIAlertAction) in
        let ipc : UIImagePickerController = UIImagePickerController()
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        self.present(ipc, animated: true, completion: nil)
      })
      alertController.addAction(photoLibraryAction)
    }
    
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
    alertController.addAction(cancelAction)
    // iPadで落ちてしまう対策
    alertController.popoverPresentationController?.sourceView = view
    present(alertController, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
    dismiss(animated: true, completion: {
      self.performSegue(withIdentifier: "showEffectView", sender: nil)
    })
  }
  
  // 画面遷移で渡す画像
  var captureImage : UIImage?
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let nextViewController = segue.destination as! EffectViewController
    nextViewController.originalImage = captureImage
  }
}

