import React from 'react';
import { TopBar } from '../components/TopBar';

const styles = {
  container: {
    height: '100%',
    background: '#E5E5E5'
  },
  page: {
    margin: '45px 50px 0 50px',
    height: 500,
    background: 'white'
  }
};

export const MainDashboard = ({ store }) => {
  return (
    <div style={styles.container}>
      <TopBar currentUser={store.main.currentUser} />
      <div style={styles.page}/>
    </div>
  )
};
