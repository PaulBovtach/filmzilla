//
//  AddFutureFilmView.swift
//  Filmzilla
//
//  Created by Павло on 27.08.2022.
//

import SwiftUI

struct AddFutureFilmView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var director = ""
    @State private var genre = "Fantasy"
    @State private var filmDescription = ""
    @State private var filmYear = 2000
    
    var genres = ["Fantasy", "Action", "Adventure", "Animation", "Biography", "Comedy", "Crime", "Documentary", "Drama", "Family", "History", "Horror", "Musical", "Mystery", "Romance", "Sci-Fi", "Sport", "Thriller", "War", "Western"]
    var years = Array(1950...2022)
    
        @State private var image: Image?
        @State private var inputImage: UIImage?
        @State private var showImagePicker = false
    
    @FocusState var isKeyboardActive: Bool
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemPink]
    }
    
    //body
    var body: some View {
        NavigationView{
            Form{
                //section1
                Section{
                    TextField("Film title", text: $title)
                        .focused($isKeyboardActive)
                    TextField("Film director", text: $director)
                        .focused($isKeyboardActive)
                    Picker("Choose a genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Picker("Year of release", selection: $filmYear){
                        ForEach(years, id: \.self){
                            Text("\($0.formatted(.number.grouping(.never)))")
                        }
                    }
                    .pickerStyle(.wheel)
                }
                //section2
                Section{
                    Link(destination: URL(string: "https://www.themoviedb.org/")!) {
                        Label("Search description about *\(title)*", systemImage: "safari")
                    }
                }
                //section3
                Section(header: Text("Add a description about \(title)")){
                    TextEditor(text: $filmDescription)
                        .focused($isKeyboardActive)
                    Button{
                        showImagePicker = true
                    }label: {
                        Label("Choose an image", systemImage: "photo.on.rectangle.angled")
                    }
                    if inputImage != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    
                }
                
                
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Add"){
                        let newFutureFilm = FutureFilms(context: moc)
                        let binaryImage = inputImage?.jpegData(compressionQuality: 1.0)
                        
                        newFutureFilm.id = UUID()
                        newFutureFilm.title = title
                        newFutureFilm.director = director
                        newFutureFilm.filmYear = Int16(filmYear)
                        newFutureFilm.genre = genre
                        newFutureFilm.filmDescription = filmDescription
                        newFutureFilm.storedImage = binaryImage
                        
                        try? moc.save()
                        
                        
                        
                        dismiss()
                        
                    }
                }
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        isKeyboardActive = false
                    }
                }
            }
            
            .navigationTitle("I'd like to watch...")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.pink)
            .sheet(isPresented: $showImagePicker){
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in loadImage() }
        }.environment(\.colorScheme, .dark)
        //body
    }
    
    func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
}

struct AddFutureFilmView_Previews: PreviewProvider {
    static var previews: some View {
        AddFutureFilmView()
            
    }
}
