import ReadController from '../controllers/readController.js';

export default class ReadView{
    constructor(){
        this.select_el = document.getElementById('table-select');
    }

    updateTable(){
        let select_el = document.getElementById('table-select');
        let table_name = select_el.value;
        let controller = new ReadController();
        controller.getTable(table_name);
    }

    static updateOptions(names){
        let error_el = document.getElementById('table-not-exist');
        let exist_el = document.getElementById('table-exist');
        let select_el = document.getElementById('table-select');

        if(names.length == 0){
            error_el.style.display = 'block';
            exist_el.style.display = 'none';
        }else{
            error_el.style.display = 'none';
            exist_el.style.display = 'block';
            select_el.innerHTML = '';

            names.forEach((name) => {
                let option = document.createElement("option");
                let text = document.createTextNode(name);
                option.appendChild(text);
                select_el.appendChild(option);
            });
        }
    }

    static updateTable(data){
        let table = document.getElementById('read-table');
        table.innerHTML = '';

        let thead = document.createElement("thead");
        let top_tr = document.createElement("tr");

        data.columns.forEach((column) => {
            let th = document.createElement("th");
            let text = document.createTextNode(column);
            th.appendChild(text);
            top_tr.appendChild(th);
        });

        thead.appendChild(top_tr);
        table.appendChild(thead);

        let tbody = document.createElement("tbody");

        data.rows.forEach((row) => {
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

    setAutoUpdate(){
        this.select_el.onchange = this.updateTable;
    }
}
