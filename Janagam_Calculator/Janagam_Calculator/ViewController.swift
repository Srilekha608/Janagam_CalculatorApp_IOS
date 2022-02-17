//
//  ViewController.swift
//  Janagam_Calculator
//
//  Created by Janagam,Srilekha on 2/17/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewLoad: UILabel!
    
    var input1 = ""
    var input2 = ""
    var output = ""
    var operation = ""
    var currentInput = ""
    var onChangeOperation = false
    var onChainmode = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func AC(_ sender: UIButton) {
        clearAll()
    }
    func clearAll(){
        input1 = ""
        input2 = ""
        onChangeOperation = false
        operation = ""
        currentInput = ""
        viewLoad.text = ""
        onChainmode = false
    }
    func setData(_ number: String){
        if viewLoad.text == "0"{
            viewLoad.text = ""
        }
        else{
            if !onChangeOperation{
                viewLoad.text! += number
                input1 += number
            }
            else{
                if !onChainmode{
                    viewLoad.text! += number
                    input2 += number
                }
                else{
                    viewLoad.text = ""
                    viewLoad.text! += number
                    input2 += number
                }
            }
        }
    }
    
    func calTemp(_ operation:String)->String {
        if input1 != "" && input2 != ""{
            if operation == "+"{
                input1 = String(Double(input1)! + Double(input2)!)
                currentInput = input2
                input2 = ""
                return String(input1)
            }
            if operation == "-"{
                input1 = String(Double(input1)! - Double(input2)!)
                currentInput = input2
                input2 = ""
                
                return String(input1)
            }
            if operation == "*"{
                input1 = String(Double(input1)! * Double(input2)!)
                currentInput = input2
                input2 = ""
                return String(input1)
            }
            if operation == "/"{
                input1 = String(Double(input1)! / Double(input2)!)
                currentInput = input2
                input2 = ""
                return String(input1)
            }
            if operation == "%" {
                let s1 = Double(input1)!
                let s2 = Double(input2)!
                var r = s1.remainder(dividingBy: s2)
                input1 = String(r)
                currentInput = input2
                input2 = ""
                return String(input1)
            }
        }
        return ""
    }
    func outputFormatter(_ output:String)->String {
        let value = Double(output)!
        var outputStr = String(round(value * 100000) / 100000.0)
        
        if outputStr.contains(".0"){
            outputStr.removeSubrange(outputStr.index(outputStr.endIndex, offsetBy: -2)..<outputStr.endIndex)
        }
        
        return outputStr
}
    
    @IBAction func C(_ sender: UIButton) {
        input2 = ""
        viewLoad.text = ""
    }
    @IBAction func plusOrMinus(_ sender: UIButton) {
        if input1 == ""{
            viewLoad.text = "-" + viewLoad.text!
            input1 = "\(viewLoad.text!)"
        }
        else{
            viewLoad.text = "-" + viewLoad.text!
            input2 = "\(viewLoad.text!)"
        }
    }
    @IBAction func divide(_ sender: UIButton) {
        let temp = calTemp(operation)
        operation = "/"
        viewLoad.text = (temp != "") ? outputFormatter(temp) : ""
          if temp != "" {
              //            onChainmode = true
              if input2 != ""{
                  onChainmode = true
                  
                  if onChangeOperation {
                      output = String(Double(temp)! / Double(input2)!)
                      print(output)
                      if output == "inf"{
                        viewLoad.text! = "Error"
                      }else{
                        viewLoad.text! = outputFormatter(output)
                      }
                  }
              }
          }
          onChangeOperation = true
        
    }
    
    @IBAction func multiplication(_ sender: UIButton) {
        let temp = calTemp(operation)
        print("temp is \(temp)")
        operation = "*"
        currentInput=""
        viewLoad.text = (temp != "") ? outputFormatter(temp) : ""
         
        onChangeOperation = true
    }
    @IBAction func minus(_ sender: UIButton) {
        let temp = calTemp(operation)
        operation = "-"
       viewLoad.text = (temp != "") ? outputFormatter(temp) : ""
        if temp != "" {
            if input2 != ""{
                onChainmode = true
                currentInput = input2;
                if onChangeOperation {
                    output = String(Double(temp)! - Double(input2)!)
                   viewLoad.text! = outputFormatter(output)
                }
            }
        }
        onChangeOperation = true
    }
    @IBAction func plus(_ sender: UIButton) {
        let temp = calTemp(operation)
        print("temp is \(temp)")
        operation = "+"
        currentInput=""
        viewLoad.text = (temp != "") ? outputFormatter(temp) : ""
        onChangeOperation = true
    }
    
    @IBAction func equals(_ sender: UIButton) {
        var res = ""
        switch operation {
        case "+":
            
            if currentInput != "" {
                res = String(Double(input1)! + Double(currentInput)!)
                viewLoad.text = outputFormatter(res)
                 input2 = currentInput
            }else{
                res = String(Double(input1)! + Double(input2)!)
                viewLoad.text = outputFormatter(res)
            }
            input1 = res
            
            break
        case "*":
            if currentInput != "" {
                res = String(Double(input1)! * Double(currentInput)!)
                viewLoad.text = outputFormatter(res)
            }else{
                res = String(Double(input1)! * Double(input2)!)
                viewLoad.text = outputFormatter(res)
            }
            input1 = res
            
            break
        case "-":
            if currentInput != "" {
                res = String(Double(input1)! - Double(currentInput)!)
                viewLoad.text = outputFormatter(res)
                
            }else{
                res = String(Double(input1)! - Double(input2)!)
                viewLoad.text = outputFormatter(res)
               
            }
            input1 = res
            break
        case "/":
            if viewLoad.text == "Error"{
                clearAll()
            }else{
                if currentInput != "" {
                    res = String(Double(input1)! / Double(currentInput)!)
                    if res == "inf"{
                        viewLoad.text! = "Error"
                        return
                    }else{
                        viewLoad.text = outputFormatter(res)
                    }
                }else{
                    res = String(Double(input1)! / Double(input2)!)
                    if res == "inf"{
                        viewLoad.text! = "Error"
                        return
                    }else{
                        viewLoad.text = outputFormatter(res)
                    }
                }
                input1 = res
            }
            break
        case "%":
            if currentInput != "" {
                viewLoad.text = outputFormatter(res)
                let s1 = Double(input1)!
                let s2 = Double(currentInput)!
                var r = s1.remainder(dividingBy: s2)
                res = String(r)
                 input2 = currentInput
            }else{
                let s1 = Double(input1)!
                let s2 = Double(input2)!
                var r = s1.remainder(dividingBy: s2)
                res = String(r)
                viewLoad.text = outputFormatter(res)
            }
            input1 = res
            
            break
            
        default:
            print("IOS")
        }
    
    }
    
    @IBAction func remainder(_ sender: UIButton) {
        let temp = calTemp(operation)
        print("temp is \(temp)")
        operation = "%"
        currentInput=""
        viewLoad.text = (temp != "") ? outputFormatter(temp) : ""
         
        onChangeOperation = true
    }
    @IBAction func dot(_ sender: UIButton) {
        setData(".")
    }
    
    @IBAction func seven(_ sender: UIButton) {
        setData("7")
    }
    @IBAction func eight(_ sender: UIButton) {
        setData("8")
    }
    
    @IBAction func nine(_ sender: UIButton) {
        setData("9")
    }
    @IBAction func four(_ sender: UIButton) {
        setData("4")
    }
    
    @IBAction func five(_ sender: UIButton) {
        setData("5")
    }
    @IBAction func six(_ sender: UIButton) {
        setData("6")
    }
    
    @IBAction func one(_ sender: UIButton) {
        setData("1")
    }
    @IBAction func two(_ sender: UIButton) {
        setData("2")
    }
    @IBAction func three(_ sender: UIButton) {
        setData("3")
    }
    @IBAction func zero(_ sender: UIButton) {
        setData("0")
    }
    
    
}

