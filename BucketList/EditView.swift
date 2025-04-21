//
//  EditView.swift
//  BucketList
//
//  Created by Brian Chukwuisiocha on 2/27/25.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct EditView: View {
    
    @State private var visited = false
    @State private var processedImage: Image?
    @State private var selectedItem: PhotosPickerItem?
    let context = CIContext()

    @Environment(\.dismiss) var dismiss
    
    var onSave: (Location) -> Void
    
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                    Toggle("Visited", isOn: $visited)
                }
                
                
                Section("Add a picture 😄") {
                    PhotosPicker(selection: $selectedItem){
                        if let processedImage {
                            processedImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                        }
                    }
                    .buttonStyle(.plain)
                    .onChange(of: selectedItem, loadImage)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                if let processedImage {
                    ShareLink(item: URL(string: "https://maps-api.apple.com/v1/reverseGeocode?loc=\(viewModel.location.latitude)%2C\(viewModel.location.longitude)")!, preview: SharePreview("\(viewModel.name)", image: processedImage))
                }
                
                Button("Save") {
                    let newLocation = viewModel.createNewLocation()
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        _viewModel = State(initialValue: ViewModel(location: location))
    }
    
    func loadImage() {
        Task {
            if let selectedItem, let data = try? await selectedItem.loadTransferable(type: Data.self) {
                if let image = UIImage(data: data) {
                    let uiImage = image
                    processedImage = Image(uiImage: uiImage)
                }
            }
            
            selectedItem = nil
        }
    }
    
    
    
    
}

#Preview {
    EditView(location: .example) { _ in }
}
