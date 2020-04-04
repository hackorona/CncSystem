/** @jsx jsx */
import React from 'react';
import { Button } from '@material-ui/core';
import { jsx } from '@emotion/core'

const styles = {
  button: {
    height: 67,
    color: '#fff',
    fontSize: 23,
    fontWeight: 'bold',
    letterSpacing: '0.03em',
    boxShadow: '0px 0px 11px rgba(33, 197, 170, 0.4)',
    borderRadius: 66,
    minWidth: 268,
  }
};

export const StyledButton = (props) => {
  return (
    <Button
      variant="contained"
      color="primary"
      disableElevation
      css={styles.button}
      {...props}
    >
      {props.children}
    </Button>
  )
};
