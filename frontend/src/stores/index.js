import RootStore from './Root';
import Main from './Main.store';

const createStore = externalStore => {
  return new RootStore({
    main: new Main(),
  });
};

export default createStore;
