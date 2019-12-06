import QueryController from '../controllers/queryController.js';

export default class QueryView{
    constructor(){
        this.controller = new QueryController();
        this.query1 = document.getElementById('query1');
        this.query2 = document.getElementById('query2');
        this.query3 = document.getElementById('query3');
        this.query4 = document.getElementById('query4');
        this.query5 = document.getElementById('query5');

        this.query1_id_el = document.getElementById('query1_id');
        this.query1_given_date_el = document.getElementById('query1_given_date');
        this.query2_given_date_el = document.getElementById('query2_given_date');
    }

    updateTableHead(query_number){
        let head_elms = [];

        switch(query_number){
        case 1: {
            head_elms = ['room_number'];
            break;
        }
        case 2: {
            head_elms = ['id2', 'Day_Of_Week', 'count'];
            break;
        }
        case 3: {
            head_elms = ['id1'];
            break;
        }
        case 4: {
            head_elms = ['sum'];
            break;
        }
        case 5: {
            head_elms = ['did', 'count', 'sum', 'year'];
            break;
        }
        }

        let table = document.getElementById('query-table');
        table.innerHTML = '';

        let thead = document.createElement("thead");
        let top_tr = document.createElement("tr");
        head_elms.forEach((elm) => {
            let th = document.createElement("th");
            let text = document.createTextNode(elm);
            th.appendChild(text);
            top_tr.appendChild(th);
        });

        thead.appendChild(top_tr);
        table.appendChild(thead);
    }

    static updateTableBody(rows){
        let table = document.getElementById('query-table');

        let tbody = document.createElement("tbody");

        rows.forEach((row) => {
            let tr = document.createElement("tr");
            row.forEach((el) => {
                let th = document.createElement("th");
                let text = document.createTextNode(el);
                th.appendChild(text);
                tr.appendChild(th);
            });
            tbody.appendChild(tr);
        });

        table.appendChild(tbody);
    }

    setQuery1(){
        let self = this;

        this.query1.onclick = () => {
            let data = {
                given_id: this.query1_id_el.value,
                given_date: this.query1_given_date_el.value
            };
            self.updateTableHead(1);
            self.controller.getQuery1(data);
        };
    }

    setQuery2(){
        let self = this;

        this.query2.onclick = () => {
            self.updateTableHead(2);
            self.controller.getQuery2();
        };
    }

    setQuery3(){
        let self = this;

        this.query3.onclick = () => {
            let data = {
                given_date: this.query2_given_date_el.value
            };
            self.updateTableHead(3);
            self.controller.getQuery3(data);
        };
    }

    setQuery4(){
        let self = this;

        this.query4.onclick = () => {
            self.updateTableHead(4);
            self.controller.getQuery4();
        };
    }

    setQuery5(){
        let self = this;

        this.query5.onclick = () => {
            self.updateTableHead(5);
            self.controller.getQuery5();
        };
    }

    setAllBtns(){
        this.setQuery1();
        this.setQuery2();
        this.setQuery3();
        this.setQuery4();
        this.setQuery5();
    }
}
