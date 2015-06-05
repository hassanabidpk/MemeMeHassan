//
//  ViewController.swift
//  MemeMeHassan
//
//  Created by NexStreamingCorp on 6/5/15.
//  Copyright (c) 2015 NexStreamingCorp. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	
	@IBOutlet weak var imagePicker: UIImageView!
	
	@IBOutlet weak var cameraButton: UIBarButtonItem!
	
	@IBOutlet weak var topTextField: UITextField!
	
	@IBOutlet weak var bottomTextField: UITextField!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let blackColor = UIColor.blackColor()
		let memeTextAttributes = [
			NSStrokeColorAttributeName: UIColor.blackColor(),
			NSForegroundColorAttributeName: UIColor.blackColor(),
			NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
			NSStrokeWidthAttributeName: "2.0f"
		]
		
		topTextField.defaultTextAttributes = memeTextAttributes
		bottomTextField.defaultTextAttributes = memeTextAttributes
	}


	override func viewWillAppear(animated: Bool) {
		
		super.viewWillAppear(animated)
		cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
		
		self.subscribeToKeyboardNotifications()
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		
		self.unSubscribeToKeyboardNotifications()
	}


	@IBAction func pickAnImage(sender: UIBarButtonItem) {
		
		let pickerController = UIImagePickerController()
		pickerController.delegate = self
		pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
		self.presentViewController(pickerController, animated: true, completion: nil)
		
	}
	
	@IBAction func takeSnap(sender: UIBarButtonItem) {
		
		let pickerController = UIImagePickerController()
		pickerController.delegate = self
		self.presentViewController(pickerController, animated: true, completion: nil)
	}
	
	
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
		
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			self.imagePicker.image = image
		}
		
		
		self.dismissViewControllerAnimated(true, completion: nil)
		
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	func subscribeToKeyboardNotifications() {
	
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
		
	NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
	}
	
	
	
	func unSubscribeToKeyboardNotifications() {
		
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
		
		
	}
	
	func keyBoardWillHide(notification: NSNotification) {
		
		self.view.frame.origin.y += getKeyboardHeight(notification)
	}
	
	
	func keyboardWillShow(notification: NSNotification) {
	
		self.view.frame.origin.y -= getKeyboardHeight(notification)
	
	}
	
	
	func getKeyboardHeight(notification: NSNotification) -> CGFloat {
	
	
		let userInfo = notification.userInfo
		let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
		
		return keyboardSize.CGRectValue().height
	
	}
	
	func save() {
	
		let meme = Meme(text: topTextField.text!, image:imagePicker.image, memedImage: nil)
	}
	
	
}

