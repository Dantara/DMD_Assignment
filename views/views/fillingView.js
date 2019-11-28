import FillingController from '../controllers/fillingController.js';

export default class FillingView{
    constructor(){
        this.controller = new FillingController();

        this.patients_el = document.getElementById('patients');
        this.accountants_el = document.getElementById('accountants');

        this.generate_el = document.getElementById('generate');
        this.execute_el = document.getElementById('execute');
        this.erase_el = document.getElementById('erase');
    }

    constructData(){
        let data = {
            patients: this.patients_el.value,
            accountants: this.accountants_el.value
        };

        return data;
    }

    setGenerate(){
        let data = this.constructData();
        let self = this;

        this.generate_el.onclick = () => {
            self.controller.generate(data);
        };
    }

    setExecute(){
        let self = this;

        this.execute_el.onclick = () => {
            self.controller.execute();
        };
    }

    setErase(){
        let self = this;

        this.erase_el.onclick = () => {
            self.controller.erase();
        };
    }

    setAllBtns(){
        this.setExecute();
        this.setGenerate();
        this.setErase();
    }
}
