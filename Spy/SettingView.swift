//
//  GameView.swift
//  Spy
//
//  Created by moein shishebor on 2024-07-19.
//

import SwiftUI

struct SettingView: View {
    @State private var isGameActive = false
    
    @State private var player_number :String = ""
    @State private var spy_number :String = ""
    @State private var category :String = ""
    @State private var timer: Int = 1
    
    let categories = ["Everything 👀"]
    
    @FocusState private var isInputActiveF1: Bool
    @FocusState private var isInputActiveF2: Bool
    
    
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.black
                    .ignoresSafeArea(.all)
                VStack{
                    Text("Setting")
                        .font(.largeTitle)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.black)
                        .bold()
                        .background(Color.green)
                        .cornerRadius(10)
                    
                    VStack{
                        HStack{
                            Text("Player No.")
                                .font(.system(size: 20))
                                .foregroundColor(.green)
                                .cornerRadius(20)
                            
                            TextField("", text:
                                        $player_number)
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .border(Color.green)
                            .cornerRadius(20)
                            .keyboardType(.numberPad)
                            .focused($isInputActiveF1)
                        }
                        .onTapGesture {
                            isInputActiveF1 = false
                        }
                        
                        HStack{
                            Text("Spy No.    ")
                                .font(.system(size: 20))
                                .foregroundColor(.green)
                                .cornerRadius(20)
                            
                            TextField("", text:
                                        $spy_number)
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .border(Color.green)
                            .cornerRadius(20)
                            .keyboardType(.numberPad)
                            .focused($isInputActiveF2)
                        }
                        .onTapGesture {
                            isInputActiveF2 = false
                        }
                        
                        HStack{
                            Text("Category")
                                .font(.system(size: 20))
                                .foregroundColor(.green)
                                .cornerRadius(20)
                            
                            Picker("Select Catefory", selection: $category){
                                ForEach(categories, id: \.self) { category in
                                    Text(category)
                                        .tag(category)
                                        .foregroundColor(.white)
//                                        .padding()
                                        .background(Color.black)
                                        .cornerRadius(8)
                                        .frame(width: 200)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 120)
                            .clipped()
                            .background(Color.black)
                        }
                            
                            HStack{
                                Text("Timer       ")
                                    .font(.system(size: 20))
                                    .foregroundColor(.green)
                                    .cornerRadius(20)
                                
                                Picker("Select Time", selection: $timer) {
                                    ForEach(1...5, id: \.self) { minute in
                                        Text("\(minute) min")
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(height: 120)
                                .clipped()
                                .background(.black)
                            }
                            .padding()
                        
                        HStack{
                            NavigationLink(value: isGameActive) {
                                Button(action: {
                                    startGame()
                                }){
                                    Text("Start")
                                        .font(.system(size: 20))
                                        .bold()
                                        .padding()
                                        .frame(width: 100, height: 60)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                    
                                    
                                }
                            }
                            .navigationDestination(isPresented: $isGameActive) {
                                GameView(player_number: player_number, spy_number: spy_number, category: category, timer: timer)
                            }

                        }
                        .padding()
                        }
                        .padding()
                        
                    }
                    .padding()
                    
                    
                }
            }
        }
    private func startGame() {
        isGameActive = true
    }
    }
    
#Preview {
    SettingView()
}
