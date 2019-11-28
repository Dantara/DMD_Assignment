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
        let self = this;

        this.query1.onclick = () =>{
            self.controller.getQuery1();
        };
    }

    setQuery2(){
        let self = this;

        this.query2.onclick = () =>{
            self.controller.getQuery2();
        };
    }

    setQuery3(){
        let self = this;

        this.query3.onclick = () =>{
            self.controller.getQuery3();
        };
    }

    setQuery4(){
        let self = this;

        this.query4.onclick = () =>{
            self.controller.getQuery4();
        };
    }

    setQuery5(){
        let self = this;

        this.query5.onclick = () =>{
            self.controller.getQuery5();
        };
    }

    setAllBtns(){
        this.setQuery1();
        this.setQuery2();
        this.setQuery3();
        this.setQuery4();
        this.setQuery5();
    }
}
