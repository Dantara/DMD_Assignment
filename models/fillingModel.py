from shutil import copyfile
import psycopg2
import json

class FillingModel:
    def __init__(self):
        self.config_file = 'config/postgres.json'
        self.gen_file = 'database/schema.sql'
        self.erase_file = 'database/erase.sql'
        self.output_file = 'output/dump.sql'

        self.conn_config = json.load(open(self.config_file))
        self.conn = psycopg2.connect(
            dbname = self.conn_config['dbname'],
            user = self.conn_config['user'],
            host = self.conn_config['host'],
            password = self.conn_config['password'],
            port = self.conn_config['port'],
        )

    def copy_gen_file(self):
        copyfile(self.gen_file, self.output_file)

    def execute_file(self, f):
        self.conn.rollback()
        cursor = self.conn.cursor();
        cursor.execute(open(f, 'r').read())
        self.conn.commit()

    def execute_output(self):
        self.execute_file(self.output_file)

    def execute_erase(self):
        self.execute_file(self.erase_file)
