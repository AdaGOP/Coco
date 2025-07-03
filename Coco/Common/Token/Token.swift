//
//  Token.swift
//  Coco
//
//  Created by Jackie Leonardy on 03/07/25.
//

import Foundation
import UIKit

enum Token {
    @ColorElement(light: UIColor.from("#85CC16"), dark: UIColor.from("#85CC16"))
    static var mainColorPrimary: UIColor
    
    @ColorElement(light: UIColor.from("#F6F8FE"), dark: UIColor.from("#F6F8FE"))
    static var mainColorSecondary: UIColor
    
    @ColorElement(light: UIColor.from("#4038FF"), dark: UIColor.from("#4038FF"))
    static var mainColorDarkBlue: UIColor
    
    @ColorElement(light: UIColor.from("#183D1E"), dark: UIColor.from("#183D1E"))
    static var mainColorThird: UIColor
    
    @ColorElement(light: UIColor.from("#183D1E"), dark: UIColor.from("#183D1E"))
    static var mainColorForth: UIColor
    
    @ColorElement(light: UIColor.from("#00C566"), dark: UIColor.from("#00C566"))
    static var alertsSuccess: UIColor
    
    @ColorElement(light: UIColor.from("#E53935"), dark: UIColor.from("#E53935"))
    static var alertsError: UIColor
    
    @ColorElement(light: UIColor.from("#FACC15"), dark: UIColor.from("#FACC15"))
    static var alertsWarning: UIColor
    
    @ColorElement(light: UIColor.from("#FEFEFE"), dark: UIColor.from("#FEFEFE"))
    static var additionalColorsWhite: UIColor
    
    @ColorElement(light: UIColor.from("#E3E7EC"), dark: UIColor.from("#E3E7EC"))
    static var additionalColorsLine: UIColor
    
    @ColorElement(light: UIColor.from("#4A4A65"), dark: UIColor.from("#4A4A65"))
    static var additionalColorsLineDark: UIColor
    
    @ColorElement(light: UIColor.from("#FDFDFD"), dark: UIColor.from("#FDFDFD"))
    static var grayscale10: UIColor
    
    @ColorElement(light: UIColor.from("#ECF1F6"), dark: UIColor.from("#ECF1F6"))
    static var grayscale20: UIColor
    
    @ColorElement(light: UIColor.from("#E3E9ED"), dark: UIColor.from("#E3E9ED"))
    static var grayscale30: UIColor
    
    @ColorElement(light: UIColor.from("#D1D8DD"), dark: UIColor.from("#D1D8DD"))
    static var grayscale40: UIColor
    
    @ColorElement(light: UIColor.from("#BFC6CC"), dark: UIColor.from("#BFC6CC"))
    static var grayscale50: UIColor
    
    @ColorElement(light: UIColor.from("#9CA4AB"), dark: UIColor.from("#9CA4AB"))
    static var grayscale60: UIColor
    
    @ColorElement(light: UIColor.from("#78828A"), dark: UIColor.from("#78828A"))
    static var grayscale70: UIColor
    
    @ColorElement(light: UIColor.from("#66707A"), dark: UIColor.from("#66707A"))
    static var grayscale80: UIColor
    
    @ColorElement(light: UIColor.from("#434E58"), dark: UIColor.from("#434E58"))
    static var grayscale90: UIColor
    
    @ColorElement(light: UIColor.from("#171725"), dark: UIColor.from("#171725"))
    static var grayscale100: UIColor
}
