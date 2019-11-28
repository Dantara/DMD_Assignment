import 'bootstrap';
import '../assets/app.scss';
import ModeView from './views/modeView.js';
import QueryView from './views/queryView.js';
import FillingView from './views/fillingView.js';

let modeView = new ModeView();
modeView.setAutoUpdate();

let queryView = new QueryView();
queryView.setAllBtns();

let fillingView = new FillingView();
fillingView.setAllBtns();
