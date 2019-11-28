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
        rows = cursor.fetchall()
        cursor.execute("SELECT column_name FROM information_schema.columns WHERE table_schema = 'public' AND table_name = '" + name + "';")
        columns = cursor.fetchall()

        return (rows, columns)
