import { observable, action, computed } from 'mobx';
import MedicalCenter from './MedicalCenter.store';

export default class Main {
  @observable currentUser;

  constructor (externalStore) {
    if (externalStore) {
      Object.assign(this, externalStore);
    }
  }

  init (rootStore) {
    this.rootStore = rootStore;
    return this;
  }

  @action onLogin = ({ username, password }) => {
    this.currentUser = new MedicalCenter();
  }

}
