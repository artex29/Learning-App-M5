//
//  ContentModel.swift
//  LearningApp
//
//  Created by ANGEL RAMIREZ on 1/5/22.
//

import Foundation
import SwiftUI

class ContentModel:ObservableObject {
    
    // List of Modules
    @Published var modules = [Module]()
    
    // Current Module
    @Published var currentModule:Module?
    var currentModuleIndex = 0
    
    var styleData: Data?
    
    
    init(){
        
        getLocalData()
    }
    
    // MARK: - Data Methods
    
    func getLocalData(){
        
        let jsonURL = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do{
        
            let jsonData = try Data(contentsOf: jsonURL!)
            
            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            
            self.modules = modules
        }
        catch{
            
            print("Couldn't parse local data")
        }
        
        
        
        let styleURL = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do{
            let styleData = try Data(contentsOf: styleURL!)
            self.styleData = styleData
            
        }
        catch{
            print("Couldn't parse style data")
            
        }
    }
    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleId: Int){
        
        // Find the index for this module ID
        for index in 0..<modules.count{
   
            if modules[index].id == moduleId{
                
                // Found the matching module
                
                currentModuleIndex = index
                
                break
                
                
            }
        }
        
        // Set the current module
        
        currentModule = modules[currentModuleIndex]
    }
}
