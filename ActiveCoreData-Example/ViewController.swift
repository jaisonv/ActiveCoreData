//
//  ViewController.swift
//  ActiveCoreData-Example
//
//  Created by Jaison Vieira on 7/24/16.
//  Copyright © 2016 jaisonv. All rights reserved.
//

import UIKit
import ActiveCoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Create NSManagedObject
    func createExample() {
        
        // create animal
        let animal = Animal.create()
        
        // set attributes
        animal.species = "Dog"
        animal.breed = "Chihuahua"
        animal.name = "Rex"
        animal.color = "Black"
        animal.gender = Gender.male.rawValue as NSNumber?
        
        // persist animal
        animal.save()
    }
    
    // MARK: find all the persisted objects of type 'Animal'
    func findAllExample() {
        
        let animals = Animal.findAll() as! [Animal]
        for animal in animals {
            print("Name: \(animal.name)")
            print("Breed: \(animal.breed)")
        }
    }
    
    // MARK: Find all the persisted objects of type 'Animal' with name attribute 'Rex'
    func findAllByAttributeExample() {
        
        let animals = Animal.findAll(attribute: "name", value: "Rex") as! [Animal]
        for animal in animals {
            print("Name: \(animal.name)")
            print("Breed: \(animal.breed)")
        }
    }
    
    // MARK: Find the first persisted object of type 'Animal'
    func findFirstExample() {
        
        if let animal = Animal.findFirst() {
            print("Name: \(animal.name)")
            print("Breed: \(animal.breed)")
        }
    }
    
    // MARK: Find the first persisted object of type 'Animal' with name attribute 'Rex'
    func findFirstByAttributeExample() {
     
        if let animal = Animal.findFirst(attribute: "name", value: "Rex") {
            print("Name: \(animal.name)")
            print("Breed: \(animal.breed)")
        }
    }

    // MARK: Find the first persisted object of type 'Animal', update it and save
    func findFirstAndUpdateExample() {
        
        if let animal = Animal.findFirst() {
            print("Name: \(animal.name)")
            print("Breed: \(animal.breed)")
            
            animal.name = "Lucky" // change name
            animal.save() // save
            
            print("Name: \(animal.name)")
            print("Breed: \(animal.breed)")
        }
    }
    
    // MARK: Find the first persisted object of type 'Animal' and delete it
    func findFirstAndDeleteExample() {
        
        if let animal = Animal.findFirst() {
            print("Name: \(animal.name)")
            print("Breed: \(animal.breed)")
            
            animal.delete() // delete
        }
    }
    

    @IBAction func createButtonDidTouch(_ sender: Any) {
        createExample()
    }
    
    @IBAction func findAllButtonDidTouch(_ sender: Any) {
        findAllExample()
    }
    
    @IBAction func FindAllByAttributeButtonDidTouch(_ sender: Any) {
        findAllByAttributeExample()
    }
    
    @IBAction func findFirstButtonDidTouch(_ sender: Any) {
        findFirstExample()
    }
    
    @IBAction func findFirstByAttributeButtonDidTouch(_ sender: Any) {
        findFirstByAttributeExample()
    }
    
    @IBAction func findFirstAndUpdateButtonDidTouch(_ sender: Any) {
        findFirstAndUpdateExample()
    }
    
    @IBAction func findFirstAndDeleteButtonDidTouch(_ sender: Any) {
        findFirstAndDeleteExample()
    }
}







































