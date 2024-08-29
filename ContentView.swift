import SwiftUI
import UIKit

struct ContentView: View {
    @State private var selectedTab = 0

    @State private var gameTitle: String = ""
    @State private var gameCoverArtImage: Image?
    @State private var showingGameImagePicker = false
    @State private var gameInputImage: UIImage?
    @State private var gameEntries: [GameEntry] = []

    @State private var bookTitle: String = ""
    @State private var bookCoverArtImage: Image?
    @State private var showingBookImagePicker = false
    @State private var bookInputImage: UIImage?
    @State private var bookEntries: [BookEntry] = []

    @State private var movieTitle: String = ""
    @State private var movieCoverArtImage: Image?
    @State private var showingMovieImagePicker = false
    @State private var movieInputImage: UIImage?
    @State private var movieEntries: [MovieEntry] = []

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedTab) {
                    VStack {
                        List {
                            ForEach(gameEntries) { entry in
                                HStack {
                                    if let coverArt = entry.coverArtImage {
                                        coverArt
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }
                                    Text(entry.title)
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())

                        HStack {
                            TextField("Enter game title", text: $gameTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)

                            Button(action: {
                                self.showingGameImagePicker = true
                            }) {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .sheet(isPresented: $showingGameImagePicker) {
                                ImagePicker(image: self.$gameInputImage, coverArtImage: self.$gameCoverArtImage) // Pass coverArtImage binding to ImagePicker
                            }
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.1))

                        Button("Add Entry") {
                            addGameEntry()
                        }
                        .padding()
                    }
                    .tag(0)
                    
                    VStack {
                        List {
                            ForEach(bookEntries) { entry in
                                HStack {
                                    if let coverArt = entry.coverArtImage {
                                        coverArt
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }
                                    Text(entry.title)
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())

                        HStack {
                            TextField("Enter book title", text: $bookTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)

                            Button(action: {
                                self.showingBookImagePicker = true
                            }) {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .sheet(isPresented: $showingBookImagePicker) {
                                ImagePicker(image: self.$bookInputImage, coverArtImage: self.$bookCoverArtImage) // Pass coverArtImage binding to ImagePicker
                            }
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.1))

                        Button("Add Entry") {
                            addBookEntry()
                        }
                        .padding()
                    }
                    .tag(1)
                    
                    VStack {
                        List {
                            ForEach(movieEntries) { entry in
                                HStack {
                                    if let coverArt = entry.coverArtImage {
                                        coverArt
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    }
                                    Text(entry.title)
                                }
                            }
                        }
                        .listStyle(InsetGroupedListStyle())

                        HStack {
                            TextField("Enter movie or TV show title", text: $movieTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal)

                            Button(action: {
                                self.showingMovieImagePicker = true
                            }) {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .sheet(isPresented: $showingMovieImagePicker) {
                                ImagePicker(image: self.$movieInputImage, coverArtImage: self.$movieCoverArtImage) // Pass coverArtImage binding to ImagePicker
                            }
                        }
                        .padding()
                        .background(Color.secondary.opacity(0.1))

                        Button("Add Entry") {
                            addMovieEntry()
                        }
                        .padding()
                    }
                    .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .preferredColorScheme(.dark) // Set preferred color scheme to dark mode
            }
            .navigationBarTitle(getTitleForTab(), displayMode: .inline)
        }
    }

    func getTitleForTab() -> String {
        switch selectedTab {
        case 0:
            return "Game Backlog"
        case 1:
            return "Book Backlog"
        case 2:
            return "Movies & TV Backlog"
        default:
            return ""
        }
    }

    func addGameEntry() {
        guard !gameTitle.isEmpty else { return }
        let newEntry = GameEntry(title: gameTitle, coverArtImage: gameCoverArtImage)
        gameEntries.append(newEntry)
        gameTitle = ""
        gameCoverArtImage = nil
    }

    func addBookEntry() {
        guard !bookTitle.isEmpty else { return }
        let newEntry = BookEntry(title: bookTitle, coverArtImage: bookCoverArtImage)
        bookEntries.append(newEntry)
        bookTitle = ""
        bookCoverArtImage = nil
    }

    func addMovieEntry() {
        guard !movieTitle.isEmpty else { return }
        let newEntry = MovieEntry(title: movieTitle, coverArtImage: movieCoverArtImage)
        movieEntries.append(newEntry)
        movieTitle = ""
        movieCoverArtImage = nil
    }
}

// Define struct for game entry
struct GameEntry: Identifiable {
    var id = UUID()
    var title: String
    var coverArtImage: Image?
}

// Define struct for book entry
struct BookEntry: Identifiable {
    var id = UUID()
    var title: String
    var coverArtImage: Image?
}

// Define struct for movie & TV entry
struct MovieEntry: Identifiable {
    var id = UUID()
    var title: String
    var coverArtImage: Image?
}

// Define ImagePicker struct
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var coverArtImage: Image?
    @Environment(\.presentationMode) var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
                parent.loadImage()
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.image = nil
            parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func loadImage() {
        guard let inputImage = image else { return }
        let uiImage = Image(uiImage: inputImage)
        coverArtImage = uiImage
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

// PreviewProvider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
