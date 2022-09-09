//
//  FutureDetailView.swift
//  Filmzilla
//
//  Created by Павло on 30.08.2022.
//

import SwiftUI

struct FutureDetailView: View {
    let film: FutureFilms
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingAddWatchedFilmView = false
    
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
                            
                        }else{
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 700, height: 350)
                                
                        }
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
                    
                    Divider()
                        .padding()
                    
                    if film.title != "" {
                        Text(film.title ?? "Unknown title")
                            .font(.headline)
                            .foregroundColor(.pink)
                    }else{
                        Text("*Unknown title*")
                            .font(.headline)
                            .foregroundColor(.pink)
                    }
                    
                    VStack(alignment: .center){
                        if film.director != ""{
                            Text("Director: \(film.director ?? "Unknow director")")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }else {
                            Text("Director: *Unknown*")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        if film.filmDescription != ""{
                            Text(film.filmDescription ?? "Unknown description")
                                .frame(width: 350)
                                .foregroundColor(.pink)
                                .padding(.top, 20)
                        }else {
                            Text("*No description*")
                                .frame(width: 350)
                                .foregroundColor(.pink)
                                .padding(.top, 20)
                        }
                    }
                    
                    Divider()
                        .padding()
                    Button{
                        showingAddWatchedFilmView = true
                    }label: {
                        VStack{
                            Label("Watched the film?", systemImage: "film.circle.fill")
                                .font(.headline)
                            
                            Label("Rate it!", systemImage: "star.fill")
                                .font(.headline)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    }
                    .padding(.bottom, 30)
                    
                }
            }
            .alert("Are you sure to delete this film?", isPresented: $showingDeletingAlert) {
                        Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive){
                    let futureFilm = film
                    moc.delete(futureFilm)
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddWatchedFilmView){
                AddWatchedFilmView(film: film)
            }
        }
    }
    
    
}

