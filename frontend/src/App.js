import React from 'react';
import withMobx from './HOCs/WithMobx';
import './App.css';
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
          <MainDashboard store={store}/>
        );
      }}
    </Observer>
  )
};

export default withMobx(
  App,
  store
);
