import RootModel from './rootModel.js';

export default class FillingModel{
    constructor(){
        this.rootModel = new RootModel();
        this.getSender = this.rootModel.sendGet;
        this.postSender = this.rootModel.sendPost;
    }

    sendGenerateRequest(data){
        this.postSender('/generate', data);
    }

    sendExecuteRequest(){
        this.getSender('/execute');
    }

    sendEraseRequest(){
        this.getSender('/erase');
    }

}
