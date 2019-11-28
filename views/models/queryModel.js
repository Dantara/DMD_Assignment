import RootModel from './rootModel.js';

export default class QueryModel{
    constructor(){
        this.rootModel = new RootModel();
        this.sender = this.rootModel.sendGet;
    }

    sendQuery1(){
        this.sender('/query1');
    }

    sendQuery2(){
        this.sender('/query2');
    }

    sendQuery3(){
        this.sender('/query3');
    }

    sendQuery4(){
        this.sender('/query4');
    }

    sendQuery5(){
        this.sender('/query5');
    }

}
