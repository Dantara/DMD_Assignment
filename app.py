import hug

from support.templates import get_template
from controllers.queryController import QueryController
from controllers.fillingController import FillingController
from controllers.readController import ReadController

router = hug.route.API(__name__)

router.post('/query1')(QueryController().query1)
router.get('/query2')(QueryController().query2)
router.post('/query3')(QueryController().query3)
router.get('/query4')(QueryController().query4)
router.get('/query5')(QueryController().query5)

router.post('/generate')(FillingController().generate)
router.get('/execute')(FillingController().execute)
router.get('/erase')(FillingController().erase)

router.get('/names')(ReadController().names)
router.post('/table')(ReadController().table)

@hug.static('/static')
def static():
    return ['./static']

@hug.get('/', output=hug.output_format.html)
def root():
    template = get_template("index.html")
    return template.render({})
