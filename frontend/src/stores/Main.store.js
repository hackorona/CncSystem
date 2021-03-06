import { observable, action, computed } from 'mobx';
import MedicalCenter from './MedicalCenter.store';
import { medicalCenterStub3, userStub } from '../consts/stubs';
import cnc from '../services/cnc';

export default class Main {
  @observable isLoggedIn = false;
  @observable currentUser = userStub;
  @observable patientRecommendation;
  @observable loadingRecommendation = false;
  @observable entity;

  constructor (externalStore) {
    if (externalStore) {
      Object.assign(this, externalStore);
    }
  }

  init (rootStore) {
    this.rootStore = rootStore;
    if (this.currentUser) {
      this.entity = new MedicalCenter(medicalCenterStub3);
    }
    return this;
  }

  @action onLogin = async (username, password) => {
    this.isLoggedIn = await cnc.login({username, password});

    // Mock to allow login flow
    this.isLoggedIn = true;
    this.currentUser = userStub;
    this.entity = new MedicalCenter(medicalCenterStub3);
  };

  @action getRecommendation = () => {
    this.loadingRecommendation = true;
    setTimeout(() => {
      this.loadingRecommendation = false;
      this.patientRecommendation = [
        {
          name: 'מרכז רפואי רבין - בילינסון',
          address: 'רחוב זאב ז׳בוטינסקי 39, פתח תקווה'
        },
        {
          name: 'מרכז רפואי מעיני הישועה',
          address: 'רחוב הרב פוברסקי 17, בני ברק'
        }
      ]
    }, 1500);

  }
}
