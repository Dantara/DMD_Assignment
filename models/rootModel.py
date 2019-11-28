import psycopg2
import json

class RootModel:
    def __init__(self):
        self.config_file = 'config/postgres.json'

        self.conn_config = json.load(open(self.config_file))
        self.conn = psycopg2.connect(
            dbname = self.conn_config['dbname'],
            user = self.conn_config['user'],
            host = self.conn_config['host'],
            password = self.conn_config['password'],
            port = self.conn_config['port'],
        )

