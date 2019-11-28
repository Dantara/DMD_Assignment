from shutil import copyfile

class FillingModel:
    gen_file = 'assets/tables_creating.sql'
    output_file = 'output/dump.sql'

    def copy_gen_file(self):
        copyfile(self.gen_file, self.output_file)
