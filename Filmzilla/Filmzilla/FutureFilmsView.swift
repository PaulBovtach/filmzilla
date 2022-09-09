//
//  FutureFilmsView.swift
//  Filmzilla
//
//  Created by Павло on 27.08.2022.
//

import SwiftUI

struct FutureFilmsView: View {
    @State private var showingAddFutureFilm = false
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.filmYear)
    ]) var futureFilm: FetchedResults<FutureFilms>
    
    
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemPink]
    }
    
    var body: some View {
        NavigationView{
            
            List{
                ForEach(futureFilm){film in
                    
                    ZStack{
                        HStack{
                            VStack(alignment: .leading){
                                if film.title != ""{
                                    Text(film.title ?? "Unknow title")
                                        .foregroundColor(.pink)
                                        .lineLimit(1)
                                }else{
                                    Text("*Unknow title*")
                                        .foregroundColor(.pink)
                                        .lineLimit(1)
                                    
                                }
                                Text("\(film.filmYear.formatted(.number.grouping(.never)))")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
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
                        
                        NavigationLink{
                            FutureDetailView(film: film)
                        }label: {
                            //
                        }
                        .opacity(0)
                    }
                    
                }.onDelete(perform: deleteFilms)
                
            }
            
                
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            showingAddFutureFilm = true
                        } label: {
                            Label("Add Film", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddFutureFilm){
                    AddFutureFilmView()
                }
                .navigationTitle("Filmzilla")
                .accentColor(.pink)
                
        }.environment(\.colorScheme, .dark)
    }
    func deleteFilms(at offsets: IndexSet){
        for offset in offsets{
            let film = futureFilm[offset]
            moc.delete(film)
        }
        try? moc.save()
    }

}

struct FutureFilmsView_Previews: PreviewProvider {
    static var previews: some View {
        FutureFilmsView()
    }
}
