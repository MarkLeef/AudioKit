//
//  AKAKMIDIFileChunk.swift
//  AudioKit
//
//  Created by Jeff Cooper on 11/1/18.
//  Copyright © 2018 AudioKit. All rights reserved.
//

import Foundation

public protocol AKMIDIFileChunk {
    var typeData: [UInt8] { get set }
    var lengthData: [UInt8] { get set }
    var data: [UInt8] { get set }
    init()
    init(typeData: [UInt8], lengthData: [UInt8], data: [UInt8])
}

extension AKMIDIFileChunk {

    public init(typeData: [UInt8], lengthData: [UInt8], data: [UInt8]) {
        self.init()
        self.typeData = typeData
        self.lengthData = lengthData
        self.data = data
        if !isValid {
            fatalError("Type and length must be 4 bytes long, length must equal amount of data")
        }
    }

    public var isValid: Bool { return isTypeValid && isLengthValid }
    var isTypeValid: Bool { return typeData.count == 4 && lengthData.count == 4 }
    var isLengthValid: Bool { return data.count == length }

    public var length: Int {
        return combine(bytes: lengthData)
    }

    public var type: MIDIFileChunkType? {
        return MIDIFileChunkType.init(data: typeData)
    }

    public var isHeader: Bool {
        return type == .header
    }

    public var isTrack: Bool {
        return type == .track
    }

    func combine(bytes: [UInt8]) -> Int {
        return Int(bytes.map(String.init).joined()) ?? 0
    }
}

public enum MIDIFileChunkType: String {
    case track = "MTrk"
    case header = "MThd"
    
    init?(data: [UInt8]) {
        let text = String(data.map({ Character(UnicodeScalar($0)) }))
        self.init(text: text)
    }

    init?(text: String) {
        self.init(rawValue: text)
    }

    public var text: String {
        return self.rawValue
    }
}
