//
//  RecipeFeaturedView.swift
//  RecipeListApp
//
//  Created by Adam Woods on 26/02/2021.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 1
    
    var body: some View {
        
        
        VStack(alignment: .leading) {
            
            Text("Featured Recipes")
                .font(.largeTitle)
                .padding(.top)
                .padding(.leading)
            
           
            GeometryReader { geo in
                
                TabView (selection: $tabSelectionIndex){
                    
                    //Loop through each recipe
                    ForEach (0..<model.recipes.count) { index in
                        
                        // Only show those that show true as featured
                        if model.recipes[index].featured == true {
                        
                            Button(action: {
                                self.isDetailViewShowing = true
                            },
                            label: {
                                ZStack {
                                //Recipe card
                                Rectangle()
                                    .foregroundColor(.white)
                                    
                                
                                VStack(spacing: 0) {
                                    Image(model.recipes[index].image)
                                        .resizable()
                                        .clipped()
                                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                    Text(model.recipes[index].name)
                                        .padding(5)
                                }
                                    
                                }
                            })
                            .tag(index)
                            .sheet(isPresented: $isDetailViewShowing) {
                                RecipeDetailView(recipe:model.recipes[index])
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100)
                            .cornerRadius(20)
                            .shadow(radius: 30)
                            
                        }
                    }
                    
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            VStack(alignment: .leading) {
                Text("Preparation")
                    .bold()
                
                Text(model.recipes[tabSelectionIndex].prepTime)
                Text("Highlights")
                    .bold()
                RecipeHighlights(highlights:model.recipes[tabSelectionIndex].highlights)
                
            }
            .padding(.leading)
        }
        .onAppear(perform: {
            setFeaturedIndex()
        })
        .padding(.leading)
        .padding(.bottom)
        
        
        
        
    }
    
    func setFeaturedIndex() {
        
        var index = model.recipes.firstIndex { (recipe) -> Bool in
            return recipe.featured
            }
        tabSelectionIndex = index ?? 0
        }
    }


struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
