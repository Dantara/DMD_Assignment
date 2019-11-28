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

    setAutoUpdate(){
        this.select_el.onchange = this.updateTable;
    }
}
