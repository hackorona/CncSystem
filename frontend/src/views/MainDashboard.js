import React from 'react';
import {
  Switch,
  Route,
  useRouteMatch,
} from "react-router-dom";
import { TopBar } from '../components/TopBar';
import { Report } from '../components/report/Report';
import { Recommendation } from '../components/recommendation/Recommendation';
import { Admin } from '../components/admin/Admin';

const styles = {
  container: {
    height: '100%',
  },
  page: {
    height: '100%',
    background: '#FBFBFB',
    padding: '45px 50px 0 50px',
    minHeight: 500,
    paddingBottom: 60,
  }
};

export const MainDashboard = ({ store }) => {
  let match = useRouteMatch();
  return (
    <div style={styles.container}>
      <TopBar currentUser={store.main.currentUser} />
      <div style={styles.page}>
        <Switch>
          <Route path={`${match.path}/report/:medicalCenterId`}>
            <Report medicalCenter={store.main.entity} />
          </Route>
          <Route path={`${match.path}/recommendation`}>
            <Recommendation medicalCenter={store.main.entity} />
          </Route>
          <Route path={`${match.path}/admin/medical-centers`}>
            <Admin medicalCenters={store.admin.medicalCanters} />
          </Route>
        </Switch>
      </div>
    </div>
  )
};
