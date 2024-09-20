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
          try advancedPlayer?.seek(toOffset: 0.0)
      } catch {
          print("Failed to reset haptic player: \(error.localizedDescription)")
      }
  }

  func startVibrationIOS(data: String) -> Void {
        do {
          let patternData = Data(data.utf8)

          self.advancedPlayer = try engine.makeAdvancedPlayer(with: patternData);
          try self.advancedPlayer?.start(atTime: 0)
          print("Starting haptic player")

        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
  }

}
