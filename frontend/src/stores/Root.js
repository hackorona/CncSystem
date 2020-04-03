class RootStore {
  constructor (stores) {
    const storesWithRef = Object.keys(stores).reduce((acc, key) => {
      return ({
        ...acc,
        [key]: stores[key].init(this),
      });
    }, {},
    );
    Object.assign(this, storesWithRef);
  }
}

export default RootStore;
