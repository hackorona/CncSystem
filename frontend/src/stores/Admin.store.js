import { observable, action, computed } from 'mobx';
import { medicalCenterListStub, medicalCenterStub1 } from '../consts/stubs';
import MedicalCenter from './MedicalCenter.store';

export default class Admin {
  @observable medicalCanters = [];

  constructor (externalStore) {
    if (externalStore) {
      Object.assign(this, externalStore);
    }
  }

  init (rootStore) {
    this.rootStore = rootStore;
    this.getMedicalCenters();
    return this;
  }

  @action getMedicalCenters = () => {
    this.medicalCanters = medicalCenterListStub.map(center => new MedicalCenter(center));
  };

  @action addCenter = () => {
    const centerToAdd = {
      ...medicalCenterStub1,
      ...{
        id: 11,
        name: 'מרכז רפואי וולפסון',
        address: 'רחוב הלוחמים 62, חולון'
      }
    };
    this.medicalCanters.push(new MedicalCenter(centerToAdd));
  }
}
