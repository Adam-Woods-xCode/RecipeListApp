//
//  RecipeModel.swift
//  RecipeListApp
//
//  Created by Adam Woods on 26/02/2021.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // Create an instance of data service and get the data
        self.recipes = DataService.getLocalData()
        
        
    }
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
         
            // Get a single servign size by multiplying the denomentaor by the recipe servings
            denominator *= recipeServings
            
            // Get target portion by multiplying the numerator by target servings.
            numerator *= targetServings
            
            // Reduce fraction by greatest common diviser
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            // Get whole portions if numberator is greater than denom
            if numerator >= denominator {
                wholePortions = numerator / denominator
                
                // % is the modular which gives you the left over ... eg 5/2 = 2.5 - % returns .5
                numerator = numerator % denominator
                
                //Assign to porsion string
                portion += String(wholePortions)
            }
            
            
            // Express the remainder as a fraction
            if numerator > 0 {
                //Assign remainder as fraction to portion string " " /"" (True/False)
                portion += wholePortions > 0 ? " " : ""
                portion += "\(numerator) / \(denominator)"
            }
        }
        
        if var unit = ingredient.unit {
            
            if wholePortions > 1 {
              
                // Calculate appropriate suffix
                if unit.suffix(2) == "ch" {
                    unit += "es"
            
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else {
                    unit += "s"
                }
            }
            
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            
            
            return portion + unit
        }
        return portion
    
    }
    
}
