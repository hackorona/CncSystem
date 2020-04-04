import React from 'react';
import withMobx from './HOCs/WithMobx';
import './App.css';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
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
        const { currentUser, onLogin } = store.main;

        if (!currentUser) {
          return <Login onLogin={onLogin}/>
        }

        return (
          <Router>
          <Switch>
            <Route path="/login">
              <Login onLogin={onLogin}/>
            </Route>
            <Route path="/report">
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
