//  Created by Adam Reed on 2/6/20.
//  Copyright © 2020 rdConcepts. All rights reserved.

// Notes
// find a way to get the layout to fill the whole screen?
// Add random noises to app
// add choice to change random noise.
// Add in random noise algorithm

// no need for resting on the final round, can just end the timer
// dark mode looks very weird (the buttons have a white background but not to the edge of the border.
// could the app make a bell noise even if the phone is on silent?

// need to create persistence for the data





import SwiftUI
import GoogleMobileAds

struct EngageTimerView: View {
    
//Properties
// =========
@EnvironmentObject var engageTimer: EngageTimer

@State var timer = Timer.publish(every: 1, on: .main, in: .common)

// Reset values used only for this View
@State var pauseButtonTitle = "Pause"
@State var timeReset = 0
@State var restReset = 0
@State var roundReset = 0
@State var noiseCountReset = 0

// State variable to bring up editing view
@State var editEngageTimerViewIsVisible = false
@State var textSize = CGFloat(70)
// ================================================================
    
// User Interface Views
var body: some View {
    
NavigationView {
    Form {
        // Rounds Stack
        // =============================
        HStack {
            Text("Round").font(.largeTitle)
            Spacer()
            Text("\(self.engageTimer.round)").font(.custom("DS-Digital", size: textSize))
            }
                
        // Time Remaining Stack
        // ====================
        HStack {
            Text("Time").font(.largeTitle)
            Spacer()
            Text(String(format: "%01i:%02i", self.engageTimer.time / 60, self.engageTimer.time % 60)).font(.custom("DS-Digital", size: textSize))
            // When timer is running, every second runs this code
                .onReceive(timer) { _ in
                    self.runEngageTimer()
                }
        }
                
       // Rest Stack
       // ==========
       HStack {
           Text("Rest").font(.largeTitle)
            Spacer()
           Text(String(format: "%01i:%02i", self.engageTimer.rest / 60, self.engageTimer.rest % 60)).font(.custom("DS-Digital", size: textSize))
       }
   

       // Random Noise Choice & Count
       // ===========================
       HStack {
           Text("\(self.engageTimer.noise)").font(.largeTitle).bold()
            Spacer()
            Text("\(self.engageTimer.noiseTotal)").font(.custom("DS-Digital", size: textSize))
       }
                
        // Button Action & Design
        // ======================
        VStack (alignment: .center) {
            Button(action: {
                self.pressedEngageTimer()
            })
            { Text("\(self.engageTimer.buttonTitle)") }
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(10)
                .background(Capsule().stroke(lineWidth: 2))
                .foregroundColor(.black)
            
                
        }.padding(5)
        
        VStack {
            Button(action: {
                          
              if self.engageTimer.timerIsRunning == true {
                  //Pause the Timer
                self.cancelTimer()
                self.pauseButtonTitle = "Re-start"
                
              } else if self.engageTimer.buttonTitle == "Engage" {
                return
            } else {
                // Restart the Timer
                self.instanstiateTimer()
                self.timer.connect()
                self.pauseButtonTitle = "Pause"
              }
                }
            ) { Text("\(self.pauseButtonTitle)") }
                  .font(.title)
                  .frame(minWidth: 0, maxWidth: .infinity)
                  .padding(10)
                  .background(Capsule().stroke(lineWidth: 2))
                .foregroundColor(buttonColor)
            
        }.padding(5).disabled(self.engageTimer.buttonTitle == "Engage") // VStack Close
        
        HStack{
            Spacer()
            BannerVC().frame(width: 320, height: 50, alignment: .center)
            Spacer()
        }
        
    }// Form Close
     // Navigation Bar Layout and Design
    .navigationBarTitle("Engage Timer", displayMode: .large)
    .navigationBarItems(trailing: Button("Edit") {
        self.engageTimer.buttonTitle = "Engage"
        self.cancelTimer()
        self.editEngageTimerViewIsVisible = true
    }.disabled(self.engageTimer.buttonTitle != "Engage"))
    
} // Navigation View Close
  // Present options sheet using binded variable and pass environment object
.sheet(isPresented: $editEngageTimerViewIsVisible){ EditEngageTimerOptionsView().environmentObject(self.engageTimer) }
} // View Closure

    
    
    
// Methods
// =============================================

    var buttonColor: Color {
        return self.engageTimer.buttonTitle == "Engage" ? .gray : .black
    }
    
func pressedEngageTimer() {
    if self.engageTimer.timerIsRunning == true {
          self.cancelTimer()
          self.resetAllValues()
          self.engageTimer.buttonTitle = "Engage"
      } else if self.pauseButtonTitle == "Re-start" {
          self.cancelTimer()
          self.resetTimeAndRest()
          self.engageTimer.buttonTitle = "Engage"
          self.pauseButtonTitle = "Pause"
      } else {
          // Capture reset values if timer is starting
          self.fillResetValues()
        // create the random number range
          self.createRandomNumberArray()
          print(self.engageTimer.randomArray)
          self.instanstiateTimer()
          self.timer.connect()
          playSound(sound: "boxing-bell-1", type: "wav")
          self.engageTimer.timerIsRunning = true
          self.engageTimer.buttonTitle = "Stop"
    }
}
    
    func createRandomNumberArray() {
        
        self.engageTimer.randomArray = []
        let range = engageTimer.time - 3
        
        for _ in 1...engageTimer.noiseTotal {
            engageTimer.randomNumber = Int.random(in: 2...range)
            
            while engageTimer.randomArray.contains(engageTimer.randomNumber) || engageTimer.randomArray.contains(engageTimer.randomNumber + 1) || engageTimer.randomArray.contains(engageTimer.randomNumber - 1) || engageTimer.randomArray.contains(engageTimer.randomNumber - 2) || engageTimer.randomArray.contains(engageTimer.randomNumber + 2) {
                engageTimer.randomNumber = Int.random(in: 2...range)
            }
            engageTimer.randomArray.append(engageTimer.randomNumber)
            
        }
        
    }
    
    
func runEngageTimer() {
    if self.engageTimer.time > 0 {
        
        self.engageTimer.time -= 1
        
        if self.engageTimer.randomArray.contains(self.engageTimer.time) {
            playSound(sound: "Single-clap", type: "mp3")
        }
        
    } else if self.engageTimer.rest > 0 {
        // Play the boxing bell x 3 to indicate rest started
        if self.engageTimer.rest == self.restReset {
            playSound(sound: "boxing-bell-3", type: "wav")
        }
        
        self.engageTimer.rest -= 1
        
    } else if self.engageTimer.round > 1 {
        
        self.engageTimer.round -= 1
        print(self.engageTimer.round)
        // Update the reset to use the users input numbers
        // FIX FIX FIX
        playSound(sound: "boxing-bell-1", type: "wav")
        self.resetTimeAndRest()
        self.createRandomNumberArray()
        print(self.engageTimer.randomArray)
        
    } else {
        self.engageTimer.buttonTitle = "Engage"
        resetAllValues()
        cancelTimer()
    }
}
    
    
func switchBoolValue() {
    self.engageTimer.timerIsRunning.toggle()
}
    
func resetAllValues() {
    self.engageTimer.round = self.roundReset
    self.engageTimer.time = self.timeReset
    
    self.engageTimer.rest = self.restReset
    self.engageTimer.noiseTotal = self.noiseCountReset
    // Reset Rounds
    self.engageTimer.round = self.roundReset
    // Reset Noise Total
    self.engageTimer.noiseTotal = self.noiseCountReset
}

func resetTimeAndRest() {
    // Reset the time
    self.engageTimer.time = self.timeReset
    // Display Time in clock format
    
    // Reset the Rest
    self.engageTimer.rest = self.restReset
    // Display Rest in clock format
    
}

func fillResetValues() {
    self.roundReset = self.engageTimer.round
    self.timeReset = self.engageTimer.time
    self.restReset = self.engageTimer.rest
    self.noiseCountReset = self.engageTimer.noiseTotal
}

func instanstiateTimer() {
    self.engageTimer.timerIsRunning = true
    self.timer = Timer.publish(every: 1, on: .main, in: .common)
    return
}

func cancelTimer() {
    self.timer.connect().cancel()
    self.engageTimer.timerIsRunning = false
}
    
    
// Google ADMOB
// ==================================
final private class BannerVC: UIViewControllerRepresentable  {

     func makeUIViewController(context: Context) -> UIViewController {
         let view = GADBannerView(adSize: kGADAdSizeBanner)

         let viewController = UIViewController()
         view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
         view.rootViewController = viewController
         viewController.view.addSubview(view)
         viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
         view.load(GADRequest())

         return viewController
     }

     func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
 }
 

// =====================================================================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EngageTimerView().environmentObject(EngageTimer())
    }
}
}
