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
    get {
        if self.age > 15 {
            return self._job
        }
        return nil;
    }
    set(value) {
        self._job = value;
    }
  }

  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {
        return self._spouse;
    }
    set(value) {
        if self.age >= 18 {
            self._spouse = value;
        } else {
            self._spouse = nil;
        }
    }
  }

  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }

  open func toString() -> String {
    let printVal: String = "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(self.job?.type) spouse:\(spouse?.firstName)]"
    print(printVal);
    return printVal;

  }
}

//////////////////////////////////////
//// Family
////
open class Family {
  fileprivate var members : [Person] = []

  public init(spouse1: Person, spouse2: Person) {
    spouse1._spouse = nil;
    spouse2.spouse = nil;
    spouse1._spouse = spouse2;
    spouse2._spouse = spouse1;
    members.append(spouse1);
    members.append(spouse2);
  }

  open func haveChild(_ child: Person) -> Bool {
    for person in members {
        if person.age >= 21 {
            members.append(child);
            return true;
        }
    }
    return false;
  }

  open func householdIncome() -> Int {
    var totalIncome: Int = 0;
    for person in members {
        totalIncome += person.job?.calculateIncome(2000) ?? 0;
    }
    return totalIncome;
  }
    
}

