import hug

from support.templates import get_template
from controllers import queryController

@hug.get('/', output=hug.output_format.html)
def root():
    template = get_template("index.html")
    return template.render({})

@hug.get('/query1')
def q1():
    return queryController.query1()

@hug.get('/query2')
def q2():
    return queryController.query2()

@hug.get('/query3')
def q3():
    return queryController.query3()

@hug.get('/query4')
def q4():
    return queryController.query4()

@hug.get('/query5')
def q5():
    return queryController.query5()

@hug.static('/static')
def static():
    return ['./static']
