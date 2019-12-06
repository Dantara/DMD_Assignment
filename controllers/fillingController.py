import sys
sys.path.append("..")
from models.fillingModel import FillingModel

class FillingController:
    def __init__(self):
        self.model = FillingModel()

    def generate(self, patients, h_admins, assistants, s_admins, doctors, nurses, rooms, min_salary, max_salary, salaries, inventories, payments, labs, results, checks, receipts, messages, enrolls, results_gen, test, nurse_messages, schedule, requests):
        print('generate')
        accountants = int(patients) + int(h_admins) + int(assistants) + int(s_admins) + int(doctors) + int(nurses)
        self.model.init_dict_db()
        self.model.copy_gen_file()
        self.model.add_n_patients(int(patients), int(rooms))
        self.model.add_n_h_admins(int(h_admins))
        self.model.add_n_assistants(int(assistants))
        self.model.add_n_s_admins(int(s_admins))
        self.model.add_n_doctors(int(doctors))
        self.model.add_n_nurses(int(nurses))
        self.model.add_n_salary(int(salaries), int(min_salary), int(max_salary))
        self.model.add_n_inventories(int(inventories))
        self.model.add_n_payments(int(payments), int(min_salary), int(max_salary), int(patients))
        self.model.add_n_labs(int(patients), int(rooms))
        self.model.add_n_test_results(int(results))
        self.model.add_n_checks_medical_history(int(results), int(patients), int(doctors))
        self.model.add_n_sends_receipt(int(receipts), int(patients), int(accountants))
        self.model.add_n_writes_message(int(messages), int(patients), int(doctors))
        self.model.add_n_enrolls(int(enrolls), int(h_admins), int(inventories))
        self.model.add_n_generates_results(int(results_gen), int(labs), int(results))
        self.model.add_n_makes_tests(int(test), int(nurses), int(assistants))
        self.model.add_n_writes_message_nurse(int(nurse_messages), int(nurses), int(doctors))
        self.model.add_n_rooms(int(rooms))
        self.model.add_n_schedule(int(schedule), int(patients), int(doctors), int(rooms), int(h_admins), int(results), int(nurses), int(assistants))
        self.model.add_n_makes_a_request(int(requests), int(patients), int(nurses))
        self.model.commit()
        return {"data": "generate"}

    def execute(self):
        print('execute')
        self.model.execute_output()
        return {"data": "execute"}

    def erase(self):
        print('erase')
        self.model.execute_erase()
        return {"data": "erase"}
