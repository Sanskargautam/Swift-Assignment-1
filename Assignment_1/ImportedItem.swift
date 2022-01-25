//
//  RawTax.swift
//  Assignment_1
//
//  Created by Sanskar on 24/01/22.
//

import Foundation

class ImportedItem : Items
{
    override init(_ name:String,_ quantity:Int,_ price:Double)
    {
        super.init(name, quantity, price)
    }
    
    override func calculateTax() -> Double
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
    
    override func print()
    {
        super.print()
        Swift.print("Type  :  imported")
        Swift.print("Tax  :  \(calculateTax())")
        Swift.print("Total price  :  \(calculateTax() + self.price)")

        Swift.print()
        Swift.print("-------------------------------------------------")
    }
}
