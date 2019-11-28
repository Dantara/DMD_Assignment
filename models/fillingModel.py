from shutil import copyfile
from models.rootModel import RootModel

class FillingModel(RootModel):
    def __init__(self):
        super().__init__()
        self.gen_file = 'database/schema.sql'
        self.erase_file = 'database/erase.sql'
        self.output_file = 'output/dump.sql'

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
