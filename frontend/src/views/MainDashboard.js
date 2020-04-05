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
import { Stats } from '../components/stats/Stats';
import { Observer } from 'mobx-react';

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
    <Observer>
      {() => {
        return (
          <div style={styles.container}>
            <TopBar currentUser={store.main.currentUser} />
            <div style={styles.page}>
              <Switch>
                <Route path={`${match.path}/report/:medicalCenterId`}>
                  <Report medicalCenter={store.main.entity} />
                </Route>
                <Route path={`${match.path}/recommendation`}>
                  <Recommendation
                    loading={store.main.loadingRecommendation}
                    recommendation={store.main.patientRecommendation}
                    getRecommendation={store.main.getRecommendation} />
                </Route>
                <Route path={`${match.path}/admin/medical-centers`}>
                  <Admin medicalCenters={store.admin.medicalCanters} />
                </Route>
                <Route path={`${match.path}/stats`}>
                  <Stats medicalCenters={store.admin.medicalCanters}/>
                </Route>
              </Switch>
            </div>
          </div>
        )
      }}
    </Observer>
  )
};
