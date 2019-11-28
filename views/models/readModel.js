import RootModel from './rootModel.js';

export default class ReadModel{
    constructor(){
        this.rootModel = new RootModel();
        this.getSender = this.rootModel.sendGet;
        this.postSender = this.rootModel.sendPost;
    }

    sendNamesRequest(callback){
        return this.getSender('/names', callback);
    }

    sendTableRequest(name, callback){
        return this.postSender('/table', {name: name}, callback);
    }

    static parseNames(data){
        if(data.names.length == 0){
            return [];
        }else{
            let names = data.names.map((name) => {
                return name[0];
            });

            return names;
        }
   }
}

