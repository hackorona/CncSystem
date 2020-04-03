/** @jsx jsx */
import React from 'react';
import { Typography } from '@material-ui/core';
import { AccountCircle } from '@material-ui/icons';
import { jsx } from '@emotion/core'

const styles = {
  toolbar: {
    width: '100%',
    height: 60,
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '14px 20px',
    boxSizing: 'border-box',
    background: '#fff',
  },
  userInfo: {
    display: 'flex',
    alignItems: 'center',
  },
  name: {
    paddingLeft: 5,
  },
  divider: {
    color: '#C4C4C4',
    paddingLeft: 5,
  },
  userIcon: {
    marginLeft: 10,
  },
  role: {
    color: '#C4C4C4'
  },
  title: {
  },
};

export const TopBar = ({ currentUser }) => {
  return (
    <div css={styles.toolbar}>
      <div css={styles.userInfo}>
        <AccountCircle fontSize="large" htmlColor="#E5E5E5" css={styles.userIcon}/>
        <Typography variant='h6' color='primary' css={styles.name}>{currentUser.name}</Typography>
        <Typography css={styles.divider}>|</Typography>
        <Typography variant='body2' css={styles.role}>{currentUser.role}</Typography>
      </div>
      <Typography variant="h6" color='primary' css={styles.title}>
        CoronaCare
      </Typography>
    </div>
  )
};
