import RootStore from './Root';
import Main from './Main.store';
import Admin from './Admin.store';

const createStore = externalStore => {
  return new RootStore({
    main: new Main(),
    admin: new Admin(),
  });
};

export default createStore;
