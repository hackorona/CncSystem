/** @jsx jsx */
import React from 'react';
import { Typography, } from '@material-ui/core';
import { jsx } from '@emotion/core'
import bed from '../../images/bed.svg';
import ventilator from '../../images/ventilator.svg';
import { StyledPieChart } from '../StyledPieChart';

const styles = {
  container: {
    height: '100%',
  },
  containerInner: {
    display: 'flex',
  },
  title: {
    marginBottom: '45px !important',
  },
  icon: {
    borderRadius: '50%',
    background: '#F7685B',
    width: 40,
    height: 40,
    marginBottom: 10,
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
  },
  radioGroup: {
    display: 'flex',
    flexDirection: 'row !important',
    alignItems: 'center',
  },
  buttonContainer: {
    marginTop: 60,
    display: 'flex',
    justifyContent: 'center',
  },
  button: {
    width: '100%',
  },
  shadowBox: {
    background: '#fff',
    boxShadow: '0px 6px 18px rgba(0, 0, 0, 0.06)',
    borderRadius: 10,
    width: '100%',
    marginBottom: 35,
  },
  boxTitle: {
    borderBottom: '1px solid #EBEFF2',
    padding: '20px 20px 15px 10px',
    fontWeight: '600 !important',
  },
  mapContainer: {
    width: '40%',
  },
  statsContainer: {
    flexGrow: 1,
    marginRight: 60,
    display: 'flex'
  },
  chartContainer: {
    display: 'flex',
    alignItems: 'center',
    flexDirection: 'column',
    padding: '40px 0',
  },
  column: {
    marginRight: 40,
    flexGrow: 1,
    display: 'flex',
    flexDirection: 'column',
  },
  boxInner: {
    display: 'flex',
    padding: 30,
    paddingLeft: 10,
  }
};

export const Stats = () => {
  return (
    <div css={styles.container}>
      <Typography variant='h5' css={styles.title}>
        ריכוז נתוני מרכזים רפואיים
      </Typography>
      <div css={styles.containerInner}>
        <div css={styles.mapContainer}>
          <div css={styles.shadowBox}>
            map
          </div>
        </div>
        <div css={styles.statsContainer}>
          <div css={styles.column}>
            <div css={styles.shadowBox}>
              <div css={styles.boxInner}>
                <img src={bed}/>
                <div>
                  <Typography variant='h5'>6000</Typography>
                  <Typography>מיטות אשפוז פנויות</Typography>
                  <Typography variant='caption'>סה״כ מיטות אשפוז: 1000</Typography>
                </div>
              </div>
            </div>
            <div css={styles.shadowBox}>
              <Typography variant='subtitle1' css={styles.boxTitle}>
                מיטות אשפוז פנויות
              </Typography>
              <div css={styles.chartContainer}>
              <StyledPieChart/>
              </div>
            </div>
          </div>
          <div css={styles.column}>
            <div css={styles.shadowBox}>
              <div css={styles.boxInner}>
                <img src={ventilator}/>
                <div>
                  <Typography variant='h5'>800</Typography>
                  <Typography>מכונות הנשמה פנויות</Typography>
                  <Typography variant='caption'>סה״כ מכונות הנשמה: 1000</Typography>
                </div>
              </div>
            </div>
            <div css={styles.shadowBox}>
              <Typography variant='subtitle1' css={styles.boxTitle}>
                מכונות הנשמה פנויות
              </Typography>
              <StyledPieChart/>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
};
