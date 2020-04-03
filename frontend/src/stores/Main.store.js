import { observable, action, computed } from 'mobx';

export default class Main {
  @observable isLoggedIn = false;

  constructor (externalStore) {
    if (externalStore) {
      Object.assign(this, externalStore);
    }
  }

  init (rootStore) {
    this.rootStore = rootStore;
    return this;
  }

}
