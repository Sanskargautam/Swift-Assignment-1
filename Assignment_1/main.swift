
//
//  main.swift
//  assignment1
//
//  Created by Sanskar on 11/01/22.
//
import Foundation

protocol Tax
{
    static func calculateTax(price : Double) -> Double
}

class RawTax : Tax
{
    static func calculateTax(price : Double) -> Double
    {
        return (0.125 * price)
    }
}

class ManufacturedTax : Tax
{
    static func calculateTax(price : Double) -> Double
    {
        return (0.125 * price + (0.02 * (price + (0.125 * price))))
    }
}

class ImportedTax : Tax
{
    static func calculateTax(price : Double) -> Double
    {
        let finalCost : Double = (0.01 * price) + price
        if( finalCost > 200)
        {
            return (0.05 * finalCost)
        }
        else if( finalCost > 100)
        {
            return (finalCost + 10)
        }
        return (finalCost + 5)
    }
}

class itemDetail
{
    private let name: String?
    private let quantity: Int
    private let price: Double?
    private let type: String?
    
    init(_ name:String,_ quantity:Int,_ price:Double,_ type:String)
    {
        self.name = name
        self.quantity = quantity
        self.price = price
        self.type = type
    }
    
    func getTax(price : Double) -> Double
    {
        let tax : Double
        switch self.type
        {
            case "raw":
            tax = RawTax.calculateTax(price: price)
            
            case "manufactured":
            tax = ManufacturedTax.calculateTax(price: price)
            
            case "imported":
            tax = ImportedTax.calculateTax(price: price)
            
            default:
            tax = 0
        }
        return tax
    }
    
    func printDetails()
    {
        let tax: Double = getTax(price: self.price!)
        
        Swift.print("Name  :  \(self.name!)")
        Swift.print("Price  :  \(self.price!)")
        Swift.print("Quantity  :  \(self.quantity)")
        Swift.print("Type  :  \(self.type!)")
        Swift.print("Tax  :  \(tax)")
        Swift.print("Total price  :  \(tax + self.price!)")
        Swift.print("Total price * Quantity  :  \((tax + self.price!) * (Double)(self.quantity))")

        print()
        Swift.print("-------------------------------------------------")
    }
}


var detailsOfAllItems = [itemDetail]() //array of object to store details of all users

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
    
        let user = itemDetail(name , quantity , price! , type!)
        detailsOfAllItems.append(user)
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
    
    for index in stride(from: 0 , to: detailsOfAllItems.count , by: 1) //calling all objects containing details of item to print
    {
        detailsOfAllItems[index].printDetails()
    }
}

main()
