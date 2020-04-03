import { observable, action, computed } from 'mobx';
import MedicalCenter from './MedicalCenter.store';

const userStub = {
  name: 'ענת לוי',
  role: 'אחות ראשית'
};

export default class Main {
  @observable currentUser = userStub;
  @observable entity;

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
    this.currentUser = userStub;
    this.entity = new MedicalCenter();
  }

}
