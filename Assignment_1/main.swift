
//
//  main.swift
//  assignment1
//
//  Created by Sanskar on 11/01/22.
//
import Foundation

protocol Tax
{
    func getType() -> String
    func calculateTax() -> Double
}

class ItemDetails
{
    var name: String
    var quantity: Int
    var price: Double
    
    init(_ name:String, _ quantity:Int, _ price:Double)
    {
        self.name = name
        self.quantity = quantity
        self.price = price
    }
}

class RawTax : ItemDetails, Tax
{
    override init(_ name:String,_ quantity:Int,_ price:Double)
    {
        super.init(name, quantity, price)
    }
    
    func getType() -> String
    {
        return "raw"
    }
    
    func calculateTax() -> Double
    {
        return (0.125 * price)
    }
}

class ManufacturedTax : ItemDetails, Tax
{
    override init(_ name:String,_ quantity:Int,_ price:Double)
    {
        super.init(name, quantity, price)
    }
    
    func getType() -> String
    {
        return "manufactured"
    }
    
    func calculateTax() -> Double
    {
        return (0.125 * price + (0.02 * (price + (0.125 * price))))
    }
}

class ImportedTax : ItemDetails, Tax
{
    override init(_ name:String,_ quantity:Int,_ price:Double)
    {
        super.init(name, quantity, price)
    }
    
    func getType() -> String
    {
        return "imported"
    }
    
    func calculateTax() -> Double
    {
        let finalCost : Double = (0.01 * price) + price
        if( finalCost > 200)
        {
            return ((0.05 * finalCost) - price )
        }
        else if( finalCost > 100)
        {
            return (finalCost + 10 - price)
        }
        return (finalCost + 5 - price )
    }
}

var detailsOfAllItems = [ItemDetails & Tax]() //array of object to store details of all item

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
        let userInputArray = inputValue.components(separatedBy: " ") //separating input string words by white spaces
        
        if(userInputArray[0] != "-name")
        {
            print(" \(wrongInput) : First value should be -name ")
            return
        }
        
        if(userInputArray.count == 1) // if after -name nothing present
        {
            print(wrongInput)
            return
        }
        
        var indexAfterName:Int = 0
        
        if(userInputArray[1].first == "-") // if second word start with - rather than name
        {
            print(" \(wrongInput) : Enter proper name ")
            return
        }
        
        for index in 2..<userInputArray.count // getting name of item "name can be of multiple words"
        {
            if let firstChar = userInputArray[index].first
            {
                if(firstChar == "-")
                {
                    indexAfterName = index
                    for counter in 1..<index
                    {
                        name += userInputArray[counter]
                    }
                    break
                }
            }
        }
        
        for index in stride(from: indexAfterName , to: userInputArray.count - 1, by: 2)
        {
            switch userInputArray[index]
            {
                case "-quantity":
                    if let quantityValue = (Int)(userInputArray[index+1])
                    {
                        if(quantityValue <= 0)
                        {
                            print("Invalid Quantity")
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
                    if let priceValue = (Double)(userInputArray[index+1])
                    {
                        price = priceValue
                    }
                    else
                    {
                        print(" \(wrongInput) : Invalid price type ")
                        return
                    }
            
                case "-type":
                    guard(userInputArray[index+1] == "raw" || userInputArray[index+1] == "manufactured" || userInputArray[index+1] == "imported")
                    else
                    {
                        print("""
                            \(wrongInput) : -type can be of only 3 types i.e. "raw" , "manufactured" , "imported"
                            """)
                        return
                    }
                    type = (userInputArray[index+1])
                
                
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
                let rawItem = RawTax(name, quantity, price!)
                detailsOfAllItems.append(rawItem)
                
            case "manufactured":
                let manufacteredItem = ManufacturedTax(name, quantity, price!)
                detailsOfAllItems.append(manufacteredItem)
                
            case "imported":
                let importedItem = ImportedTax(name, quantity, price!)
                detailsOfAllItems.append(importedItem)
                
            default:
                print("INVALID INPUT")
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
        Swift.print("Name  :  \(item.name)")
        Swift.print("Price  :  \(item.price)")
        Swift.print("Quantity  :  \(item.quantity)")
        Swift.print("Type  :  \(item.getType())")
        Swift.print("Tax  :  \(item.calculateTax())")
        Swift.print("Total price  :  \(item.calculateTax() + item.price)")

        print()
        Swift.print("-------------------------------------------------")
    }
}

main()
