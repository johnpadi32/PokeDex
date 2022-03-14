//
//  Extensions.swift
//  PokeDex
//
//  Created by John Padilla on 3/8/22.
//

import UIKit

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainRed() -> UIColor {
        return UIColor.rgb(red: 250, green: 101, blue: 85)
    }
    
    ///Cell backgroundColor
    /// Red
    static func viewRed() -> UIColor {
        return UIColor.rgb(red: 247, green: 120, blue: 107)
    }
    
    static func typeRed() -> UIColor {
        return UIColor.rgb(red: 249, green: 143, blue: 144)
    }
    
    /// Blue
    static func viewBlue() -> UIColor {
        return UIColor.rgb(red: 88, green: 171, blue: 246)
    }
    
    static func typeBlue() -> UIColor {
        return UIColor.rgb(red: 129, green: 192, blue: 248)
    }
    
    /// Green
    static func viewGree() -> UIColor {
        return UIColor.rgb(red: 44, green: 218, blue: 177)
    }
    
    static func typeGree() -> UIColor {
        return UIColor.rgb(red: 96, green: 227, blue: 196)
    }
    
    // Yellow
    static func viewYellow() -> UIColor {
        return UIColor.rgb(red: 255, green: 206, blue: 76)
    }
    
    static func typeYellow() -> UIColor {
        return UIColor.rgb(red: 255, green: 218, blue: 119)
    }
    
    /// Purple
    static func viewPurple() -> UIColor {
        return UIColor.rgb(red: 159, green: 91, blue: 166)
    }
    
    static func typePurple() -> UIColor {
        return UIColor.rgb(red: 183, green: 132, blue: 203)
    }
    
    /// Brown
    static func viewBrown() -> UIColor {
        return UIColor.rgb(red: 202, green: 129, blue: 121)
    }
    
    static func typeBrown() -> UIColor {
        return UIColor.rgb(red: 215, green: 160, blue: 154)
    }
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                    left: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    right: NSLayoutXAxisAnchor? = nil,
                    paddingTop: CGFloat = 0,
                    paddingLeft: CGFloat = 0,
                    paddingBottom: CGFloat = 0,
                    paddingRight: CGFloat = 0,
                    width: CGFloat? = nil,
                    height: CGFloat? = nil) {
            
            translatesAutoresizingMaskIntoConstraints = false
            
            if let top = top {
                topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            }
            
            if let left = left {
                leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
            }
            
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
            
            if let right = right {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
            
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                    paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        anchor(top: view.topAnchor, left: view.leftAnchor,
                bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}
