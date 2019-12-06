from models.queryModel import QueryModel
class QueryController:
    def __init__(self):
        self.model = QueryModel()

    def query1(self, given_id, given_date):
        rows = self.model.query1(given_id, given_date)
        print('query1')
        return {"rows": rows}

    def query2(self):
        rows = self.model.query2()
        print('query2')
        return {"rows": rows}

    def query3(self, given_date):
        rows = self.model.query3(given_date)
        print('query3')
        return {"rows": rows}

    def query4(self):
        rows = self.model.query4()
        print('query4')
        return {"rows": rows}

    def query5(self):
        rows = self.model.query5()
        print('query5')
        return {"rows": rows}
