 <!-- ![Logo](https://logo.png) -->

 ![Swift](https://img.shields.io/badge/language-Swift-blue.svg)

 Simple and easy way to use Core Data.

 ## Some awesome features of ActiveCoreData

 - CRUD actions
 - Search object by key and value

 ## Requirements

 - iOS 9.0+
 - Xcode 8.0+

 ## Sample project

 An example can be found in the project. Just download and run the .xcproject to see it in action.

 ## Installation

 ### Carthage

 github "jaisonv/ActiveCoreData"

 ### Manually

 Copy the class `ActiveCoreData.swift` to your project.

 ## Usage

 Create a new `Data Model` file having the same name as the project.

 > Eg.: Project.xcdatamodeld

 After creating the Core Data entities, select `Editor > Create NSManagedObject Subclass...`. This will generate the classes automatically.

 Now it's just necessary to import ActiveCoreData where you need to manipulate the entities (if it wasn't added manually).

 ### Create

 In the example we have an entity called `Animal`. If we want to create a new `Animal` just call `create()` as follows:

 ```swift
 // create animal
 let animal = Animal.create()

 // set attributes
 animal.species = "Dog"
 animal.breed = "Chihuahua"
 animal.name = "Rex"
 animal.color = "Black"

 ```

 ### Save

 To persist entity, simply call `save()`. After creating an entity it will only be persisted after this method is called.

 ```swift
 // persist animal
 animal.save()
 ```

 ### Find All

 `findAll()` will return an Array containing all the stored objects for that entity.

 ```swift
 let animals = Animal.findAll() as! [Animal]
 for animal in animals {
     print("Name: \(animal.name)")
     print("Breed: \(animal.breed)")
 }
 ```

 ### Find All By Attributes

 The method `findAll(attribute: String, value: String)` can be used to find an array of objects matching a specific attribute value. The attribute parameter is the property to search and the value parameter is its value.

 ```swift
 let animals = Animal.findAll(attribute: "name", value: "Rex") as! [Animal]
 for animal in animals {
     print("Name: \(animal.name)")
     print("Breed: \(animal.breed)")
 }
 ```
 ### Find First

 `findFirst()` finds the first persisted object of type 'Animal'.

 ```swift
 if let animal = Animal.findFirst() {
     print("Name: \(animal.name)")
     print("Breed: \(animal.breed)")
 }
 ```

 ### Find First By Attributes

 The method `findFirst(attribute: String, value: String)` can be used to find the first object matching a specific attribute value. The attribute parameter is the property to search and the value parameter is its value.

 ```swift
 if let animal = Animal.findFirstByAttribute("name", value: "Rex") {
     print("Name: \(animal.name)")
     print("Breed: \(animal.breed)")
 }
 ```

 ### Delete

 `delete()` will delete the persisted data.

 ```swift
 animal.delete()
 ```

 ## Contributing

 There are some stuff that would be nice to add and I will when I have more time. If you want to add something else or you have a feature request, just let me know.

 Features to add:
 - Asynchronous saving

 ## Licensing

  ActiveCoreData is released under MIT license. See [LICENSE](/LICENSE) for details.