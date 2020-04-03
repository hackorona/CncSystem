import React from 'react';
import { FormGroup, Typography } from '@material-ui/core';
import { useTheme } from '@material-ui/core/styles';
import corona_bg from '../images/corona_bg.jpg';
import { he } from '../strings/he';
import { StyledButton } from '../components/StyledButton';
import { StyledInput } from '../components/StyledInput';

const styles = {
  container: {
    display: 'flex',
    width: '100%',
    height: '100%',
  },
  title: {
    marginBottom: 42,
    fontSize: 38,
    color: '#707E82',
    letterSpacing: '0.01em',
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
  imageTextOverlay: {
    width: '100%',
    height: '100%',
    position: 'absolute',
    top: 0,
    left: 0,
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    color: '#fff',
  },
  button: {
    marginTop: 46,
    alignSelf: 'center'
  }
};

export const Login = ({ onLogin }) => {
  const theme = useTheme();

  return (
    <div style={styles.container}>
      <div style={styles.form}>
        <FormGroup style={styles.formInner}>
          <Typography variant="h4" style={styles.title}>
            <span
              style={{
                color: theme.palette.primary.main,
                fontWeight: 'bold'
              }}>
                {he.login.titleMain}
            </span> {he.login.titleSub}
          </Typography>
          <StyledInput label={he.login.username}/>
          <StyledInput
            label={he.login.password}
            type="password"
          />
          <StyledButton
            variant="contained"
            color="primary"
            onClick={onLogin}
            disableElevation
            style={styles.button}>
            {he.login.submit}
          </StyledButton>
        </FormGroup>
      </div>
      <div style={styles.imageContainer}>
        <div style={styles.image}/>
        <div style={styles.imageOverlay}/>
        <div style={styles.imageTextOverlay}>
          <Typography
            variant="h3"
            style={{ fontFamily: 'Poppins'}}>
            Corona<span style={{ fontWeight: 500 }}>Care</span>
          </Typography>
        </div>
      </div>
    </div>
  )
};
