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
  private var advancedPlayer: CHHapticAdvancedPatternPlayer?

  func prepareHaptics() {
      guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
      do {
        self.engine = try CHHapticEngine();
        try self.engine?.start()
      } catch {
        print("error when starting engine")
      }
    }


  func resetHaptics() {
      do {
          // Reset the player to the beginning of the pattern
          print("pausing haptic and resetting")

          try advancedPlayer?.pause(atTime: CHHapticTimeImmediate)
          try advancedPlayer?.seek(toOffset: 0)
      } catch {
          print("Failed to reset haptic player: \(error.localizedDescription)")
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
          let pattern = try CHHapticPattern(data: Data(data.utf8))
          self.advancedPlayer = try engine.makeAdvancedPlayer(with: pattern)
          try self.advancedPlayer?.start(atTime: CHHapticTimeImmediate)
          print("Starting haptic player")

        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }

  }


}
