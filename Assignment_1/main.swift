
//
//  main.swift
//  assignment1
//
//  Created by Sanskar on 11/01/22.
//
import Foundation

var detailsOfAllItems = [Items & Tax]() //array of object to store details of all item

func takeInput() -> ()
{
    var name:String = ""
    var quantity:Int = 1
    var price:Double?
    var type:String?
    
    let wrongInput: String = "Invalid Input format"
    
    print("Enter the Input")
    let value : String? = readLine()
    
    if(value!.isEmpty)
    {
        print(" \(wrongInput) : Please enter details ")
        return
    }
    
    if let inputValue = value // for having a input
    {
        let itemInputArray = inputValue.components(separatedBy: " ") //separating input string words by white spaces
        
        if(itemInputArray[0] != "-name")
        {
            print(" \(wrongInput) : First value should be -name ")
            return
        }
        
        if(itemInputArray.count == 1) // if after -name nothing present
        {
            print(wrongInput)
            return
        }
        
        var indexAfterName:Int = 0
        
        if(itemInputArray[1].first == "-") // if second word start with - rather than name
        {
            print(" \(wrongInput) : Enter proper name ")
            return
        }
        
        for index in 2..<itemInputArray.count // getting name of item "name can be of multiple words"
        {
            if let firstChar = itemInputArray[index].first
            {
                if(firstChar == "-")
                {
                    indexAfterName = index
                    for counter in 1..<index
                    {
                        name += itemInputArray[counter]
                    }
                    break
                }
            }
        }
        
        for index in stride(from: indexAfterName , to: itemInputArray.count - 1, by: 2)
        {
            switch itemInputArray[index]
            {
                case "-quantity":
                    if let quantityValue = (Int)(itemInputArray[index+1])
                    {
                        if(quantityValue <= 0)
                        {
                            print("\(wrongInput) :Invalid Quantity")
                            return
                        }
                        quantity = quantityValue
                    }
                    else
                    {
                        print(" \(wrongInput) : Invalid quantity type ")
                        return
                    }
                
                case "-price":
                    if let priceValue = (Double)(itemInputArray[index+1])
                    {
                        price = priceValue
                    }
                    else
                    {
                        print(" \(wrongInput) : Invalid price type ")
                        return
                    }
            
                case "-type":
                    guard(itemInputArray[index+1] == "raw" || itemInputArray[index+1] == "manufactured" || itemInputArray[index+1] == "imported")
                    else
                    {
                        print("""
                            \(wrongInput) : -type can be of only 3 types i.e. "raw" , "manufactured" , "imported"
                            """)
                        return
                    }
                    type = (itemInputArray[index+1])
                
                
                default:
                    print("\(wrongInput)")
                    return
            }
        }
        
        if(price == nil && type == nil)
        {
            print(" \(wrongInput) : -type and -price are mandatory fields ")
            return
        }
        else if(price == nil)
        {
            print(" \(wrongInput) : -price is mandatory field ")
            return
        }
        else if(type == nil)
        {
            print(" \(wrongInput) : -type is mandatory field ")
            return
        }
        
        switch type
        {
            case "raw":
                let rawItem = RawItem(name, quantity, price!)
                detailsOfAllItems.append(rawItem)
                
            case "manufactured":
                let manufacteredItem = ManufacturedItem(name, quantity, price!)
                detailsOfAllItems.append(manufacteredItem)
                
            case "imported":
                let importedItem = ImportedItem(name, quantity, price!)
                detailsOfAllItems.append(importedItem)
                
            default:
            print(wrongInput)
        }
        
    }
    else
    {
        print(wrongInput)
        return
    }
}

func main()
{
    var temp = true //temprory variable used to know if user want to enter more item
    while(temp)
    {
        takeInput()
        print("Do you want to enter details of any other item (Y/N)")
        let f : String? = readLine()!
        
        temp = (f == "Y" || f == "y") ? true : false //ternary Operator
    }
    
    print()
    print()
    
    for item in detailsOfAllItems//calling all objects containing details of item to print
    {
        item.print()
    }
}

main()
