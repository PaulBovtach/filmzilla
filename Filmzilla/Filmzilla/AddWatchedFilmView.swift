//
//  AddWatchedFilm.swift
//  Filmzilla
//
//  Created by Павло on 31.08.2022.
//

import SwiftUI

struct AddWatchedFilmView: View {
    let film: FutureFilms
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    
    @State private var filmReview = ""
    @State private var rating = 3
    

    
    
    
    
    
    var body: some View {
        NavigationView{
            Form{
                //section1
                Section{
                    Text(film.title ?? "Unknown title")
                        .foregroundColor(.pink)
                    Text("Film director: \(film.director ?? "Unknown director")")
                        .foregroundColor(.pink)
                    Text("Genre: \(film.genre ?? "Unknown genre")")
                        .foregroundColor(.pink)
                    Text("Year of release: \(film.filmYear.formatted(.number.grouping(.never)))")
                        .foregroundColor(.pink)
                }
                //section2
                Section(header: Text("Description about \(film.title ?? "Unknown title")")){
                    Text(film.filmDescription ?? "Unknown description")
                        .foregroundColor(.pink)
                    
                }
                //section3
                Section(header: Text("Add a review about film")){
                    TextEditor(text: $filmReview)
                    
                }
                //section4
                Section{
                    RatingView(rating: $rating)
                }
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Done"){
                        let newWatchedFilm = WatchedFilms(context:moc)
                        
                        newWatchedFilm.id = film.id
                        newWatchedFilm.title = film.title
                        newWatchedFilm.filmDescription = film.filmDescription
                        newWatchedFilm.director = film.director
                        newWatchedFilm.genre = film.genre
                        newWatchedFilm.filmYear = film.filmYear
                        newWatchedFilm.storedImage = film.storedImage
                        newWatchedFilm.filmReview = filmReview
                        newWatchedFilm.rating = Int16(rating)
                        
                        let futurefilm = film
                        moc.delete(futurefilm)
                        
                        try? moc.save()
                        
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle("Film rating")
            .navigationBarTitleDisplayMode(.inline)
        }
        .accentColor(.pink)
        .environment(\.colorScheme, .dark)
    }
}


struct AddWatchedFilm_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

