/** @jsx jsx */
import React from 'react';
import { FormGroup, FormControlLabel, RadioGroup, Radio, TextField, Typography, } from '@material-ui/core';
import { LocationOn } from '@material-ui/icons'
import { jsx } from '@emotion/core'
import { Box } from '../Box';
import { StyledButton } from '../StyledButton';

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
    display: 'flex',
    flex: '1 1 40%',
    justifyContent: 'center',
    alignItems: 'center',
  },
  locationBox: {
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    flexDirection: 'column',
    textAlign: 'center',
    background: '#FFFFFF',
    boxShadow: '0px 0px 18px rgba(0, 0, 0, 0.16)',
    borderRadius: 3,
    width: '80%',
    padding: '40px 0 60px 0',
  },
  icon: {
    borderRadius: '50%',
    background: '#F7685B',
    width: 40,
    height: 40,
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
  },
  formContainer: {
    padding: '50px 90px'
  },
  input: {
    flexGrow: 1,
  },
  row: {
    marginBottom: 10,
    alignItems: 'center',
  },
  label: {
    width: 110,
  },
  radioGroup: {
    display: 'flex',
    flexDirection: 'row !important',
    marginBottom: 60,
  },
  buttonContainer: {
    display: 'flex',
    justifyContent: 'center',
  },
  button: {
    width: '100%',
  }
};

export const Recommendation = () => {
  return (
    <div css={styles.container}>
      <Typography variant='h5' css={styles.title}>
        הפניית חולים חיוביים
      </Typography>
      <Typography css={styles.subtitle}>
        הזינו את פרטי המטופל על מנת לקבל המלצה למקום אישפוזו
      </Typography>
      <div css={styles.containerInner}>
        <Box title="פרטי המטופל" css={styles.details}>
          <div css={styles.formContainer}>
            <FormGroup row css={styles.row}>
              <Typography css={styles.label}>
               תעודת זהות
              </Typography>
              <TextField
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
                variant='outlined'
                size='small'
                css={styles.input}
              />
            </FormGroup>
            <FormGroup>
              <Typography>
              האם קיים סיכוי גבוה להחמרה במצב?
              </Typography>
              <RadioGroup
                aria-label="patient-state"
                name="patient-state"
                value={"yes"}
                onChange={() => {}}
                css={styles.radioGroup}
              >
                <FormControlLabel value="yes" control={<Radio />} label="כן" />
                <FormControlLabel value="no" control={<Radio />} label="לא" />
              </RadioGroup>
            </FormGroup>

            <div css={styles.buttonContainer}>
              <StyledButton css={styles.button}>
                קבלת המלצה
              </StyledButton>
            </div>
          </div>
        </Box>
        <div css={styles.location}>
          <div css={styles.locationBox}>
            <div css={styles.icon}>
              <LocationOn htmlColor='#fff' />
            </div>
            <Typography variant='h5'>המלצת אשפוז</Typography>
            <Typography variant='h4' color='primary'>מרכז רפואי רבין - בילינסון</Typography>
            <Typography variant='h6'>
              רחוב זאב ז׳בוטינסקי 39, פתח תקווה
            </Typography>
          </div>
        </div>
      </div>
    </div>
  )
};
