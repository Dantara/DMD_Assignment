import FillingController from '../controllers/fillingController.js';

export default class FillingView{
    constructor(){
        this.controller = new FillingController();

        this.patients_el = document.getElementById('patients');
        this.h_admins_el = document.getElementById('h_admins');
        this.assistants_el = document.getElementById('assistants');
        this.s_admins_el = document.getElementById('s_admins');
        this.doctors_el = document.getElementById('doctors');
        this.nurses_el = document.getElementById('nurses');
        this.rooms_el = document.getElementById('rooms');

        this.generate_el = document.getElementById('generate');
        this.execute_el = document.getElementById('execute');
        this.erase_el = document.getElementById('erase');
    }

    constructData(){
        let data = {
            patients: this.patients_el.value,
            h_admins: this.h_admins_el.value,
            assistants: this.assistants_el.value,
            s_admins: this.s_admins_el.value,
            doctors: this.doctors_el.value,
            nurses: this.nurses_el.value,
            rooms: this.rooms_el.value,
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
