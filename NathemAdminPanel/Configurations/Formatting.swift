//
//  Formatting.swift
//  ClasseraSP
//
//  Created by Ammar AlTahhan on 16/05/2018.
//  Copyright © 2018 Ammar AlTahhan. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    var meduimTimeFormatting: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
    var mediumDateFormtting: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    var shortTimeFormatting: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    var shortDateFormatting: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    var endsIn: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day]
        formatter.unitsStyle = .full
        let string = formatter.string(from: Date(), to: self)!
        if let idx = string.index(of: " "), let remDays = Int(String(string[..<idx]).replacingOccurrences(of: ",", with: "")) {
            if remDays < 0 {
                return "0"
            } else if remDays == 0  {
                return "1"
            } else if remDays > 99 {
                return "99+"
            } else {
                return "\(remDays)"
            }
        }
        return ""
    }
    var hoursOrMinutesSince: String {
        if hoursSince[0..<1] == "0" {
            return minutesSince
        }
        return hoursSince
    }
    var hoursSince: String {
        let timeInterval = timeIntervalSinceNow * -1
        let hours = Int((timeInterval / 3600).rounded())
        if hours < 1 {
            return "Now"
        } else {
            return "\(hours) hours"
        }
    }
    var minutesSince: String {
        let timeInterval = timeIntervalSinceNow * -1
        let minutes = Int(((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60).rounded())
        
        return "\(minutes) minutes"
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    var apiDateFormatting: Date? {
        guard self != "" else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var date: Date? = formatter.date(from: self)
        if date == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            date = formatter.date(from: self)
        }
        return date
    }
    var percentEncoded: String {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return self.addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)!
    }
    var backSlashesRemoved: String {
        return self.replacingOccurrences(of: "\r\n", with: "")
    }
    var hexToUIColor: UIColor {
        var cString:String = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    public var replacedArabicDigitsWithEnglish: String {
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }

}

extension CGFloat {
    func rounded(toNearest: CGFloat) -> CGFloat {
        return (self / toNearest).rounded() * toNearest
    }
    func roundedDown(toNearest: CGFloat) -> CGFloat {
        return floor(self / toNearest) * toNearest
    }
    func roundedUp(toNearest: CGFloat) -> CGFloat {
        return ceil(self / toNearest) * toNearest
    }
}


