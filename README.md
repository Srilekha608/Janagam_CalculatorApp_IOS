# Janagam_CalculatorApp_IOS
               func Average(input: [Double]) -> Double {
      var output : Double  = 0
      input.forEach{x in
      output = output + x
     }
      return output/Double(input.count)
                }
     var input1 = [1.6,6.6,7.0]
     print (Average(input: input1))
![image](https://user-images.githubusercontent.com/64957724/155569427-2a121729-6ab7-459e-be47-3da26e1633d2.png)
