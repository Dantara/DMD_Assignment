import FillingModel from '../models/fillingModel.js';

export default class QueryController{
    constructor(){
        this.model = new FillingModel();
    }

    generate(data){
        this.model.sendGenerateRequest(data);
    }

    execute(){
        this.model.sendExecuteRequest();
    }

    erase(){
        this.model.sendEraseRequest();
    }

}
