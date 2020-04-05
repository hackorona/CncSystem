export const userStub = {
  name: 'ענת לוי',
  role: 'אחות ראשית'
};

export const medicalCenterStub1 = {
  name: 'מרכז רפואי רבין - בילינסון',
  type: 'hospital',
  id: 2,
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
export const medicalCenterStub2 = {
  name: 'מרכז רפואי מעיני הישועה',
  type: 'hospital',
  id: 10,
  address: 'רחוב הרב פוברסקי 17, בני ברק',
  coords: {
    lat: '31.258310',
    lng: '34.801800',
  },
  departments: [{
    id: '01',
    name: 'אשפוז רגיל',
    patients: {
      stable: 7,
      serious: 2,
      critical: 3,
    },
    beds: {
      all: 20,
      used: 15,
    },
    ventilators: {
      all: 10,
      used: 2,
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
export const medicalCenterStub3 = {
  name: 'מרכז רפואי איכילוב',
  type: 'hospital',
  id: 7,
  address: 'רחוב ויצמן 6, ,תל אביב-יפו',
  coords: {
    lat: '32.080585',
    lng: '34.789757',
  },
  departments: [{
    id: '01',
    name: 'אשפוז רגיל',
    patients: {
      stable: 7,
      serious: 2,
      critical: 3,
    },
    beds: {
      all: 20,
      used: 15,
    },
    ventilators: {
      all: 10,
      used: 2,
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
  medicalCenterStub1, medicalCenterStub2, medicalCenterStub3
];
