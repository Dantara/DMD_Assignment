import QueryModel from '../models/queryModel.js';
import QueryView from '../views/queryView.js';

export default class QueryController{
    constructor(){
        this.model = new QueryModel();
    }

    getQuery1(data){
        this.model.sendQuery1(data, this.updateTableBody);
    }

    getQuery2(){
        this.model.sendQuery2(this.updateTableBody);
    }

    getQuery3(data){
        this.model.sendQuery3(data, this.updateTableBody);
    }

    getQuery4(){
        this.model.sendQuery4(this.updateTableBody);
    }

    getQuery5(){
        this.model.sendQuery5(this.updateTableBody);
    }

    updateTableBody(data){
        let rows = data.rows;
        console.log(rows);
        QueryView.updateTableBody(rows);
    }

}
