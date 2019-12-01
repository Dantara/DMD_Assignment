from shutil import copyfile
from models.rootModel import RootModel
from faker import Faker
from faker.providers import phone_number, profile, lorem
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
        self.faker.add_provider(lorem)
        self.faker_RU = Faker('ru_RU')
        self.faker_RU.add_provider(phone_number)

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
        sql = "INSERT INTO " + table_name + " VALUES ("
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

    def add_accountant(self, p):
        a = {'name': p['name'], 'email': p['email'], 'password': p['password']}
        f = open(self.output_file, 'a')
        sql = self.dict_to_sql(a, 'ACCOUNTANT')
        f.write(sql)
        f.close()

    def add_n_patients(self, n, rooms):
        for i in range(0, n):
            p = self.patient(rooms)
            self.add_accountant(p)
            f = open(self.output_file, 'a')
            sql = self.dict_to_sql(p, 'PATIENT')
            f.write(sql)
            f.close()

    def add_n_h_admins(self, n):
        for i in range(0, n):
            p = self.person()
            self.add_accountant(p)
            f = open(self.output_file, 'a')
            sql = self.dict_to_sql(p, 'HOSPITAL_ADMINISTRATOR')
            f.write(sql)
            f.close()

    def add_n_assistants(self, n):
        for i in range(0, n):
            p = self.person()
            self.add_accountant(p)
            f = open(self.output_file, 'a')
            sql = self.dict_to_sql(p, 'LABORATORY_ASSISTANT')
            f.write(sql)
            f.close()

    def add_n_s_admins(self, n):
        for i in range(0, n):
            p = self.person()
            self.add_accountant(p)
            f = open(self.output_file, 'a')
            sql = self.dict_to_sql(p, 'SYSTEM_ADMINISTRATOR')
            f.write(sql)
            f.close()

    def add_n_doctors(self, n):
        for i in range(0, n):
            p = self.doctor()
            self.add_accountant(p)
            f = open(self.output_file, 'a')
            sql = self.dict_to_sql(p, 'DOCTOR')
            f.write(sql)
            f.close()

    def add_n_nurses(self, n):
        for i in range(0, n):
            p = self.person()
            self.add_accountant(p)
            f = open(self.output_file, 'a')
            sql = self.dict_to_sql(p, 'NURSE')
            f.write(sql)
            f.close()


