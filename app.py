import hug

from support.templates import get_template
from controllers.queryController import QueryController

router = hug.route.API(__name__)

router.get('/query1')(QueryController.query1)
router.get('/query2')(QueryController.query2)
router.get('/query3')(QueryController.query3)
router.get('/query4')(QueryController.query4)
router.get('/query5')(QueryController.query5)

@hug.static('/static')
def static():
    return ['./static']

@hug.get('/', output=hug.output_format.html)
def root():
    template = get_template("index.html")
    return template.render({})
