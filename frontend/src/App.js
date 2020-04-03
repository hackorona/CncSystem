import React from 'react';
import withMobx from './HOCs/WithMobx';
import logo from './logo.svg';
import './App.css';
import { Observer } from 'mobx-react';
import { Login } from './components/Login';
import createStore from './stores/index';

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
          <div className="App">
            <header className="App-header">
              <img src={logo} className="App-logo" alt="logo"/>
              <p>
                Edit <code>src/App.js</code> and save to reload.
              </p>
              <a
                className="App-link"
                href="https://reactjs.org"
                target="_blank"
                rel="noopener noreferrer"
              >
                Learn React
              </a>
            </header>
          </div>
        );
      }}
    </Observer>
  )
};

export default withMobx(
  App,
  store
);
