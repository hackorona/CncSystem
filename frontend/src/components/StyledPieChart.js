import React from 'react';
import ReactMinimalPieChart from 'react-minimal-pie-chart';
import { jsx } from '@emotion/core';

export const StyledPieChart = () => {
  return (
    <div style={{ width: 150, height: 150 }}>
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
            value: 60
          },
          {
            color: '#C13C37',
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
