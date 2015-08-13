//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by A658308 on 8/11/15.
//  Copyright (c) 2015 Joe Susnick Co. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController  {

    var audioPlayer = AVAudioPlayer()
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    var error: NSError?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playAudioWithVariableSpeed(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        playAudioWithVariableSpeed(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func playAudioWithVariableSpeed(speed: Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        audioPlayer.rate = speed
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        
        let audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: &error)
        
        audioEngine.stop()
        audioPlayer.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)

        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)

        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(audioPlayerNode, to: audioEngine.outputNode, format: nil)
        
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }
}
