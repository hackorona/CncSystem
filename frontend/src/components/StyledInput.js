/** @jsx jsx */
import React from 'react';
import { TextField } from '@material-ui/core';
import { jsx } from '@emotion/core'

const styles = {
  textField: {
    fontSize: 23,
    marginBottom: 22,
  }
};

export const StyledInput = (props) => {
  return (
    <TextField
      variant="filled"
      InputProps={{disableUnderline: true}}
      css={styles.textField}
      {...props}
    />
  )
};
