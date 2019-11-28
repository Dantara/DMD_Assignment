import hug
from support.templates import get_template

@hug.get('/', output=hug.output_format.html)
def root():
    template = get_template("index.html")
    return template.render({})

@hug.get('/query1', output=hug.output_format.json)
def select1():
    print('query1')
    return {"data": "data"}

@hug.static('/static')
def static():
    return ['./static']
