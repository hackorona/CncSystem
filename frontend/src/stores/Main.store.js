import { observable, action, computed } from 'mobx';
import MedicalCenter from './MedicalCenter.store';
import { medicalCenterStub, userStub } from '../consts/stubs';

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
    if (this.currentUser) {
      this.entity = new MedicalCenter(medicalCenterStub);
    }
    return this;
  }

  @action onLogin = ({ username, password }) => {
    this.currentUser = userStub;
    this.entity = new MedicalCenter(medicalCenterStub);
  }
}
