/** @jsx jsx */
import React from 'react';
import { Typography } from '@material-ui/core';
import { jsx } from '@emotion/core'
import { Box } from '../Box';

const styles = {
  container: {
    height: '100%',
  },
  reportTitle: {
    color: '#90A1B5',
  },
  centerName: {
    marginBottom: '25px !important',
  },
  buttonContainer: {
    display: 'flex',
    justifyContent: 'center',
  },
  button: {
    width: 360,
  }
};

export const Recommendation = () => {
  return (
    <div css={styles.container}>
      <Box title="פרטי המטופל">
      </Box>
    </div>
  )
};
