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
    
    // Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
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
    
    
    func beginLesson(_ lessonIndex:Int){
        
        // Check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count{
            
            currentLessonIndex = lessonIndex
        }
        else{
            
            currentLessonIndex = 0
        }
        
        // Set the current lesson
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
    }
    
    
    func nextLesson() {
        
        // Advance the lesson index
        
        currentLessonIndex += 1

        // Check that it is in range
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        }
        else {
            // Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
        
        
        
        
        
    }
    
    func hasNextLesson() -> Bool {
        
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            
            return true
            
        }
        else {
            
            return false
        }
    }
}
