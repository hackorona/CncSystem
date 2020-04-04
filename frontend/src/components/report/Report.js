/** @jsx jsx */
import React from 'react';
import { Typography } from '@material-ui/core';
import { jsx } from '@emotion/core'
import { StyledButton } from '../StyledButton';

const styles = {
  department: {
    background: '#fff'
  }
};

export const Report = ({ medicalCenter, onReportSubmit }) => {
  const {
    id,
    name,
    departments
  } = medicalCenter;
  return (
    <div>
      <Typography>דוח יומי:</Typography>
      <Typography>
        {id}
        {name}
      </Typography>
      {
        departments.map(department => (
          <div css={styles.department} key={department.id}>
            {department.id} {department.name}
          </div>
        ))
      }
      <StyledButton onClick={onReportSubmit}>
        שליחת דוח
      </StyledButton>
    </div>
  )
};
