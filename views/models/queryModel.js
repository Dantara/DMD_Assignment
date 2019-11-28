import RootModel from './rootModel.js';

export default class QueryModel{
    constructor(){
        this.rootModel = new RootModel();
        this.sender = this.rootModel.sendGet;
    }

    sendQuery1(){
        console.log('model');
        this.sender('/query1');
    }
}
