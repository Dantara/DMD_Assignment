from shutil import copyfile
from models.rootModel import RootModel
from faker import Faker
from faker.providers import phone_number, profile, lorem, date_time
from support.data import medicines
import random

class FillingModel(RootModel):
    def __init__(self):
        super().__init__()
        self.gen_file = 'database/schema.sql'
        self.erase_file = 'database/erase.sql'
        self.output_file = 'output/dump.sql'
        self.conn.autocommit = True
        self.faker = Faker()
        self.faker.add_provider(profile)
        self.faker.add_provider(date_time)
        self.faker.add_provider(lorem)
        self.faker_RU = Faker('ru_RU')
        self.faker_RU.add_provider(phone_number)
        self.dict_db = {}

    def init_dict_db(self):
        self.dict_db = {
            'patient': [],
            'accountant': [],
            'salary': [],
            'room': [],
            'hospital_administrator': [],
            'inventory': [],
            'laboratory_assistant': [],
            'system_administrator': [],
            'doctor': [],
            'nurse': [],
            'payment': [],
            'schedule': [],
            'lab': [],
            'test_results': [],
            'checks_medical_history': [],
            'sends_receipt': [],
            'makes_a_payment': [],
            'writes_message': [],
            'makes_an_appointment': [],
            'notifies': [],
            'occupies': [],
            'schedule_cleaning': [],
            'is_ready': [],
            'notifies_doctor': [],
            'notifies_nurse': [],
            'books_room': [],
            'doctor_makes_an_appointment': [],
            'enrolls': [],
            'generates_results': [],
            'makes_tests': [],
            'notifies_lab_assistant': [],
            'writes_message_nurse': []
        }

    def copy_gen_file(self):
        copyfile(self.gen_file, self.output_file)

    def execute_file(self, f):
        cursor = self.conn.cursor();
        cursor.execute(open(f, 'r').read())

    def execute_output(self):
        self.execute_file(self.output_file)

    def execute_erase(self):
        self.execute_file(self.erase_file)

    def dict_to_sql(self, dictionary, table_name):
        sql = "INSERT INTO " + table_name + " ("
        for key in dictionary:
            sql = sql + "" + key + ", "
        sql = sql[:-2]
        sql += ') VALUES ('
        for key in dictionary:
            sql = sql + "'" + str(dictionary[key]) + "', "
        sql = sql[:-2]
        sql += ");\n"
        return sql

    def patient(self, rooms):
        profile = self.faker.profile()
        p = {}
        p['name'] = profile['name']
        p['phone_number'] = self.faker_RU.phone_number()
        p['date_of_birth'] = '{:%Y-%m-%d}'.format(profile['birthdate'])
        p['email'] = profile['mail']
        p['medical_history'] = self.faker.text(max_nb_chars=50, ext_word_list=None)
        p['room_number'] = self.faker.random_int(1, rooms)
        p['password'] = self.faker.pystr(min_chars=8, max_chars=20)
        return p

    def person(self):
        profile = self.faker.profile()
        p = {}
        p['name'] = profile['name']
        p['email'] = profile['mail']
        p['password'] = self.faker.pystr(min_chars=8, max_chars=20)
        return p

    def doctor(self):
        specialties = ['anesthesiology', 'dermatology', 'diagnostic radiology',
                       'emergency medicine', 'family medicine', 'neurology', 'pediatrics']
        d = self.person()
        d['speciality'] = random.choice(specialties)
        return d

    def salary(self, min_s, max_s):
        s = {}
        s['amount'] = random.randint(min_s, max_s)
        s['payed'] = random.choice([True, False])
        return s

    def inventory(self):
        i = {}
        i['name'] = random.choice(medicines())
        i['price'] = random.randint(100, 4000)
        amount = random.randint(0, 100)
        i['amount'] = amount
        i['amount_paid'] = random.randint(0, amount)
        return i

    def payment(self, min_s, max_s):
        p = {}
        p['amount'] = random.randint(min_s, max_s)
        services = ['doctor', 'nurse', 'administrator', 'assistant']
        p['service'] = random.choice(services)
        p['date'] = self.faker.date(pattern='%Y-%m-%d', end_datetime=None)
        return p

    def lab(self, rooms):
        l = {'room_number': random.randint(1, rooms)}
        return l

    def test_results(self):
        tr = {'result_file': '/results/' + self.faker.pystr(min_chars=4, max_chars=10) + '.pdf'}
        return tr

    def checks_medical_history(self, patients, doctors):
        cmh = {}
        cmh['patient_id'] = random.randint(1, patients)
        cmh['doctor_id'] = random.randint(1, doctors)
        return cmh

    def sends_receipt(self, patients, accountants):
        sr = {}
        sr['patient_id'] = random.randint(1, patients)
        sr['doctor_id'] = random.randint(1, doctors)
        sr['receipt'] = random.choice(medicines())
        return sr

    def writes_message(self, patients, doctors):
        wr = {}
        wr['patient_id'] = random.randint(1, patients)
        wr['doctor_id'] = random.randint(1, doctors)
        wr['text_message'] = self.faker.text(max_nb_chars=80, ext_word_list=None)
        return wr

    def enrolls(self, admins, inventories):
        e = {}
        e['admin_id'] = random.randint(1, admins)
        e['inventory_id'] = random.randint(1, inventories)
        return e

    def generates_results(self, labs, tests):
        r = {}
        r['lab_id'] = random.randint(1, labs)
        r['test_results_id'] = random.randint(1, tests)
        return r

    def makes_tests(self, labs, assistants):
        t = {}
        t['labs_id'] = random.randint(1, labs)
        t['lab_assistant_id'] = random.randint(1, assistants)
        return t

    def writes_message_nurse(self, nurses, doctors):
        wr = {}
        wr['nurse_id'] = random.randint(1, nurses)
        wr['doctor_id'] = random.randint(1, doctors)
        wr['text_message'] = self.faker.text(max_nb_chars=80, ext_word_list=None)
        return wr

    def add_accountant(self, p):
        a = {'name': p['name'], 'email': p['email'], 'password': p['password']}
        self.dict_db['accountant'].append(a)

    def add_n_patients(self, n, rooms):
        for i in range(0, n):
            p = self.patient(rooms)
            self.add_accountant(p)
            self.dict_db['patient'].append(p)

    def add_n_h_admins(self, n):
        for i in range(0, n):
            p = self.person()
            self.add_accountant(p)
            self.dict_db['hospital_administrator'].append(p)

    def add_n_assistants(self, n):
        for i in range(0, n):
            p = self.person()
            self.add_accountant(p)
            self.dict_db['laboratory_assistant'].append(p)

    def add_n_s_admins(self, n):
        for i in range(0, n):
            p = self.person()
            self.add_accountant(p)
            self.dict_db['system_administrator'].append(p)

    def add_n_doctors(self, n):
        for i in range(0, n):
            p = self.doctor()
            self.add_accountant(p)
            self.dict_db['doctor'].append(p)

    def add_n_nurses(self, n):
        for i in range(0, n):
            p = self.person()
            self.add_accountant(p)
            self.dict_db['nurse'].append(p)

    def add_n_salary(self, n, min_s, max_s):
        for i in range(0, n):
            s = self.salary(min_s, max_s)
            self.dict_db['salary'].append(s)

    def add_n_inventories(self, n):
        for i in range(0, n):
            inv = self.inventory()
            self.dict_db['inventory'].append(inv)

    def add_n_payments(self, n, min_s, max_s):
        for i in range(0, n):
            p = self.payment(min_s, max_s)
            self.dict_db['payment'].append(p)

    def add_n_labs(self, n, rooms):
        for i in range(0, n):
            l = self.lab(rooms)
            self.dict_db['lab'].append(l)

    def add_n_test_results(self, n):
        for i in range(0, n):
            tr = self.test_results()
            self.dict_db['test_results'].append(tr)

    def add_n_checks_medical_history(self, n , patients, doctors):
        for i in range(0, n):
            cmh = self.checks_medical_history(patients, doctors)
            self.dict_db['checks_medical_history'].append(cmh)

    def add_n_sends_receipt(self, patients, accountants):
        for i in range(0, n):
            sr = self.sends_receipt(patients, accountants)
            self.dict_db['sends_receipt'].append(sr)

    def add_n_writes_message(self, patients, doctors):
        for i in range(0, n):
            wm = self.writes_message(self, patients, doctors)
            self.dict_db['writes_message'].append(wm)

    def add_n_enrolls(self, admins, inventories):
        for i in range(0, n):
            e = self.enrolls(self, admins, inventories)
            self.dict_db['enrolls'].append(e)

    def add_n_generates_results(self, labs, tests):
        for i in range(0, n):
            gr = self.generates_results(labs, tests)
            self.dict_db['generates_results'].append(gr)

    def add_n_makes_tests(self, labs, assistants):
        for i in range(0, n):
            mt = self.makes_tests(labs, assistants)
            self.dict_db['makes_tests'].append(mt)

    def add_n_writes_message_nurse(self, nurses, doctors):
        for i in range(0, n):
            wm = self.writes_message(self, nurses, doctors)
            self.dict_db['writes_message_nurse'].append(wm)

    def dist_db_to_sql_array(self):
        arr = []
        for table in self.dict_db:
            for elm in self.dict_db[table]:
                sql = self.dict_to_sql(elm, table)
                arr.append(sql)
        return arr

    def append_sql_array(self, arr):
        f = open(self.output_file, 'a')
        for elm in arr:
            f.write(elm)
        f.close()

    def commit(self):
        arr = self.dist_db_to_sql_array()
        self.append_sql_array(arr)


