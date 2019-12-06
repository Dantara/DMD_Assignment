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

        this.min_salary_el = document.getElementById('min_salary');
        this.max_salary_el = document.getElementById('max_salary');
        this.salaries_el = document.getElementById('salaries');
        this.inventories_el = document.getElementById('inventories');
        this.payments_el = document.getElementById('payments');
        this.labs_el = document.getElementById('labs');
        this.results_el = document.getElementById('results');
        this.checks_el = document.getElementById('checks');
        this.receipts_el = document.getElementById('receipts');
        this.messages_el = document.getElementById('messages');
        this.enrolls_el = document.getElementById('enrolls');
        this.results_gen_el = document.getElementById('results_gen');
        this.test_el = document.getElementById('test');
        this.nurse_messages_el = document.getElementById('nurse_messages');
        this.schedule_el = document.getElementById('schedule');
        this.requests_el = document.getElementById('requests');

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
            min_salary: this.min_salary_el.value,
            max_salary: this.max_salary_el.value,
            salaries: this.salaries_el.value,
            inventories: this.inventories_el.value,
            payments: this.payments_el.value,
            labs: this.labs_el.value,
            results: this.results_el.value,
            checks: this.checks_el.value,
            receipts: this.receipts_el.value,
            messages: this.messages_el.value,
            enrolls: this.enrolls_el.value,
            results_gen: this.results_gen_el.value,
            test: this.test_el.value,
            nurse_messages: this.nurse_messages_el.value,
            schedule: this.schedule_el.value,
            requests: this.requests_el.value
        };

        return data;
    }

    setGenerate(){
        let self = this;

        this.generate_el.onclick = () => {
            let data = self.constructData();
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
