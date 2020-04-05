import React from 'react';
import ReactMinimalPieChart from 'react-minimal-pie-chart';
import { Typography, } from '@material-ui/core';
import { jsx } from '@emotion/core';

export const StyledPieChart = ({ available, occupiedColor }) => {
  return (
    <div style={{ width: 150, height: 150, position: 'relative' }}>
      <div style={{ position: 'absolute', top: 0, left: 0, width: '100%' , height: '100%', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
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
  )
}
