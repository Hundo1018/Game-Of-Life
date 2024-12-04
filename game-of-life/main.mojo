struct Matrix:
    var cells: List[List[Bool]]
    var h: Int32
    var w: Int32

    fn __init__(inout self, h: Int, w: Int):
        self.cells = List[List[Bool]]()
        self.h = h
        self.w = w
        for y in range(self.h):
            self.cells.append(List[Bool]())
            for _ in range(self.w):
                self.cells[y].append(False)

    fn __copyinit__(inout self, existing: Self):
        self.cells = existing.cells
        self.h = existing.h
        self.w = existing.w

    fn set_matrix(inout self, owned cells: List[List[Bool]]):
        self.cells = cells

    fn count_around(inout self, h: Int, w: Int) -> Int:
        """數周圍的存活數量
        O(3^2).
        """
        var alive: Int = 0
        for y in range(-1, 2):
            for x in range(-1, 2):
                var checkY: Int = h + y
                var checkX: Int = w + x
                if y == x == 0 or checkY < 0 or checkX < 0:
                    continue
                if self.h <= checkY or self.w <= checkX:
                    continue
                if self.cells[checkY][checkX]:
                    alive = alive + 1
        return alive

    fn next(inout self):
        """推算下一代
        O(h*w*(3^2)).
        """
        var new_matrix: Matrix = self
        # 用copy constructor備份原有，避免在更改值時影響其他細胞

        for h in range(self.h):
            for w in range(self.w):
                alives = self.count_around(h, w)
                # Die if < 2
                if alives < 2 or alives > 3:
                    new_matrix.cells[h][w] = False
                elif alives == 2:
                    pass
                elif alives == 3:
                    new_matrix.cells[h][w] = True
        self = new_matrix
        # 將新的覆蓋回來

    fn print(inout self):
        var show: String = ""
        for rows in self.cells:
            for cell in rows[]:
                if cell[]:
                    show = show + "●"
                else:
                    show = show + "○"
            show = show + "\r\n"
        print(show)


fn main():
    var matrix: Matrix = Matrix(8, 8)
    var nMatrix: List[List[Bool]] = List[List[Bool]]()
    var R0: List[Bool] = List[Bool](0, 0, 0, 0, 0, 0, 0, 0)
    var R1: List[Bool] = List[Bool](0, 0, 0, 0, 0, 0, 0, 0)
    var R2: List[Bool] = List[Bool](0, 0, 0, 0, 0, 0, 0, 0)
    var R3: List[Bool] = List[Bool](0, 0, 0, 1, 1, 1, 0, 0)
    var R4: List[Bool] = List[Bool](0, 0, 1, 1, 1, 0, 0, 0)
    var R5: List[Bool] = List[Bool](0, 0, 0, 0, 0, 0, 0, 0)
    var R6: List[Bool] = List[Bool](0, 0, 0, 0, 0, 0, 0, 0)
    var R7: List[Bool] = List[Bool](0, 0, 0, 0, 0, 0, 0, 0)
    nMatrix.append(R0)
    nMatrix.append(R1)
    nMatrix.append(R2)
    nMatrix.append(R3)
    nMatrix.append(R4)
    nMatrix.append(R5)
    nMatrix.append(R6)
    nMatrix.append(R7)
    matrix.set_matrix(nMatrix)
    matrix.print()
    matrix.next()
    matrix.print()
