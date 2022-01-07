//
//  ContentModel.swift
//  LearningApp
//
//  Created by ANGEL RAMIREZ on 1/5/22.
//

import Foundation
import SwiftUI

class ContentModel:ObservableObject {
    
    @Published var modules = [Module]()
    
    var styleData: Data?
    
    init(){
        
        getLocalData()
    }
    
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
}
