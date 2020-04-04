/** @jsx jsx */
import React from 'react';
import { FormGroup, TextField, Typography } from '@material-ui/core';
import { jsx } from '@emotion/core'
import { Box } from '../Box';

const styles = {
  container: {
    height: '100%',
  },
  containerInner: {
    display: 'flex',
  },
  details: {
    flex: '1 1 50%'
  },
  location: {
    flex: '1 1 40%',
  },
  subtitle: {
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
      <Typography variant='h5' css={styles.title}>
        הפניית חולים חיוביים
      </Typography>
      <Typography>
        הזינו את פרטי המטופל על מנת לקבל המלצה למקום אישפוזו
      </Typography>
      <div css={styles.containerInner}>
        <Box title="פרטי המטופל" css={styles.details}>
          <FormGroup row css={styles.row}>
            <Typography css={styles.label}>
             תעודת זהות
            </Typography>
            <TextField
              type="number"
              variant='outlined'
              size='small'
              css={styles.input}
            />
          </FormGroup>
          <FormGroup row css={styles.row}>
            <Typography css={styles.label}>
            עיר מגורים
            </Typography>
            <TextField
              type="number"
              variant='outlined'
              size='small'
              css={styles.input}
            />
          </FormGroup>
          <FormGroup row css={styles.row}>
            <Typography css={styles.label}>
            רחוב
            </Typography>
            <TextField
              type="number"
              variant='outlined'
              size='small'
              css={styles.input}
            />
          </FormGroup>
        </Box>
        <div css={styles.location}/>
      </div>
    </div>
  )
};
