
struct Matrix:
    var cells: List[List[Bool]]
    var h: Int
    var w: Int

    fn __init__(mut self, h: Int, w: Int):
        self.cells = List[List[Bool]]()
        self.h = h
        self.w = w
        for y in range(self.h):
            self.cells.append(List[Bool]())
            for _ in range(self.w):
                var b = self.cells[y]
                self.cells[y].append(False)

    fn __copyinit__(mut self, existing: Self):
        self.cells = existing.cells
        self.h = existing.h
        self.w = existing.w

    fn set_matrix(mut self, owned cells: List[List[Bool]]):
        self.cells = cells

    fn count_around(mut self, h: Int, w: Int) -> Int:
        """數周圍的存活數量
        O(3^2).
        """
        var alive: Int = 0
        for y in range(-1, 2):
            for x in range(-1, 2):
                var checkY: Int = h + y
                var checkX: Int = w + x
                if y == x == 0:
                    continue
                if checkY < 0 or checkX < 0:
                    continue
                if self.h <= checkY or self.w <= checkX:
                    continue
                if self.cells[checkY][checkX]:
                    alive = alive + 1
        return alive

    fn next(mut self):
        """推算下一代
        O(h*w*(3^2)).
        """
        var new_matrix: Matrix = self
        # 用copy constructor備份原有，避免在更改值時影響其他細胞

        for h in range(self.h):
            for w in range(self.w):
                var alives:Int = self.count_around(h, w)
                # Die if < 2
                if alives < 2 or alives > 3:
                    new_matrix.cells[h][w] = False
                elif alives == 2:
                    pass
                elif alives == 3:
                    new_matrix.cells[h][w] = True
        self = new_matrix
        # 將新的覆蓋回來

    fn print(mut self):
        var show: String = ""
        for rows in self.cells:
            for cell in rows[]:
                if cell[]:
                    show = show + "●"
                else:
                    show = show + "○"
            show = show + "\r\n"
        print(show)


def main():

    var matrix: Matrix = Matrix(8, 8)
    var nMatrix: List[List[Bool]] = List[List[Bool]](
        List[Bool](0, 0, 0, 0, 0, 0, 0, 0),
        List[Bool](0, 0, 0, 0, 0, 0, 0, 0),
        List[Bool](0, 0, 0, 0, 0, 0, 0, 0),
        List[Bool](0, 0, 0, 1, 1, 1, 0, 0),
        List[Bool](0, 0, 1, 1, 1, 0, 0, 0),
        List[Bool](0, 0, 0, 0, 0, 0, 0, 0),
        List[Bool](0, 0, 0, 0, 0, 0, 0, 0),
        List[Bool](0, 0, 0, 0, 0, 0, 0, 0),
        List[Bool](0, 0, 0, 0, 0, 0, 0, 0),
    )
    matrix.set_matrix(nMatrix)
    matrix.print()
    matrix.next()
    matrix.print()
