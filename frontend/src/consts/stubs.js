export const userStub = {
  name: 'ענת לוי',
  role: 'אחות ראשית'
};

export const medicalCenterStub = {
  name: 'מרכז רפואי רבין - בילינסון',
  type: 'hospital',
  id: 153,
  address: 'שדרות ההסתדרות 55, חיפה',
  coords: {
    lat: '32.940930',
    lng: '35.075520',
  },
  departments: [{
    id: '01',
    name: 'אשפוז רגיל',
    patients: {
      stable: 3,
      serious: 4,
      critical: 5,
    },
    beds: {
      all: 40,
      used: 25,
    },
    ventilators: {
      all: 40,
      used: 25,
    }
  }, {
    id: '02',
    name: 'טיפול נמרץ',
    patients: {
      stable: 3,
      serious: 4,
      critical: 5,
    },
    beds: {
      all: 40,
      used: 25,
    },
    ventilators: {
      all: 40,
      used: 25,
    }
  }]
};

export const medicalCenterListStub = [
  medicalCenterStub, medicalCenterStub, medicalCenterStub
];
