//
//  Stemmer.swift
//  LibStemmerSwift
//
//  Created by Oscar Götting on 10/15/18.
//

import Foundation

#if os(Linux)
import Glibc
#else
import Darwin
#endif

#if !COCOAPODS
import libstemmer
#endif

public enum StemmerLanguage: String {
    case danish
    case dutch
    case english
    case finnish
    case french
    case german
    case hungarian
    case italian
    case norwegian
    case portuguese
    case romanian
    case russian
    case spanish
    case swedish
    case turkish
}

public class PorterStemmer
{
    internal let stemmer: OpaquePointer

    public init?(withLanguage language: StemmerLanguage) {
        if let stemmer = sb_stemmer_new(language.rawValue, nil) {
            self.stemmer = stemmer
        }
        else {
            return nil
        }
    }
    
    deinit {
        sb_stemmer_delete(self.stemmer);
    }
    
    public func stem(_ string: String) -> String {
        guard !string.isEmpty else {
            return("")
        }
        let res: UnsafePointer<sb_symbol> = sb_stemmer_stem(self.stemmer, string, Int32(string.count));
        return String(cString: res)
    }
}

