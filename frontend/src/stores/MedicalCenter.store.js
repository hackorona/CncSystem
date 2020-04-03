import { observable, action, computed } from 'mobx';

export default class MedicalCenter {
  @observable type = 'hospital';
  @observable name;
  @observable address;
  @observable departments = {};

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
