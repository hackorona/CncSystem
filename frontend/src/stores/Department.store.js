import { observable, action, computed } from 'mobx';

export default class Department {
  @observable type = 'regular';
  @observable id;
  @observable name;
  @observable patients;
  @observable beds;
  @observable ventilators;

  constructor (data) {
    if (data) {
      this.id = data.id;
      this.type = data.type;
      this.name = data.name;
      this.patients = data.patients;
      this.beds = data.beds;
      this.ventilators = data.ventilators;
    }
  }
}
