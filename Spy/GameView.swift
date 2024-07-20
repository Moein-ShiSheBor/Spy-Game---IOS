//
//  GameView.swift
//  Spy
//
//  Created by moein shishebor on 2024-07-19.
//

import SwiftUI

struct GameView: View {
    
    
    var player_number :String
    var spy_number :String
    var category :String
    var timer :Int
    
    @State private var players_list: [Bool] = []
    @State private var selected_word: String = ""
    
    @State private var clickCount: Int = 1
    
    @State private var mistery: Bool = true
    
    @State private var start_game = false
    
    private func gamePreperation() -> String {
        var word: String
        
        word = getWordApi(category: category)
        
        let player_number_int = Int(player_number)!
        let spy_number_int = Int(spy_number)!
        
        let all_players = player_number_int + spy_number_int
        
        players_list.removeAll()
        
        for _ in 0..<(all_players) {
            players_list.append(false)
        }
        var set_spies:Int = 0
        
        while set_spies < spy_number_int{
            let spy_index = Int.random(in: 0..<(all_players))
            
            if players_list[spy_index] != true{
                players_list[spy_index] = true
                set_spies += 1
            }
            
        }
        return word
    }
    
    private func getWordApi(category: String) -> String {
        var api_word: String = ""
        
        let persianWords: [String] = [
            "جزیره",
            "دانشگاه",
            "روستا",
            "بیمارستان",
            "پاریس",
            "کشور",
            "کلیسای واتیکان",
            "شهرکرد",
            "نشیمنگاه",
            "رستوران",
            "لندن",
            "دادگاه تجدید نظر",
            "شیراز",
            "کلانتری",
            "مدار صفر درجه",
            "جزیره متروکه",
            "تالار عروسی",
            "تئاتر",
            "تاج محل",
            "جشنواره",
            "دستشویی",
            "مشهد",
            "حمام",
            "کوهستان",
            "رختخوابت",
            "درمانگاه",
            "پشت بام",
            "خیابان",
            "زندان",
            "آتشکده",
            "رادیولوژی",
            "اصفهان",
            "مجلس عروسی",
            "شهر",
            "دفتر ازدواج",
            "سینما",
            "هیمالیا",
            "آزمایشگاه",
            "مدرسه",
            "فروشگاه",
            "پاساژ",
            "تهران",
            "دماوند",
            "ده",
            "غار اصحاب کهف",
            "پالایشگاه",
            "استخر",
            "اورست",
            "ساندویچی",
            "شهربازی",
            "پارک",
            "قلعه",
            "ساری",
            "بندرعباس"
        ]
        
        let randomIndex = Int.random(in: 0..<(persianWords.count))
        
        api_word = persianWords[randomIndex]
        
        return api_word
    }
    
    var showing_text: String {
        if !mistery{
            if players_list[clickCount - 1] {
                return "You are spy 🥷🏻"
            } else {
                return mistery ? "?" : selected_word
            }
        } else {
            return mistery ? "?" : selected_word
        }
    }
    
    var next_player: String {
        if clickCount == (players_list.count){
            if mistery{
                return "Show"
            } else {
                return "Start Game"
            }
        }else{
            return mistery ? "Show" : "Next"
        }
        
    }
    
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.black
                    .ignoresSafeArea(.all)
                
                VStack{
                    Text(" Player - \(clickCount)")
                        .font(.largeTitle)
                        .frame(maxWidth: 200)
                        .bold()
                        .padding()
                        .foregroundColor(.green)
                        .border(Color.green)
//                        .background(Color.green)
                        .cornerRadius(10)
                        .padding()
                    
                    Text(showing_text)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .bold()
                        .foregroundColor(.black)
                        .background(Color.teal)
                        .cornerRadius(10)
                        .padding()
                    NavigationLink(value: start_game) {
                        Button(action: {
                            
                            if mistery {
                                mistery = false
                            }else{
                                if clickCount < players_list.count {
                                    clickCount += 1
                                    mistery = true
                                }
                                else{
                                    start_game = true
                                }
                            }
                        }){
                            Text(next_player)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }
                    .navigationDestination(isPresented: $start_game) {
                        StartGameTimer(player_number: player_number, spy_number: spy_number, category: category, timer: timer, selected_word: selected_word)
                    }
                }
            }
            .onAppear {
                selected_word = gamePreperation()
            }
        }
    }
}




//#Preview {
//    GameView(
//        player_number: "4",
//        spy_number: "1",
//        category: "Adventure",
//        timer: 2
//    )
//}
