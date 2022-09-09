//
//  WatchedDetailView.swift
//  Filmzilla
//
//  Created by Павло on 04.09.2022.
//

import SwiftUI

struct WatchedDetailView: View {
    let film: WatchedFilms
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeletingAlert = false
    
    
    var body: some View {
        ScrollView{
            VStack{
                VStack(alignment: .center){
                    
                    ZStack{
                        if let image = film.storedImage, let uiimage = UIImage(data: image){
                            Image(uiImage: uiimage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 700, height: 350)

                            
                            VStack{
                                Text(film.genre ?? "Unknown genre")
                                    .font(.headline)
                                Text(film.filmYear.formatted(.number.grouping(.never)))
                                    .font(.caption)
                            }
                            .padding(10)
                            .background(Color.pink)
                            .clipShape(Capsule())
                            .offset(x: -120, y: 120)
                        }
                        
                    }
                    
                    Divider()
                        .padding()
                    
                    if film.title != "" {
                        Text(film.title ?? "Unknown title")
                            .font(.headline)
                            .foregroundColor(.pink)
                    }else{
                        Text("*Unknown title*")
                    }
                    
                    VStack(alignment: .center){
                        if film.director != ""{
                            Text("Director: \(film.director ?? "Unknown director")")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }else{
                            Text("Director: *Unknown*")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        if film.filmDescription != ""{
                            Text(film.filmDescription ?? "Unknown description")
                                .frame(width: 350)
                                .foregroundColor(.pink)
                                .padding(.top, 20)
                        }else{
                            Text("*No description*")
                                .frame(width: 350)
                                .foregroundColor(.pink)
                                .padding(.top, 20)
                        }
                    }
                    
                    Divider()
                        .padding()
                    VStack(alignment: .center){
                        Text("Review:")
                            .font(.headline)
                            .foregroundColor(.pink)
                        if film.filmReview != ""{
                            Text(film.filmReview ?? "No review")
                                .frame(width: 350)
                                .foregroundColor(.pink)
                                .padding(.top, 20)
                        }else{
                            Text("*No review*")
                                .frame(width: 350)
                                .foregroundColor(.pink)
                                .padding(.top, 20)
                        }
                    }
                    
                    Divider()
                        .padding()
                    
                    RatingView(rating: .constant(Int(film.rating)))
                        .font(.title)
                        .padding(.bottom, 20)
                    
                    
                }
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingDeletingAlert = true
                    }label: {
                        Image(systemName: "trash")
                    }
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Are you sure to delete this film?", isPresented: $showingDeletingAlert) {
                        Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive){
                    let watchedFilm = film
                    moc.delete(watchedFilm)
                }
        }
    }
}

}
