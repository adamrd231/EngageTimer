//  Created by Adam Reed on 2/6/20.
//  Copyright © 2020 rdConcepts. All rights reserved.

// Notes
// find a way to get the layout to fill the whole screen?
// Add random noises to app
// add choice to change random noise.

// buttons still dark on dark mode
// need to create persistence for the data

import SwiftUI
import GoogleMobileAds

struct EngageTimerView: View {
//Properties
// =========
@EnvironmentObject var engageTimer: EngageTimer
@State var timer = Timer.publish(every: 1, on: .main, in: .common)

// State variable to bring up editing view
@State var editEngageTimerViewIsVisible = false
@State var textSize = CGFloat(70)
    
// Admob
var interstitial:Interstitial
init() { self.interstitial = Interstitial() }
@State var interstitialCount = 0
// ================================================================
    
// User Interface Views
var body: some View {
    
    NavigationView {
        Form {
            // Rounds Stack
            HStack {
                Text("Round").font(.largeTitle)
                Spacer()
                Text("\(self.engageTimer.round)").font(.custom("DS-Digital", size: textSize))
                Text("OF")
                Text("\(self.engageTimer.totalRounds)").font(.custom("DS-Digital", size: textSize))
                
                }.padding(5)
                    
            // Time Remaining Stack
            HStack {
                Text("Time").font(.largeTitle)
                Spacer()
                Text(String(format: "%01i:%02i", self.engageTimer.time / 60, self.engageTimer.time % 60))
                    .font(.custom("DS-Digital", size: textSize))
                    // Timer runs function every second
                    .onReceive(timer) { _ in
                        self.runEngageTimer()
                    }
            }.padding(5)
                    
           // Rest Stack
           // ==========
           HStack {
               Text("Rest").font(.largeTitle)
               Spacer()
               Text(String(format: "%01i:%02i", self.engageTimer.rest / 60, self.engageTimer.rest % 60))
                   .font(.custom("DS-Digital", size: textSize))
           }.padding(5)
       

           // Random Noise Choice & Count
           HStack {
            if self.engageTimer.usingRandomNoise {
                Text("\(self.engageTimer.noise)")
                    .font(.largeTitle).bold()
                Spacer()
                Text("\(self.engageTimer.noiseTotal)")
                    .font(.custom("DS-Digital", size: textSize))
            } else {
                EmptyView()
                }
            }.padding(5)
               
            // Engage Button Action & Design
            VStack (alignment: .center) {
                Button(action: {
                    self.pressedEngageTimerButton()
                })
                { Text("\(self.engageTimer.buttonTitle)") }
                    .font(.title)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Capsule().stroke(lineWidth: 2))
                    .foregroundColor(.black)
            }.padding(5)
            
            // Pause Button Action & Design
            VStack {
                Button(action: {
                    self.pressedPauseButton()
                    }
                ) { Text("\(self.engageTimer.pauseButtonTitle)") }
                      .font(.title)
                      .frame(minWidth: 0, maxWidth: .infinity)
                      .padding(10)
                      .background(Capsule().stroke(lineWidth: 2))
                    .foregroundColor(buttonColor)
            }
                .padding(5)
                .disabled(self.engageTimer.buttonTitle == "Engage")
            
            HStack{
                Spacer()
                BannerVC().frame(width: 320, height: 50, alignment: .center)
                Spacer()
            }
            
        }// Form Close
         // Navigation Bar Layout and Design
        .navigationBarTitle("Engage Timer", displayMode: .large)
        .navigationBarItems(trailing: Button("Edit") {
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


func runEngageTimer() {
    
    if self.engageTimer.time > 0 {
        if self.engageTimer.time == self.engageTimer.timeReset {
            playSound(sound: "boxing-bell-1", type: "wav")
        }
        self.engageTimer.time -= 1

        if self.engageTimer.randomArray.contains(self.engageTimer.time) {
            playSound(sound: "\(self.engageTimer.noise)", type: "mp3")
        }

    } else if self.engageTimer.rest > 0 {
        // Play the boxing bell x 3 to indicate rest started
        if self.engageTimer.rest == self.engageTimer.restReset {
            playSound(sound: "boxing-bell-3", type: "wav")
        }
        self.engageTimer.rest -= 1

    } else if self.engageTimer.round < self.engageTimer.totalRounds {
        self.engageTimer.round += 1
        self.engageTimer.resetTimeAndRest()
        self.engageTimer.createRandomNumberArray()

    } else {
        self.engageTimer.buttonTitle = "Engage"
        engageTimer.resetAllValues()
        self.cancelTimer()
        self.interstitial.showAd()
    }
}
    
func pressedEngageTimerButton() {
    // If Timer is running, stop Timer
    if self.engageTimer.timerIsRunning == true {
          self.cancelTimer()
          self.engageTimer.resetAllValues()
          self.engageTimer.buttonTitle = "Engage"
        
    // Timer has run some, but the user wants to reset to original settings
      } else if self.engageTimer.pauseButtonTitle == "Re-start" {
          self.cancelTimer()
          self.engageTimer.resetTimeAndRest()
          self.engageTimer.buttonTitle = "Engage"
          self.engageTimer.pauseButtonTitle = "Pause"
        
    // Starts the timer if it has not been started before.
      } else {
          // Capture reset values if timer is starting
          self.engageTimer.fillResetValues()
        // Create random number array
        self.engageTimer.createRandomNumberArray()
        // Create new timer
          self.instanstiateTimer()
        // Start running the new timer (Uses func runEngageTimer)
          self.timer.connect()
          self.engageTimer.buttonTitle = "Stop"
    }
}
    
func pressedPauseButton() {
    if self.engageTimer.timerIsRunning == true {
       //Pause the Timer
       self.cancelTimer()
       self.engageTimer.pauseButtonTitle = "Re-start"

     } else if self.engageTimer.buttonTitle == "Engage" {
       return
   } else {
       // Restart the Timer
       self.instanstiateTimer()
       self.timer.connect()
       self.engageTimer.pauseButtonTitle = "Pause"
     }
}
    
func instanstiateTimer() {
    self.engageTimer.timerIsRunning = true
    timer = Timer.publish(every: 1, on: .main, in: .common)
    return
}

func cancelTimer() {
    timer.connect().cancel()
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
    
final class Interstitial:NSObject, GADInterstitialDelegate{
    var interstitial:GADInterstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
    func LoadInterstitial(){
        let req = GADRequest()
        self.interstitial.load(req)
        self.interstitial.delegate = self
    }
    
    func showAd(){
        if self.interstitial.isReady{
           let root = UIApplication.shared.windows.first?.rootViewController
           self.interstitial.present(fromRootViewController: root!)
        }
       else{
           print("Not Ready")
       }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        LoadInterstitial()
    }
}
 

// =====================================================================
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EngageTimerView().environmentObject(EngageTimer())
    }
}
}
