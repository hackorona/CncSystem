/** @jsx jsx */
import React from 'react';
import { jsx } from '@emotion/core'
import { Typography } from '@material-ui/core';

const styles = {
  box: {
    background: '#fff',
    border: '1px solid #B0B4B3',
    borderRadius: 3,
    marginBottom: 32,
  },
  title: {
    background: '#F5F6F8',
    fontWeight: 600,
    padding: '15px 20px',
  },
};

export const Box = (props) => (
  <div css={styles.box} {...props}>
    {props.title &&
      <div css={styles.title}>
        <Typography variant='h6'>{props.title}</Typography>
      </div>
    }
    {props.children}
  </div>
);
