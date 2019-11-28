class FillingController:
    def generate(patients, accountants):
        print('generate')
        print(patients)
        return {"data": "generate"}

    def execute():
        print('execute')
        return {"data": "execute"}

    def erase():
        print('erase')
        return {"data": "erase"}
