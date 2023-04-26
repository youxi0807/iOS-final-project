//
//  ContentView.swift
//  final project
//
//  Created by User03 on 2023/4/19.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Song: Codable, Identifiable {
    @DocumentID var id: String?
    let name: String
    let singer: String
    let rate: Int
}
func createSong() {
    let db = Firestore.firestore()
    let song = Song(name: "陪你很久很久", singer: "小球", rate: 5)
    do {
        let documentReference = try db.collection("songs").addDocument(from: song)
        print(documentReference.documentID + "  add success")
    } catch{
        print(error)
    }
}
func fetchSongs(){
    let db = Firestore.firestore()
    db.collection("songs").getDocuments{
        snapshot, error in
        guard let snapshot=snapshot else {return}
        let songs = snapshot.documents.compactMap {snapshot in
            try? snapshot.data(as: Song.self)
        }
        print(songs)
    }
}
struct ContentView: View {
    @FirestoreQuery(collectionPath: "songs") var songs: [Song]
    @State private var info = ""
    var body: some View {
        /*List{
            ForEach(songs){song in
                HStack{
                    Text(song.name)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(song.singer)
                        Text("\(song.rate)")
                    }
                }
            }
        }*/
        VStack{
            Text(info)
            Button("register") {
                Auth.auth().createUser(withEmail: "001@gmail.com", password: "11111111") { result, error in
                            
                     guard let user = result?.user,
                           error == nil else {
                         print(error?.localizedDescription)
                         return
                     }
                     print(user.email, user.uid)
                }
            }
            Button("login") {
                Auth.auth().signIn(withEmail: "001@gmail.com", password: "11111111") { result, error in
                     guard error == nil else {
                        print(error?.localizedDescription)
                        return
                     }
                   print("success")
                }
            }
            Button("info") {
                if let user = Auth.auth().currentUser {
                   print(user.uid, user.email, user.displayName, user.photoURL)
                }
            }
            Button("add song") {
                createSong()
            }
            Button("show song") {
                fetchSongs()
                info = "000"
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
