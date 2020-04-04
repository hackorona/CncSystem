import React from 'react';
import withMobx from './HOCs/WithMobx';
import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Redirect
} from "react-router-dom";
import { Observer } from 'mobx-react';
import { Login } from './views/Login';
import createStore from './stores/index';
import { MainDashboard } from './views/MainDashboard';

const store = createStore();

const App = () => {
  return (
    <Observer>
      {() => {
        const { currentUser, isLoggedIn, onLogin } = store.main;

        return (
          <Router>
            <Switch>
              <Route exact path="/">
                {isLoggedIn ? <Redirect to="/dashboard" /> : <Redirect to="/login" />}
              </Route>
              <Route path="/login">
                {isLoggedIn ? <Redirect to="/dashboard/report/153" /> : <Login onLogin={onLogin}/>}
              </Route>
              <Route path="/dashboard">
                <MainDashboard store={store}/>
              </Route>
            </Switch>
          </Router>
        );
      }}
    </Observer>
  )
};

export default withMobx(
  App,
  store
);
