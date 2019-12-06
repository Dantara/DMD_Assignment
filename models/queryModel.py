from models.rootModel import RootModel

class QueryModel(RootModel):
    def __init__(self):
        super().__init__()
        self.q1_file = 'database/query1.sql'
        self.q2_file = 'database/query2.sql'
        self.q3_file = 'database/query3.sql'
        self.q4_file = 'database/query4.sql'
        self.q5_file = 'database/query5.sql'

    def query1(self, given_id, given_date):
        query = str(open(self.q1_file).read())
        query = query.replace('$$given_id$$', str(given_id))
        query = query.replace('$$given_date$$', str(given_date))
        cursor = self.conn.cursor();
        cursor.execute(query)
        return cursor.fetchall()

    def query2(self):
        query = str(open(self.q2_file).read())
        cursor = self.conn.cursor();
        cursor.execute(query)
        return cursor.fetchall()


    def query3(self, given_date):
        query = str(open(self.q3_file).read())
        query = query.replace('$$given_date$$', str(given_date))
        cursor = self.conn.cursor();
        cursor.execute(query)
        return cursor.fetchall()


    def query4(self):
        query = str(open(self.q4_file).read())
        cursor = self.conn.cursor();
        cursor.execute(query)
        return cursor.fetchall()


    def query5(self):
        query = str(open(self.q5_file).read())
        cursor = self.conn.cursor();
        cursor.execute(query)
        return cursor.fetchall()

