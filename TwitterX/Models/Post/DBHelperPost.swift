//
//  DBHelperPost.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import Foundation
import SQLite3

let appName = "TwitterX"
class DBHelperPost {
    static let shared = DBHelperPost()
    
    var sqlStatement = ""
    var dbPointer: OpaquePointer?
    
    private func printSQLiteErrorMessage() {
        let error = String(cString: sqlite3_errmsg(dbPointer)!)
        print("SQLite Error: \(error)")
    }
    
    func prepareDatabase() {
        let filePath = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
            .appendingPathComponent("\(appName).sqlite")
        print(FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).last!)
        
        guard sqlite3_open(filePath.path(), &dbPointer) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        
        print("SQLite3 Database \"\(appName).sqlite\" is ready.")
    }
    
    func prepareTable() {
        sqlStatement = """
            CREATE TABLE IF NOT EXISTS ZPOST (
                internalid              INTEGER NOT NULL UNIQUE   ,
                externalid              TEXT NOT NULL             ,
                authenticationextid     TEXT NOT NULL             ,
                description             TEXT NOT NULL             ,
                encodedimage            TEXT                      ,
                hasimage                INTEGER NOT NULL          ,
                countcomments           INTEGER NOT NULL          ,
                countlikes              INTEGER NOT NULL          ,
                countretweets           INTEGER NOT NULL          ,
                PRIMARY KEY("internalid" AUTOINCREMENT)
            );
        """
        
        guard sqlite3_exec(dbPointer, sqlStatement, nil, nil, nil) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        print("SQLite3 Table \"ZPOST\" is ready.")
    }
}
