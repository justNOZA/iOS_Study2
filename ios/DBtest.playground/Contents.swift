import UIKit
import Foundation

let documentsURL =
    NSFileProviderManager.def
    NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
let databaseURL = documentsURL.URLByAppendingPathComponent("sqlitedb")
let databasePath = databaseURL.path!
        
let filemgr = NSFileManager.defaultManager()
if !filemgr.fileExistsAtPath(databasePath as String) {
       //해당 파일 경로에 SQLite 파일이 정상적으로 생성되면 실행되는 구간

let testDB = FMDatabase(path: databasePath as String)

if testDB.open() {
let sql_stmt = "CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY AUTOINCREMENT, timestamp DATETIME DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')), date TEXT)"
              if !testDB.executeStatements(sql_stmt) {
                       print("Error1: \(testDB.lastErrorMessage())")
              }
               testDB.close()
              } else {
                       print("Error2: \(testDB.lastErrorMessage())")
      }
}


출처: https://azsha.tistory.com/49 [Azsha's Forge]
