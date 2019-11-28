import QueryController from '../controllers/queryController.js';

export default class QueryView{
    constructor(){
        this.controller = new QueryController();
        this.query1 = document.getElementById('query1');
        this.query2 = document.getElementById('query2');
        this.query3 = document.getElementById('query3');
        this.query4 = document.getElementById('query4');
        this.query5 = document.getElementById('query5');
    }

    setQuery1(){
        console.log('view');
        let self = this;
        function update(){
            self.controller.getQuery1();
        }
        this.query1.onclick = update;
    }

    setAllBtns(){
        this.setQuery1();
    }
}
