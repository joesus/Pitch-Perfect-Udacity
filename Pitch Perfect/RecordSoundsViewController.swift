//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by A658308 on 8/11/15.
//  Copyright (c) 2015 Joe Susnick Co. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!

    var audioRecorder: AVAudioRecorder!
    var audioSession: AVAudioSession!
    var recordedAudio: RecordedAudio!

    override func viewWillAppear(animated: Bool) {
        stopButton.enabled = false;
    }

    @IBAction func recordAudio(sender: UIButton) {
        sender.enabled = false;
        recordingInProgress.hidden = false;
        stopButton.enabled = true;

        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let recordingName = "current-recording.wav"
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)

        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        // set the audio recorder instance
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self;
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record();
    }

    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden = true;
        recordButton.enabled = true;
        sender.enabled = false;
        
        audioRecorder.stop()
        audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("showPlaySoundViewController", sender: recordedAudio)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlaySoundViewController" {
            let playsoundVC = segue.destinationViewController as! PlaySoundViewController
            let data = sender as! RecordedAudio
            playsoundVC.receivedAudio = data
        }
    }
}

