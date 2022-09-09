//
//  WatchedFilmsView.swift
//  Filmzilla
//
//  Created by Павло on 27.08.2022.
//

import SwiftUI

struct WatchedFilmsView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.filmYear)
    ]) var watchedFilm: FetchedResults<WatchedFilms>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(watchedFilm){film in
                    ZStack{
                        HStack{
                            VStack(alignment: .leading){
                                if film.title != ""{
                                    Text(film.title ?? "Unknown title")
                                        .foregroundColor(.pink)
                                        .lineLimit(1)
                                }else {
                                    Text("*Unknown title*")
                                        .foregroundColor(.pink)
                                        .lineLimit(1)
                                }
                                Text(film.filmYear.formatted(.number.grouping(.never)))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            HStack{
                                
                                HStack(alignment: .center){
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.pink)
                                    Text("\(film.rating)/5")
                                }
                                
                                
                                if let image = film.storedImage, let uiimage = UIImage(data: image){
                                    Image(uiImage: uiimage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                }else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.pink)
                                }
                            }
                            
                        }
                        
                        NavigationLink{
                            WatchedDetailView(film: film)
                        }label: {
                            //
                        }
                        .opacity(0)
                    }
                }
                .onDelete(perform: deleteFilms)
            }
            .navigationTitle("Filmzilla")
            .accentColor(.pink)
        }
        .environment(\.colorScheme, .dark)
    }
    
    
    func deleteFilms(at offsets: IndexSet){
        for offset in offsets{
            let film = watchedFilm[offset]
            moc.delete(film)
        }
        try? moc.save()
    }
}

struct WatchedFilmsView_Previews: PreviewProvider {
    static var previews: some View {
        WatchedFilmsView()
    }
}
