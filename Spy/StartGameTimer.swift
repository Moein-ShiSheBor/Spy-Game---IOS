//
//  GameView.swift
//  Spy
//
//  Created by moein shishebor on 2024-07-19.
//

import SwiftUI

struct StartGameTimer: View {
    
    var player_number :String
    var spy_number :String
    var category :String
    var timer :Int
    var selected_word: String
    
    @State private var finish: Bool = false
    @State private var isGameActive: Bool = false
    @State private var needSetting: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.black
                    .ignoresSafeArea(.all)
                VStack{
                    
                    NavigationLink(value: isGameActive) {
                    
                    let total_time = Int(timer * 60)
                        
                        VStack{
                            
                            CountdownTimerView(totalTime: TimeInterval(total_time))
                            
                            
                            
                            Button(action: {
                                finishGame()
                            }){
                                Text("Finish 🔎")
                                    .font(.largeTitle)
                                    .padding()
                                    .background(Color.orange)
                                    .foregroundColor(.black)
                                    .cornerRadius(20)
                            }
                            
                            .padding()
                            .alert(isPresented: $finish) {
                                Alert(
                                    title: Text("⌛️").bold(),
                                    message: Text("Word: \(selected_word)"),
                                    primaryButton: .default(Text("Start Over!"), action: {
                                        isGameActive = true
                                    }),
                                    secondaryButton: .cancel(Text("Change Setting"), action: {
                                        needSetting = true
                                    })
                                )
                            }
                        }
                    }
                }
                .navigationDestination(isPresented: $isGameActive) {
                    GameView(player_number: player_number, spy_number: spy_number, category: category, timer: timer)
                }
                .navigationDestination(isPresented: $needSetting) {
                    SettingView()
                }
                
            }
        }
        
    }
    private func finishGame(){
        finish = true
    }
    
}

//#Preview {
//    StartGameTimer(
//        player_number: "4",
//        spy_number: "1",
//        category: "Adventure",
//        timer: 2,
//        selected_word: "Word"
//    )
//}
