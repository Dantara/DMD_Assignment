from models.rootModel import RootModel

class ReadModel(RootModel):
    def __init__(self):
        super().__init__()
        self.tablesNamesFile = 'database/tableNamesPostgres.sql'

    def getTablesNames(self):
        cursor = self.conn.cursor();
        cursor.execute(open(self.tablesNamesFile, 'r').read())
        names = cursor.fetchall()

        return names

    def getTable(self, name):
        cursor = self.conn.cursor();
        cursor.execute('SELECT * FROM ' + name + ' ;')
        table = cursor.fetchall()

        return table
