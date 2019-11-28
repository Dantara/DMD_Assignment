import 'bootstrap';
import '../assets/app.scss';
import ModeView from './views/modeView.js';
import QueryView from './views/queryView.js';

let modeView = new ModeView();
modeView.setAutoUpdate();

let queryView = new QueryView();
queryView.setAllBtns();
