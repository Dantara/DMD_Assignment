import QueryModel from '../models/queryModel.js';

export default class QueryController{
    constructor(){
        this.queryModel = new QueryModel();
    }

    getQuery1(){
        console.log('controller');
        this.queryModel.sendQuery1();
    }
}
