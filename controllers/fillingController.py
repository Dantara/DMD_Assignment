import sys
sys.path.append("..")
from models.fillingModel import FillingModel

class FillingController:
    def generate(patients, accountants):
        print('generate')
        model = FillingModel()
        model.copy_gen_file()
        return {"data": "generate"}

    def execute():
        print('execute')
        return {"data": "execute"}

    def erase():
        print('erase')
        return {"data": "erase"}
