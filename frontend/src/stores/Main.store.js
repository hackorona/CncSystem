import { observable, action, computed } from 'mobx';
import MedicalCenter from './MedicalCenter.store';

const userStub = {
  name: 'ענת לוי',
  role: 'אחות ראשית'
};

const medicalCenterStub = {
  name: 'מרכז רפואי רבין - בילינסון',
  type: 'hospital',
  id: 153,
  departments: [{
    id: '01',
    name: 'אשפוז רגיל',
    patients: {
      stable: 3,
      serious: 4,
      critical: 5,
    }
  }, {
    id: '02',
    name: 'טיפול נמרץ',
    patients: {
      stable: 3,
      serious: 4,
      critical: 5,
    }
  }]
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
