//
//  HapticEngine.swift
//  gaimon
//
//  Created by Dimitri Dessus on 28/01/2022.
//

import Foundation
import CoreHaptics

@available(iOS 13.0, *)
class HapticEngineManager: NSObject {
  private var engine: CHHapticEngine!
  private var continuousPlayer: CHHapticPatternPlayer!
  
  func prepareHaptics() {
      guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
      do {
        self.engine = try CHHapticEngine();
        try self.engine?.start()
      } catch {
        print("error when starting engine")
      }
    }


    func stopHaptics() {
        do {
            try cotinuousPlayer?.stop(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to stop haptic player: \(error.localizedDescription)")
        }
    }

  func startVibrationIOS(data: String) -> Void {
    
    var events = [CHHapticEvent]()
    

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
          try engine?.playPattern(from: Data(data.utf8))
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }


  }

}
