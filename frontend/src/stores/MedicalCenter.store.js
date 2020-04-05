import { observable, action, computed } from 'mobx';
import Department from './Department.store';

export default class MedicalCenter {
  @observable type = 'hospital';
  @observable id;
  @observable name;
  @observable address;
  @observable coords;
  @observable departments = [];

  constructor (data) {
    if (data) {
      this.id = data.id;
      this.type = data.type;
      this.name = data.name;
      this.address = data.address;
      this.coords = data.coords;
      this.departments = data.departments.map(department => new Department(department));
    }
  }
}
