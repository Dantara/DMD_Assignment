import QueryModel from '../models/queryModel.js';

export default class QueryController{
    constructor(){
        this.queryModel = new QueryModel();
    }

    getQuery1(){
        this.queryModel.sendQuery1();
    }

    getQuery2(){
        this.queryModel.sendQuery2();
    }

    getQuery3(){
        this.queryModel.sendQuery3();
    }

    getQuery4(){
        this.queryModel.sendQuery4();
    }

    getQuery5(){
        this.queryModel.sendQuery5();
    }

}
