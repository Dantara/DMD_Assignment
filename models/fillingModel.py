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
            'makes_a_request': [],
            'makes_an_appointment': [],
            'notifies': [],
            'occupies': [],
            'schedules_cleaning': [],
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

    def makes_a_payment(self, payment_id, patients):
        mp = {}
        mp['payment_id'] = payment_id
        mp['patient_id'] = random.randint(1, patients)
        return mp

    def payment(self, min_s, max_s):
        p = {}
        p['amount'] = random.randint(min_s, max_s)
        services = ['doctor', 'nurse', 'administrator', 'assistant']
        p['service'] = random.choice(services)
        date = self.faker.date_this_year(before_today=True, after_today=False)
        p['date'] = '{:%Y-%m-%d}'.format(date)
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
        sr['accountant_id'] = random.randint(1, accountants)
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
        t['lab_id'] = random.randint(1, labs)
        t['lab_assistant_id'] = random.randint(1, assistants)
        return t

    def makes_an_appointment(self, patient_id, schedule_id):
        ma = {}
        ma['patient_id'] = patient_id
        ma['schedule_id'] = schedule_id
        return ma

    def schedule(self, patients, doctors, rooms):
        s = {}
        s['description'] = self.faker.text(max_nb_chars=80, ext_word_list=None)
        date = self.faker.date_this_year(before_today=True, after_today=False)
        s['date_time'] = '{:%Y-%m-%d}'.format(date)
        s['id1'] = random.randint(1, patients)
        s['id2'] = random.randint(1, doctors)
        s['room'] = random.randint(1, rooms)
        return s

    def room(self, room_n):
        r = {}
        r['room_number'] = room_n
        r['capacity'] = random.choice([2, 5, 10, 50, 100])
        r['building'] = random.choice(['Main', 'First', 'Second', "Third"])
        return r

    def writes_message_nurse(self, nurses, doctors):
        wr = {}
        wr['nurse_id'] = random.randint(1, nurses)
        wr['doctor_id'] = random.randint(1, doctors)
        wr['text_message'] = self.faker.text(max_nb_chars=80, ext_word_list=None)
        return wr

    def makes_a_request(self, patients, nurses):
        mr = {}
        mr['patient_id'] = random.randint(1, patients)
        mr['nurse_id'] = random.randint(1, nurses)
        date = self.faker.date_this_year(before_today=True, after_today=False)
        mr['date_time'] = '{:%Y-%m-%d}'.format(date)
        return mr

    def notifies(self, patient_id, schedule_id):
        n = {}
        n['patient_id'] = patient_id
        n['schedule_id'] = schedule_id
        return n

    def occupies(self, schedule_id, room_id):
        o = {}
        o['schedule_id'] = schedule_id
        o['room_id'] = room_id
        return o

    def schedule_cleaning(self, schedule_id, admins):
        sc = {}
        sc['schedule_id'] = schedule_id
        sc['admin_id'] = random.randint(1, admins)
        return sc

    def is_ready(self, schedule_id, results):
        ir = {}
        ir['schedule_id'] = schedule_id
        ir['test_result_id'] = random.randint(1, results)
        return ir

    def notifies_doctor(self, schedule_id, doctor_id):
        nd = {}
        nd['schedule_id'] = schedule_id
        nd['doctor_id'] = doctor_id
        return nd

    def notifies_nurse(self, schedule_id, nurses):
        nn = {}
        nn['schedule_id'] = schedule_id
        nn['nurse_id'] = random.randint(1, nurses)
        return nn

    def books_room(self, schedule_id, nurses):
        br = {}
        br['schedule_id'] = schedule_id
        br['nurse_id'] = random.randint(1, nurses)
        return br

    def doctor_makes_an_appointment(self, schedule_id, doctor_id):
        dma = {}
        dma['schedule_id'] = schedule_id
        dma['doctor_id'] = doctor_id
        return dma

    def notifies_lab_assistant(self, assistants, schedule_id):
        nla = {}
        nla['lab_assistant_id'] = random.randint(1, assistants)
        nla['schedule_id'] = schedule_id
        return nla

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

    def add_n_payments(self, n, min_s, max_s, patients):
        for i in range(1, n):
            p = self.payment(min_s, max_s)
            mp = self.makes_a_payment(i, patients)
            self.dict_db['payment'].append(p)
            self.dict_db['makes_a_payment'].append(mp)

    def add_n_labs(self, n, rooms):
        for i in range(0, n):
            l = self.lab(rooms)
            self.dict_db['lab'].append(l)

    def add_n_test_results(self, n):
        for i in range(0, n):
            tr = self.test_results()
            self.dict_db['test_results'].append(tr)

    def add_n_checks_medical_history(self, n, patients, doctors):
        for i in range(0, n):
            cmh = self.checks_medical_history(patients, doctors)
            self.dict_db['checks_medical_history'].append(cmh)

    def add_n_sends_receipt(self, n, patients, accountants):
        for i in range(0, n):
            sr = self.sends_receipt(patients, accountants)
            self.dict_db['sends_receipt'].append(sr)

    def add_n_writes_message(self, n, patients, doctors):
        for i in range(0, n):
            wm = self.writes_message(patients, doctors)
            self.dict_db['writes_message'].append(wm)

    def add_n_enrolls(self, n, admins, inventories):
        for i in range(0, n):
            e = self.enrolls(admins, inventories)
            self.dict_db['enrolls'].append(e)

    def add_n_generates_results(self, n, labs, tests):
        for i in range(0, n):
            gr = self.generates_results(labs, tests)
            self.dict_db['generates_results'].append(gr)

    def add_n_makes_tests(self, n, labs, assistants):
        for i in range(0, n):
            mt = self.makes_tests(labs, assistants)
            self.dict_db['makes_tests'].append(mt)

    def add_n_writes_message_nurse(self, n, nurses, doctors):
        for i in range(0, n):
            wm = self.writes_message_nurse(nurses, doctors)
            self.dict_db['writes_message_nurse'].append(wm)

    def add_random_schedules_cleaning(self, schedule_id, h_admins):
        for i in range(1, random.randint(1, h_admins)):
            sc = self.schedule_cleaning(schedule_id, h_admins)
            self.dict_db['schedules_cleaning'].append(sc)

    def add_n_schedule(self, n, patients, doctors, rooms, h_admins, results, nurses, assistants):
        for i in range(1, n):
            s = self.schedule(patients, doctors, rooms)
            ma = self.makes_an_appointment(s['id1'], i)
            n = self.notifies(s['id1'], i)
            o = self.occupies(i, s['room'])
            ir = self.is_ready(i, results)
            nd = self.notifies_doctor(i, s['id2'])
            nn = self.notifies_nurse(i, nurses)
            br = self.books_room(i, nurses)
            dma = self.doctor_makes_an_appointment(i, s['id2'])
            nla = self.notifies_lab_assistant(assistants, i)

            self.dict_db['schedule'].append(s)
            self.dict_db['makes_an_appointment'].append(ma)
            self.dict_db['notifies'].append(n)
            self.dict_db['occupies'].append(o)
            self.dict_db['is_ready'].append(ir)
            self.dict_db['notifies_doctor'].append(nd)
            self.dict_db['notifies_nurse'].append(nn)
            self.dict_db['books_room'].append(br)
            self.dict_db['doctor_makes_an_appointment'].append(dma)
            self.dict_db['notifies_lab_assistant'].append(nla)

            self.add_random_schedules_cleaning(i, h_admins)

    def add_n_rooms(self, n):
        for i in range(1, n+1):
            r = self.room(i)
            self.dict_db['room'].append(r)

    def add_n_makes_a_request(self, n, patients, nurses):
        for i in range(0, n):
            mr = self.makes_a_request(patients, nurses)
            self.dict_db['makes_a_request'].append(mr)

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
