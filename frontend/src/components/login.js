import React from 'react';
import { FormGroup, TextField, Typography } from '@material-ui/core';
import corona_bg from '../images/corona_bg.jpg';
import { strings } from '../strings/strings';
import { StyledButton } from './StyledButton';

const styles = {
  container: {
    display: 'flex',
    width: '100%',
    height: '100%',
  },
  form: {
    display: 'flex',
    flex: '1 1 auto',
    justifyContent: 'center',
    alignItems: 'center',
  },
  formInner: {
    maxWidth: 480,
  },
  imageContainer: {
    width: '30%',
    height: '100%',
    position: 'relative',
  },
  image: {
    width: '100%',
    height: '100%',
    background: `url(${corona_bg}) no-repeat 0 0`,
    backgroundSize: 'cover',
    opacity: 0.17,
  },
  imageOverlay: {
    width: '100%',
    height: '100%',
    position: 'absolute',
    top: 0,
    left: 0,
    background: 'linear-gradient(144.74deg, #187C6A 0%, #55F2CE 99.99%, #68FFDC 100%)',
    mixBlendMode: 'multiply',
    transform: 'rotate(-180deg)',
  },
  button: {
    marginTop: 60,
    alignSelf: 'center'
  }
};

export const Login = () => (
  <div style={styles.container}>
    <div style={styles.form}>
      <FormGroup style={styles.formInner}>
        <Typography variant="h4">
          {strings.login.titleMain} {strings.login.titleSub}
        </Typography>
        <TextField label={strings.login.username}/>
        <TextField label={strings.login.password}/>
        <StyledButton
          variant="contained"
          color="primary"
          disableElevation
          style={styles.button}>
            {strings.login.submit}
        </StyledButton>
      </FormGroup>
    </div>
    <div style={styles.imageContainer}>
      <div style={styles.image}/>
      <div style={styles.imageOverlay}/>
    </div>
  </div>
);
