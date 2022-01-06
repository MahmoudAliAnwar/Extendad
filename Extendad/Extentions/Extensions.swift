//
//  Extensions.swift
//  Extendad
//
//  Created by mahmoud ali on 06/01/2022.
//


import UIKit

/**
 Extension on `Dictionary` that adds different helper methods such as JSON `Data` serialization
 */
public extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    /**
     Heper method that serializes the `Dictionary` to JSON `Data`
     
     - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
     */
    func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}

/**
 Extension on `Array` that adds different helper methods such as JSON `Data` serialization
 */
public extension Array where Element: Any {
    /**
     Heper method that serializes the `Array` to JSON `Data`
     
     - returns: `Data` containing the serialized JSON or empty `Data` (e.g. `Data()`) if the serialization fails
     */
    func toJsonData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            return Data()
        }
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround(WithCancelsTouchesInView flag: Bool = false) {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = flag
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIImageView {
    func addImageFromURL(urlString: String) {
        guard let imgURL: NSURL = NSURL(string: urlString) else { return }
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        NSURLConnection.sendAsynchronousRequest(
            request as URLRequest, queue: OperationQueue.main,
            completionHandler: {(response: URLResponse? ,data: Data? ,error: Error? ) -> Void in
                if error == nil {
                    self.image = UIImage(data: data!)
                }
        })
    }
    
}

extension String{
    var htmlToAttributedString: NSAttributedString? {
        guard
            let data = self.data(using: .utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    var determine : String{
        let dateNow = convert(date: NSDate(timeIntervalSince1970: TimeInterval(Int(TimeInterval(NSDate().timeIntervalSince1970)))) as Date)
        
        var now = getTime(date: dateNow)
        let date = getTime(date: self)
        let year = now.1 - date.1
        var month = now.0 - date.0
        now.0 += month < 0 ? 12: 0
        month = now.0 - date.0

         if year > 1{
            if month == 0 {
                return "\(year) year ago"
            }else {
            return "\(month) month ago, \(year - 1) year ago"
            }
         }else if month > 6 {
            return "\(month) month ago"
         }else if month < 6 && year == 1{
            if month == 0 {
                return "\(year) year ago"
            }else {
                return getTimeOfDay(date: self)
            }
         }
         else{
       return getTimeOfDay(date: self)
        }
    }

    func getTimeOfDay(date: String) -> String {
        let dateFormatter = DateFormatter()
       
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
  

        
        let newDate = dateFormatter.date(from:date)

       
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        let date = dateFormatter.string(from: newDate!)
       
        return date
    }
    
    func getTime(date: String) -> (Int, Int) {
        let dateFormatter = DateFormatter()
       
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
  

        
        let newDate = dateFormatter.date(from:date)

        dateFormatter.dateFormat = "MM"
        
   
        let month = dateFormatter.string(from: newDate!)
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: newDate!)
       
        return (Int(month) ?? 0, Int(year) ?? 0)
    }


       
    func convert(date: Date) -> String {
        //         let string = date

        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        //              let date = dateFormatter.date(from: string)!
//        dateFormatter.dateFormat = "dd_MM_yyyy"

        let dateString = dateFormatter.string(from: date)

        return dateString
    }
}

extension Date{
   
  
}



