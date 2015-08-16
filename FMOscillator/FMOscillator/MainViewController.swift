//
//  MainViewController.swift
//  FMOscillator
//
//  Created by Nicholas Arner on 6/20/15.
//  Copyright (c) 2015 Nicholas Arner. All rights reserved.
//

import Cocoa
import ORSSerial 


class MainViewController: NSViewController {
    
    let serialPortManager = ORSSerialPortManager.sharedSerialPortManager()
    let serialCommunicator = SerialCommunicator()


    let instrument = AKInstrument()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let availablePorts = ORSSerialPortManager.sharedSerialPortManager().availablePorts as! [ORSSerialPort]
        if availablePorts.count == 0 {
            println("No connected serial ports found. Please connect your Arduino or turn on Bluetooth..\n")
            exit(EXIT_SUCCESS)
        }
        
        /* Used for testing, we should now set the correct 
        serial port based on the value we get from the pop-up button.

        let serialPort = ORSSerialPort(path: "/dev/tty.usbmodem1411")
        serialCommunicator.serialPort = serialPort
        */
        
        
        /* Oscillator creation
        TO-DO: change to FMOscillator, with frequency and amplitude controlled by the
        received data from the potentiometers */
        let oscillator = AKFMOscillator()
        instrument.connect(oscillator)
        instrument.connect(AKAudioOutput(audioSource: oscillator))
        
        AKOrchestra.addInstrument(instrument)
        AKOrchestra.start()
    }
    
    
    /* TO-DO: this will be controlled by the received true/false 
    value from the push-button */
    @IBAction func startSound(sender: NSButton) {
        if !(sender.title == "Stop") {
            instrument.play()
            sender.title = "Stop"
        } else {
            instrument.stop()
            sender.title = "Play Sound"
        }
    }
    

    override func viewDidDisappear() {
        super.viewDidDisappear()
    }
}