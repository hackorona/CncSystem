/** @jsx jsx */
import React from 'react';
import ReactMinimalPieChart from 'react-minimal-pie-chart';
import { Typography, } from '@material-ui/core';
import { jsx } from '@emotion/core';

const styles = {
  container: {
    width: 150, height: 150, position: 'relative'
  },
  percent: {
    position: 'absolute',
    top: 0,
    left: 0,
    width: '100%' ,
    height: '100%',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
  },
  list: {
    listStyle: 'none',
    padding: 0,
    margin: 0,
    marginTop: 40,
  },
  label: {
    display: 'inline-block',
    width: 150,
  },
  icon: {
    width: 5,
    height: 5,
    marginLeft: 5,
    border: '2px solid #2CEB83',
    borderRadius: '50%',
    display: 'inline-block'
  }
};

export const StyledPieChart = ({ available, occupied, availableTitle, occupiedTitle, occupiedColor }) => {
  return (
    <div>
    <div css={styles.container}>
      <div css={styles.percent}>
        <Typography variant='h3'>{available}%</Typography>
      </div>
      <ReactMinimalPieChart
        animate={false}
        animationDuration={500}
        animationEasing="ease-out"
        cx={50}
        cy={50}
        data={[
          {
            color: '#2CEB83',
            title: 'available',
            value: available
          },
          {
            color: occupiedColor,
            title: 'occupied',
            value: 30
          },
        ]}
        label={false}
        labelPosition={50}
        lengthAngle={360}
        lineWidth={15}
        onClick={undefined}
        onMouseOut={undefined}
        onMouseOver={undefined}
        paddingAngle={0}
        radius={50}
        rounded
        startAngle={0}
        viewBoxSize={[
          100,
          100
        ]}
      />
    </div>
      <ul css={styles.list}>
        <li>
          <span css={styles.icon}/> <span css={styles.label}>{availableTitle}</span> {available}
        </li>
        <li>
          <span css={styles.icon} style={{ borderColor: occupiedColor }}/> <span css={styles.label}>{occupiedTitle}</span> {occupied}
        </li>
      </ul>
    </div>
  )
}
