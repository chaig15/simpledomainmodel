//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
    var newAmt: Int = amount;
    if currency == "USD" {
        if to == "GBP" {
            newAmt = amount/2;
        } else if to == "CAN" {
            newAmt = Int(Double(amount) * 1.25);
        } else if to == "EUR" {
            newAmt = Int(Double(amount) * 1.5);
        }
        
    } else if currency == "GBP" {
        if to == "USD" {
            newAmt = amount * 2
        } else if to == "CAN" {
            return self.convert("USD").convert("CAN");
        } else if to == "EUR" {
            return self.convert("USD").convert("EUR");
        }
        
    } else if currency == "CAN" {
        if to == "USD" {
            newAmt = Int(Double(amount) / 1.25);
        } else if to == "GBP" {
            return self.convert("GBP");
        } else if to == "EUR" {
            return self.convert("USD").convert("CAN");
        }
        
    } else if currency == "EUR" {
        if to == "USD" {
            newAmt = Int(Double(amount) / 1.5);
        } else if to == "CAN" {
            return self.convert("USD").convert("CAN");
        } else if to == "GBP" {
            return self.convert("USD").convert("GBP");
        }
        
    }
    return Money(amount: newAmt, currency: to);
  }
  
  public func add(_ to: Money) -> Money {
    let newAmt: Int = self.convert(to.currency).amount
    return Money(amount: to.amount + newAmt, currency: to.currency)
  }
    
  public func subtract(_ from: Money) -> Money {
    let newAmt: Int = self.convert(from.currency).amount
    return Money(amount: newAmt - from.amount, currency: from.currency)
  }
}

//////////////////////////////////////
//// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }

  public init(title : String, type : JobType) {
    self.title = title;
    self.type = type;
  }

  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
    case .Hourly (let money):
        return Int(money * Double(hours));
    case .Salary (let money):
        return money;
    }
  }

  open func raise(_ amt : Double) {
    switch type {
    case .Hourly (let money):
        type = .Hourly(money + amt);
    case .Salary (let money):
        type = .Salary(money + Int(amt));

  }
}
}

//////////////////////////////////////
//// Person
////
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
    
  open var job : Job? {
    get { }
    set(value) {
    }
  }

  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { }
    set(value) {
    }
  }

  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }

  open func toString() -> String {
  }
}

//////////////////////////////////////
//// Family
////
//open class Family {
//  fileprivate var members : [Person] = []
//
//  public init(spouse1: Person, spouse2: Person) {
//  }
//
//  open func haveChild(_ child: Person) -> Bool {
//  }
//
//  open func householdIncome() -> Int {
//  }
//}
//
//
//
//
//
