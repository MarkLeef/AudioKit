// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AVFoundation

/// STK Flute
///
public class Flute: Node {
    
    /// Connected nodes
    public var connections: [Node] { [] }
    
    /// Underlying AVAudioNode
    public var avAudioNode = instantiate2(instrument: "flut")

    /// Initialize the STK Flute model
    public init() {}

    /// Trigger the sound with a set of parameters
    ///
    /// - Parameters:
    ///   - note: MIDI note number
    ///   - velocity: Amplitude or volume expressed as a MIDI Velocity 0-127
    ///
    public func trigger(note: MIDINoteNumber, velocity: MIDIVelocity = 127) {
        start()
        auBase.trigger(note: note, velocity: velocity)
    }
}
