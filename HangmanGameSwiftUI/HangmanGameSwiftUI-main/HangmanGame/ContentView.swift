//
//  ContentView.swift
//  HangmanGame
//
//  Created by user206660 on 10/30/21.
// Force Git

import SwiftUI

class HangmanGame: ObservableObject{
    @Published var failedAttempts = 0
    @Published var correctAttempts = 0
    @Published var characterGuesses: [String] = []
    @Published var chosenWord: String = ""  //word for this game
    @Published var gameOver: Bool = false
    @Published var gameStart: Bool = false
    @Published var chosenWordNoDuplicates: String = ""
    var wordOptions: [String] = [
    "FISH",
    "TIGER",
    "CAT",
    "ZEBRA",
    "GIRAFFE",
    "COW"
    ] //list of possible words
    
    func start(){
        self.gameOver = false
        self.gameStart = true
        self.chosenWord = wordOptions[Int.random( in: 0..<wordOptions.count)]
        self.characterGuesses = []
        self.failedAttempts = 0
        self.correctAttempts = 0
        var set = Set<Character>()
        self.chosenWordNoDuplicates = self.chosenWord.filter{set.insert($0).inserted}    
    }
    public func determineIfLetterInChosenWord(_ str: String){
        self.characterGuesses.append(str)
        if(chosenWord.contains(str)){
            self.correctAttempts += 1
            //fix for duplicate characters in string e.g. double f in Giraffe
            if(self.correctAttempts == self.chosenWordNoDuplicates.count){
                self.gameOver = true
            }
        }else{
            self.failedAttempts += 1
        }
        if(failedAttempts>9){
            self.gameOver = true
        }
    }
}

struct ContentView: View {
    @StateObject var game = HangmanGame()
    @State private var failedCount: Int = 0
    var body: some View {
        VStack{
            if(game.gameStart==false){
            Button(action: game.start) {
                Text("Play")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.title)
                        .cornerRadius(25)
                }
            }else{
                ZStack{
                    Group{
                        HangmanDisplay(game: game)
                    }
                }
                Spacer()
                HStack{
                    ForEach(0 ..< self.game.chosenWord.count, id: \.self) { i in
                        CharacterDisplay(c: String(self.game.chosenWord[i]), game: self.game)
                    }
                }
                if(game.gameOver){
                    Text("Game Over") //Style this
                    //Button here with text "Reset"
                    Button(action: game.start) {
                        Text("Reset")
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                            .padding(.all, 7.0)
                            .frame(width: 100.0, height: 35.0)
                    }
                    .background(Color.blue)
                    //Have the action call start method, which will pick a new word
                }else{
                    HStack {
                        AlphabeticLetter(n: "A", game: self.game)
                        AlphabeticLetter(n: "B", game: self.game)
                        AlphabeticLetter(n: "C", game: self.game)
                        AlphabeticLetter(n: "D", game: self.game)
                        AlphabeticLetter(n: "E", game: self.game)
                        AlphabeticLetter(n: "F", game: self.game)
                        AlphabeticLetter(n: "G", game: self.game)
                       
                    }
                    HStack {
                        AlphabeticLetter(n: "H", game: self.game)
                        AlphabeticLetter(n: "I", game: self.game)
                        AlphabeticLetter(n: "J", game: self.game)
                        AlphabeticLetter(n: "K", game: self.game)
                        AlphabeticLetter(n: "L", game: self.game)
                        AlphabeticLetter(n: "M", game: self.game)
                        AlphabeticLetter(n: "N", game: self.game)
                    }
                    HStack {
                        AlphabeticLetter(n: "O", game: self.game)
                        AlphabeticLetter(n: "P", game: self.game)
                        AlphabeticLetter(n: "Q", game: self.game)
                        AlphabeticLetter(n: "R", game: self.game)
                        AlphabeticLetter(n: "S", game: self.game)
                        AlphabeticLetter(n: "T", game: self.game)
                    }
                    HStack {
                        AlphabeticLetter(n: "U", game: self.game)
                        AlphabeticLetter(n: "V", game: self.game)
                        AlphabeticLetter(n: "W", game: self.game)
                        AlphabeticLetter(n: "X", game: self.game)
                        AlphabeticLetter(n: "Y", game: self.game)
                        AlphabeticLetter(n: "Z", game: self.game)
                    }
                }
            }//fist else
                
                
            } //close vStack
        } //close view
} //close struct


struct HangmanDisplay: View {
    @ObservedObject var game: HangmanGame
    var failedCount = 0
    var body:
        some View {
                if(game.failedAttempts>0){
                    Path { path in
                        path.move(to: CGPoint(x: 10, y: 300))
                        path.addLine(to: CGPoint(x: 10, y:300))
                        path.addLine(to: CGPoint(x: 90, y:300))
                    }
                    .stroke(Color.green, lineWidth: 5)
                }
                if(game.failedAttempts>1){
                    Path { path in
                        path.move(to: CGPoint(x: 50, y: 100))
                        path.addLine(to: CGPoint(x: 50, y:100))
                        path.addLine(to: CGPoint(x: 50, y:300))
                    }
                .stroke(Color.green, lineWidth: 5)
                }
                if(game.failedAttempts>2){
                    Path { path in
                        path.move(to: CGPoint(x: 50, y: 100))
                        path.addLine(to: CGPoint(x: 50, y:100))
                        path.addLine(to: CGPoint(x: 200, y:100))
                    }
                    .stroke(Color.green, lineWidth: 5)
                }
                if(game.failedAttempts>3){
                    Path { path in
                        path.move(to: CGPoint(x: 200, y: 100))
                        path.addLine(to: CGPoint(x: 200, y:100))
                        path.addLine(to: CGPoint(x: 200, y:130))
                    }
                    .stroke(Color.green, lineWidth: 5)
                }
                if(game.failedAttempts>4){
                    Circle()
                        .fill(Color.red)
                        .frame(width: 40, height: 40)
                        .position(x: 200, y: 150)
                }
                if(game.failedAttempts>5){
                    Path { path in
                        path.move(to: CGPoint(x: 200, y: 170))
                        path.addLine(to: CGPoint(x: 200, y:170))
                        path.addLine(to: CGPoint(x: 200, y:250))
                    }
                    .stroke(Color.green, lineWidth: 5)
                }
                if(game.failedAttempts>6){
                    Path { path in
                        path.move(to: CGPoint(x: 200, y: 190))
                        path.addLine(to: CGPoint(x: 200, y:190))
                        path.addLine(to: CGPoint(x: 170, y:160))
                    }
                    .stroke(Color.green, lineWidth: 5)
                }
                if(game.failedAttempts>7){
                    Path { path in
                        path.move(to: CGPoint(x: 200, y: 190))
                        path.addLine(to: CGPoint(x: 200, y:190))
                        path.addLine(to: CGPoint(x:230, y:160))
                    }
                    .stroke(Color.green, lineWidth: 5)
                }
                if(game.failedAttempts>8){
                    Path { path in
                        path.move(to: CGPoint(x: 200, y: 250))
                        path.addLine(to: CGPoint(x: 200, y:250))
                        path.addLine(to: CGPoint(x: 170, y:270))
                        }
                    .stroke(Color.green, lineWidth: 5)
                }
                if(game.failedAttempts>9){
                    Path { path in
                        path.move(to: CGPoint(x: 200, y: 250))
                        path.addLine(to: CGPoint(x: 200, y:250))
                        path.addLine(to: CGPoint(x: 230, y:270))
                    }
                    .stroke(Color.green, lineWidth: 5)
                }
        } //close View
} //close struct View


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice(PreviewDevice(rawValue: "iPhone 11"))
    }
}

struct AlphabeticLetter: View {
    let n: String
    @ObservedObject var game: HangmanGame
    @State var guessed: Bool = false
    var body: some View {
        Button(action: {
            self.guessed = true
            //determine if its right
            game.determineIfLetterInChosenWord(self.n)
        }){
            Text("\(n)")
                .font(.system(size: 30))
                .padding(.all, 7.0)
                .foregroundColor(.white)
                .frame(width: 40.0, height: 40.0)
        }
        .background(self.guessed ? Color.gray : Color.blue)
        .disabled(guessed == true)
    }
}

struct CharacterDisplay: View {
    let c: String
    @ObservedObject var game: HangmanGame
    //if this character is in the gueses, then display it
    var body: some View {
        Text("\(c)")
            .font(.system(size: 30))
            .foregroundColor(self.isCharacterGuessed() ? .black : .white)
            .frame(width: 40.0, height: 40.0)
            .border(Color.black, width: 1)
    }
    func isCharacterGuessed() -> Bool{
        if(game.characterGuesses.contains(c)){
            return true
        }else{
            return false
        }
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
