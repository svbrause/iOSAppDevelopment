//
//  Rectangle.swift
//  Assignment4
//
//  Created by Sam Brause on 7/14/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import Foundation
enum CellState: String{
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    func toggle(value: CellState) -> CellState {
        if (value == .Empty || value == .Died) {
            return .Living
        }else{
            return .Empty
        }
    }
}

protocol GridProtocol {
    init(rows: Int, cols: Int)
    var rows: Int{ get set }
    var cols: Int{ get set }
    func neighbors(coordinates: (Int, Int)) ->([(Int, Int)])
    subscript(row: Int, col: Int) -> CellState? { get set }
}

protocol ExampleDelegateProtocol {
    func example(example: Grid, didUpdateRows: Int)
}

class Grid: GridProtocol {
    private static var _sharedInstance = Grid(rows: 10, cols: 10)
    static var sharedInstance: Grid {
        //        if _sharedInstance == nil{
        //            _sharedInstance = StandardEngine!()
        //        }
        return _sharedInstance
    }
    var CollectionOfCellStates = Array(count: 20, repeatedValue:Array(count: 20, repeatedValue: CellState.Empty))
    required init(rows: Int, cols: Int){
        self.rows = rows
        self.cols = cols
    }
    var rows: Int {
        didSet{
            if let delegate = delegate {
                delegate.example(self, didUpdateRows: self.rows)
            }
        }
    }
    var cols: Int {
        didSet{
            if let delegate = delegate {
                delegate.example(self, didUpdateRows: self.cols)
            }
        }
    }
    var delegate: ExampleDelegateProtocol?
    func neighbors(coordinates: (Int, Int)) ->([(Int, Int)]){
        let prevRow = (coordinates.0 + rows - 1) % rows // =9
        let nextRow = (coordinates.0 + 1) % rows // =11
        let prevCol = (coordinates.1 + cols - 1) % cols // =9
        let nextCol = (coordinates.1 + 1) % cols // =11
        var imgoingtoreturnthis = Array(count: 8, repeatedValue: (0, 0))
        imgoingtoreturnthis[0].0 = prevRow
        imgoingtoreturnthis[0].1 = prevCol
        imgoingtoreturnthis[1].0 = coordinates.0
        imgoingtoreturnthis[1].1 = prevCol
        imgoingtoreturnthis[2].0 = nextRow
        imgoingtoreturnthis[2].1 = prevCol
        imgoingtoreturnthis[3].0 = prevRow
        imgoingtoreturnthis[3].1 = coordinates.1
        imgoingtoreturnthis[4].0 = nextRow
        imgoingtoreturnthis[4].1 = coordinates.1
        imgoingtoreturnthis[5].0 = prevRow
        imgoingtoreturnthis[5].1 = nextCol
        imgoingtoreturnthis[6].0 = coordinates.0
        imgoingtoreturnthis[6].1 = nextCol
        imgoingtoreturnthis[7].0 = nextRow
        imgoingtoreturnthis[7].1 = nextCol
        return imgoingtoreturnthis
    }
    private var grid = Array(count: 01134, repeatedValue: CellState.Empty)
    subscript(row: Int, col: Int) -> CellState? {
        get {
            if grid.count < Int(row*col) { return nil }
            return grid[Int(row * col + col)]
        }
        set (newValue) {
            if newValue == nil { return }
            if row < 0 || row >= rows || col < 0 || col >= cols { return }
            let cellRow = row * cols + col
            grid[Int(cellRow)] = newValue!
        }
    }
}
//    struct Rectangle: GridProtocol {
//        init(rows: Int, cols: Int){
//            self.rows = rows
//            self.cols = cols
//        }
//        var rows: Int
//        var cols: Int
//        func area() -> Double{
//            return Double(rows*cols)
//        }
//    }
//    
//    var shape : Shape
//    shape = Rectangle(width: 3, height: 4)
//    print(shape)