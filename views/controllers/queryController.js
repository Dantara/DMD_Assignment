import QueryModel from '../models/queryModel.js';

export default class QueryController{
    constructor(){
        this.model = new QueryModel();
    }

    getQuery1(){
        this.model.sendQuery1();
    }

    getQuery2(){
        this.model.sendQuery2();
    }

    getQuery3(){
        this.model.sendQuery3();
    }

    getQuery4(){
        this.model.sendQuery4();
    }

    getQuery5(){
        this.model.sendQuery5();
    }

}
