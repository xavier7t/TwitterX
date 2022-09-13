//
//  DBHelperPost.swift
//  TwitterX
//
//  Created by Xavier on 9/13/22.
//

import Foundation
import SQLite3

let appName: String = "TwitterX"
class DBHelperPost {
    static let shared = DBHelperPost()
    
    var sqlStatement = ""
    var dbPointer: OpaquePointer?
    
    private func printSQLiteErrorMessage() {
        let error = String(cString: sqlite3_errmsg(dbPointer)!)
        print("SQLite Error: \(error)")
    }
    
    private func finalizeCRUDOperations(statement: OpaquePointer?) {
        sqlite3_reset(statement)
        sqlite3_finalize(statement)
        sqlite3_close(dbPointer)
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
    
    func create(authenticationextid: String, description: String, encodedimage: String, hasimage: Int) {
        prepareDatabase()
        prepareTable()
        var statement: OpaquePointer?
        
        sqlStatement = """
            INSERT INTO ZPOST (
                externalid,
                authenticationextid,
                description,
                encodedimage,
                hasimage,
                countcomments,
                countlikes,
                countretweets
            ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ? );
        """
        
        guard sqlite3_prepare(dbPointer, sqlStatement, -1, &statement, nil) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        
        guard sqlite3_bind_text(statement, 1, (TimeStamp.shared.timestamp17(date: Date()) as NSString).utf8String, -1, nil) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        guard sqlite3_bind_text(statement, 2, (authenticationextid as NSString).utf8String, -1, nil) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        guard sqlite3_bind_text(statement, 3, (description as NSString).utf8String, -1, nil) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        guard sqlite3_bind_text(statement, 4, (encodedimage as NSString).utf8String, -1, nil) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        guard sqlite3_bind_int(statement, 5, Int32(hasimage)) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        guard sqlite3_bind_int(statement, 6, Int32(0)) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        guard sqlite3_bind_int(statement, 7, Int32(0)) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        guard sqlite3_bind_int(statement, 8, Int32(0)) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return
        }
        
        guard sqlite3_step(statement) == SQLITE_DONE else {
            printSQLiteErrorMessage()
            return
        }
        
        finalizeCRUDOperations(statement: statement)
        
        print("Post saved in database.")
    }
    
    func readAll() -> [Post] {
        var postsFetched: [Post] = []
        prepareDatabase()
        prepareTable()
        var statement: OpaquePointer?
        sqlStatement = """
            SELECT * FROM ZPOST
        """
        
        guard sqlite3_prepare(dbPointer, sqlStatement, -1, &statement, nil) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return []
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let post = Post(
                internalid: Int(sqlite3_column_int(statement, 0)),
                externalid: String(cString: sqlite3_column_text(statement, 1)),
                authenticationextid: String(cString: sqlite3_column_text(statement, 2)),
                description: String(cString: sqlite3_column_text(statement, 3)),
                encodedimage: String(cString: sqlite3_column_text(statement, 4)),
                hasimage: Int(sqlite3_column_int(statement, 5)),
                countcomments: Int(sqlite3_column_int(statement, 6)),
                countlikes: Int(sqlite3_column_int(statement, 7)),
                countretweets: Int(sqlite3_column_int(statement, 8))
            )
            postsFetched.append(post)
        }
        
        finalizeCRUDOperations(statement: statement)
        return postsFetched
    }
    
    func readOne(filterValue: String, filterKey: String) -> [Post] {
        var postsFetched: [Post] = []
        prepareDatabase()
        prepareTable()
        var statement: OpaquePointer?
        sqlStatement = """
            SELECT * FROM ZPOST WHERE \(filterKey) = \(filterValue)
        """
        
        guard sqlite3_prepare(dbPointer, sqlStatement, -1, &statement, nil) == SQLITE_OK else {
            printSQLiteErrorMessage()
            return []
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let post = Post(
                internalid: Int(sqlite3_column_int(statement, 0)),
                externalid: String(cString: sqlite3_column_text(statement, 1)),
                authenticationextid: String(cString: sqlite3_column_text(statement, 2)),
                description: String(cString: sqlite3_column_text(statement, 3)),
                encodedimage: String(cString: sqlite3_column_text(statement, 4)),
                hasimage: Int(sqlite3_column_int(statement, 5)),
                countcomments: Int(sqlite3_column_int(statement, 6)),
                countlikes: Int(sqlite3_column_int(statement, 7)),
                countretweets: Int(sqlite3_column_int(statement, 8))
            )
            postsFetched.append(post)
        }
        
        finalizeCRUDOperations(statement: statement)
        return postsFetched
    }
}
