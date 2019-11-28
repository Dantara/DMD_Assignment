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
        table = self.model.getTable(name)
        print(table)
        return {"table": table}
