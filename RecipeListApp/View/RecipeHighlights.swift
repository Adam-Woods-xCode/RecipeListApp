//
//  RecipeHighlights.swift
//  RecipeListApp
//
//  Created by Adam Woods on 26/02/2021.
//

import SwiftUI

struct RecipeHighlights: View {
    
    
    var allHighlights = ""
    
    init(highlights:[String]) {
        
        // Loop through highlights and build the string
        for index in 0..<highlights.count {
            
            //If this is the last item, don't add comma
            if index == highlights.count-1 {
                allHighlights += highlights[index]
            }
            else {
                allHighlights += highlights[index] + ", "
            }
        }
        
    }
    
    var body: some View {
        Text(allHighlights)
   
    }
}

struct RecipeHighlights_Previews: PreviewProvider {
    static var previews: some View {
        RecipeHighlights(highlights: ["test 1", "test 2"])
    }
}
