//
//  ContentView.swift
//  Wild Africa
//
//  Created by Sourabh Gapate on 16/05/21.
//

import SwiftUI

struct ContentView: View {
    
    let animals: [Animal] = Bundle.main.decode("animals.json")
    let haptic = UIImpactFeedbackGenerator(style: .medium)
    
    @State private var isGridViewActive: Bool = false
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Int = 1
    @State private var toolbarIcon: String = "square.grid.2x2"
    
    func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: gridColumn % 3 + 1)
        gridColumn = gridLayout.count
        print("Grid number: \(gridColumn)")
        
        // Toolbar image
        switch gridColumn {
        case 1:
            toolbarIcon = "square.grid.2x2"
        case 2:
            toolbarIcon = "square.grid.3x2"
        case 3:
            toolbarIcon = "rectangle.grid.1x2"
        default:
            toolbarIcon = "square.grid.1x2"
        }
    }
    
    var body: some View {
        NavigationView {
            
            Group {
                if !isGridViewActive {
                    List {
                        CoverImageView()
//                            .frame(height: 300)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        ForEach(animals) { animal in
                            
                            NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                AnimalListItemView(animal: animal)
                            }//: Link
                        }//: LOOP
                        
                        CreditsView()
                            .modifier(CenterModifier()) // This is a custom modifier - see Modifier group
                    }//: List
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(animals) { animal in
                                NavigationLink(
                                    destination: AnimalDetailView(animal: animal)) {
                                        AnimalGridItemView(animal: animal)
                                    }//: Link
                            }//: Loop
                        }//: LazyVGrid
                        .padding(10)
                        .animation(.easeIn)
                    }//:Scroll
                }//: Condition
            }//: Group
            .navigationBarTitle("Wild Africa", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        //List
                        Button(action: {
                            print("List view is activated")
                            isGridViewActive = false
                            haptic.impactOccurred()
                        }) {
                            Image(systemName: "square.fill.text.grid.1x2")
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .primary : .accentColor)
                        }
                        
                        //Grid
                        Button(action: {
                            print("Grid view is activated")
                            isGridViewActive = true
                            haptic.impactOccurred()
                            gridSwitch()
                        }) {
                            Image(systemName: toolbarIcon)
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .accentColor : .primary)
                        }
                    }//: HStack
                }//: Buttons
            }//: ToolBar
        }//: NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
