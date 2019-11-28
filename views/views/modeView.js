export default class ModeView{
    constructor(){
        this.mode_el = document.getElementById('mode');
        this.queries = document.getElementById('queries');
        this.filling = document.getElementById('filling');
        this.read = document.getElementById('read');
        this.config = document.getElementById('config');
    }

    hideAll(){
        this.queries.style.display = "none";
        this.filling.style.display = "none";
        this.read.style.display = "none";
        this.config.style.display = "none";
    }

    setQueriesMode(){
        this.hideAll();
        this.queries.style.display = "flex";
    }

    setFillingMode(){
        this.hideAll();
        this.filling.style.display = "flex";
    }

    setReadMode(){
        this.hideAll();
        this.read.style.display = "flex";
    }

    setConfigMode(){
        this.hideAll();
        this.config.style.display = "flex";
    }

    updateMode(){
        let mode = this.mode_el.selectedIndex;

        switch(mode){
        case 0: {
            this.setQueriesMode();
            break;
        }
        case 1: {
            this.setFillingMode();
            break;
        }
        case 2: {
            this.setReadMode();
            break;
        }
        case 3: {
            this.setConfigMode();
            break;
        }
        }
    }

    setAutoUpdate(){
        let self = this;

        function update(){
            self.updateMode();
        }

        this.mode_el.onchange = update;
    }

}
