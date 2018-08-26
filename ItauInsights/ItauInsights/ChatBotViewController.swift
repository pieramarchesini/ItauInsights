//
//  ChatBotViewController.swift
//  ItauInsights
//
//  Created by Piera Marchesini on 26/08/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import UIKit
import Speech

class ChatBotViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "pt_br"))
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    var tapGesture: UITapGestureRecognizer?
    var tableView: TextsTableViewController?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var audioButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.audioButton.layer.cornerRadius = self.audioButton.frame.size.width/2
        self.textField.layer.cornerRadius = 20
        self.textField.layer.masksToBounds = true
        self.textField.layer.borderWidth = 0.5
        self.textField.layer.borderColor = UIColor.lightGray.cgColor
        
        if let table = self.childViewControllers.first as? TextsTableViewController {
            self.tableView = table
        }
        
        //Resign textField
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        self.requestSpeechAuthorization()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        self.textField.resignFirstResponder()
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == Notification.Name.UIKeyboardWillChangeFrame || notification.name == Notification.Name.UIKeyboardWillShow {
            view.frame.origin.y = -keyboardRect.height
        } else {
            view.frame.origin.y = 0
        }
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.audioButton.isEnabled = true
                case .denied:
                    self.audioButton.isEnabled = false
                case .restricted:
                    self.audioButton.isEnabled = false
                case .notDetermined:
                    self.audioButton.isEnabled = false
                }
            }
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isRecording == true {
            cancelRecording()
            isRecording = false
            audioButton.backgroundColor = UIColor(red: 45/255, green: 187/255, blue: 154/255, alpha: 1)
            if let text = self.textField.text, text != "" {
                self.tableView?.addMessage(text)
                self.textField.text = nil
            }
        } else {
            self.recordAndRecognizeSpeech()
            isRecording = true
            audioButton.backgroundColor = UIColor(red: 1, green: 108/255, blue: 108/255, alpha: 1)
        }
    }
    
    func cancelRecording() {
        audioEngine.stop()
        let node = audioEngine.inputNode
        node.removeTap(onBus: 0)
        recognitionTask?.cancel()
    }
    
    func sendAlert(message: String) {
        let alert = UIAlertController(title: "Speech Recognizer Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func recordAndRecognizeSpeech() {
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            self.sendAlert(message: "There has been an audio engine error.")
            return print(error)
        }
        guard let myRecognizer = SFSpeechRecognizer() else {
            self.sendAlert(message: "Speech recognition is not supported for your current locale.")
            return
        }
        if !myRecognizer.isAvailable {
            self.sendAlert(message: "Speech recognition is not currently available. Check back at a later time.")
            // Recognizer is not available right now
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                
                let bestString = result.bestTranscription.formattedString
                self.textField.text = bestString
            }
        })
    }
}

extension ChatBotViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        if let message = self.textField.text {
            tableView?.addMessage(message)
            self.textField.text = nil
        }
        return true
    }
}
