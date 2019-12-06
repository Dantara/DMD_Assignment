import RootModel from './rootModel.js';

export default class QueryModel{
    constructor(){
        this.rootModel = new RootModel();
        this.sender = this.rootModel.sendGet;
        this.postSender = this.rootModel.sendPost;
    }

    sendQuery1(data, callback){
        this.postSender('/query1', data, callback);
    }

    sendQuery2(callback){
        this.sender('/query2', callback);
    }

    sendQuery3(data, callback){
        this.postSender('/query3', data, callback);
    }

    sendQuery4(callback){
        this.sender('/query4', callback);
    }

    sendQuery5(callback){
        this.sender('/query5', callback);
    }

}
