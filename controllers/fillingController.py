import sys
sys.path.append("..")
from models.fillingModel import FillingModel

class FillingController:
    def __init__(self):
        self.model = FillingModel()

    def generate(self, patients, accountants):
        print('generate')
        self.model.copy_gen_file()
        return {"data": "generate"}

    def execute(self):
        print('execute')
        self.model.execute_output()
        return {"data": "execute"}

    def erase(self):
        print('erase')
        self.model.execute_erase()
        return {"data": "erase"}
