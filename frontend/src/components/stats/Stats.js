/** @jsx jsx */
import React from 'react';
import { Typography, } from '@material-ui/core';
import { jsx } from '@emotion/core'
import bed from '../../images/bed.svg';
import ventilator from '../../images/ventilator.svg';
import { StyledPieChart } from '../StyledPieChart';
import { MainMap } from '../Map/MainMap';

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
    background: 'rgba(111, 82, 237, 0.07)',
    width: 86,
    height: 86,
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 25,
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
  },
};

const StatBox = ({ icon, num, title, subtitle, color, backgroundColor }) => (
  <div css={styles.boxInner}>
    <div css={styles.icon} style={{backgroundColor}}>
      <img src={icon}/>
    </div>
    <div>
      <Typography variant='h5' style={{ color, fontWeight: 600 }}>{num}</Typography>
      <Typography>{title}</Typography>
      <Typography variant='caption'>
        {subtitle}
      </Typography>
    </div>
  </div>
);

export const Stats = () => {
  return (
    <div css={styles.container}>
      <Typography variant='h5' css={styles.title}>
        ריכוז נתוני מרכזים רפואיים
      </Typography>
      <div css={styles.containerInner}>
        <div css={styles.mapContainer}>
          <div css={styles.shadowBox} style={{ height: 500 }}>
            <Typography variant='subtitle1' css={styles.boxTitle}>
              מפת מרכזים רפואיים
            </Typography>
            <MainMap/>
          </div>
        </div>
        <div css={styles.statsContainer}>
          <div css={styles.column}>
            <div css={styles.shadowBox}>
              <StatBox
                num={600}
                color={'#6F52ED'}
                title={"מיטות אשפוז פנויות"}
                subtitle={"סה״כ מיטות אשפוז: 1000"}
                icon={bed}
              />
            </div>
            <div css={styles.shadowBox}>
              <Typography variant='subtitle1' css={styles.boxTitle}>
                מיטות אשפוז פנויות
              </Typography>
              <div css={styles.chartContainer}>
                <StyledPieChart
                  availableTitle={'מיטות פנויות'}
                  occupiedTitle={'מיטות תפוסות'}
                  occupied={40}
                  available={60}
                  occupiedColor={'#6F52ED'}/>
              </div>
            </div>
          </div>

          <div css={styles.column}>
            <div css={styles.shadowBox}>
              <StatBox
                color={'#FFB946'}
                backgroundColor={'rgba(255, 185, 70, 0.07)'}
                num={800}
                title={"מכונות הנשמה פנויות"}
                subtitle={"סה״כ מכונות הנשמה: 1000"}
                icon={ventilator}/>
            </div>
            <div css={styles.shadowBox}>
              <Typography variant='subtitle1' css={styles.boxTitle}>
                מכונות הנשמה פנויות
              </Typography>
              <div css={styles.chartContainer}>
                <StyledPieChart
                  availableTitle={'מכונות הנשמה פנויות'}
                  occupiedTitle={'מכונות הנשמה תפוסות'}
                  occupied={40}
                  available={60}
                  occupiedColor={'#FFB946'} />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
};
