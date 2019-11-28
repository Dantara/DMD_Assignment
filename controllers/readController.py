from models.readModel import ReadModel

class ReadController:
    def __init__(self):
        self.model = ReadModel()

    def names(self):
        print('names')
        names = self.model.getTablesNames()
        return {"names": names}

    def table(self, name):
        print('table')
        (rows, columns) = self.model.getTable(name)
        return {"columns": columns, "rows": rows}
