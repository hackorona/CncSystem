import { observable, action, computed } from 'mobx';
import MedicalCenter from './MedicalCenter.store';
import { medicalCenterStub, userStub } from '../consts/stubs';
import cnc from '../services/cnc';

export default class Main {
  @observable isLoggedIn = false;
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

  @action onLogin = async (username, password) => {
    this.isLoggedIn = await cnc.login({username, password});

    // Mock to allow login flow
    this.isLoggedIn = true;
    this.currentUser = userStub;
    this.entity = new MedicalCenter(medicalCenterStub);
  }
}
