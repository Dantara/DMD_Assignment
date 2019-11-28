import RootModel from './rootModel.js';

export default class QueryModel{
    constructor(){
        this.rootModel = new RootModel();
        this.sender = this.rootModel.sendGet;
    }

    sendQuery1(){
        this.sender('/query1', null);
    }

    sendQuery2(){
        this.sender('/query2', null);
    }

    sendQuery3(){
        this.sender('/query3', null);
    }

    sendQuery4(){
        this.sender('/query4', null);
    }

    sendQuery5(){
        this.sender('/query5', null);
    }

}
