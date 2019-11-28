import ReadModel from '../models/readModel.js';
import ReadView from '../views/readView.js';

export default class ReadController{
    constructor(){
        this.model = new ReadModel();
        this.view = new ReadView();
    }

    getNames(){
        this.model.sendNamesRequest(this.updateOptions);
    }

    getTable(name){
        this.model.sendTableRequest(name, this.updateTable);
    }

    updateOptions(data){
        let names = ReadModel.parseNames(data);
        ReadView.updateOptions(names.sort());
    }

    updateTable(data){
        console.log(data);
        ReadView.updateTable(data);
    }

}
