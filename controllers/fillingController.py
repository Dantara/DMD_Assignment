import sys
sys.path.append("..")
from models.fillingModel import FillingModel

class FillingController:
    def __init__(self):
        self.model = FillingModel()

    def generate(self, patients, h_admins, assistants, s_admins, doctors, nurses, rooms):
        print('generate')
        self.model.copy_gen_file()
        self.model.add_n_patients(int(patients), int(rooms))
        self.model.add_n_h_admins(int(h_admins))
        self.model.add_n_assistants(int(assistants))
        self.model.add_n_s_admins(int(s_admins))
        self.model.add_n_doctors(int(doctors))
        self.model.add_n_nurses(int(nurses))
        return {"data": "generate"}

    def execute(self):
        print('execute')
        self.model.execute_output()
        return {"data": "execute"}

    def erase(self):
        print('erase')
        self.model.execute_erase()
        return {"data": "erase"}
