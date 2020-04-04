/** @jsx jsx */
import React from 'react';
import { Typography } from '@material-ui/core';
import { jsx } from '@emotion/core'
import { StyledButton } from '../StyledButton';
import { Department } from '../department/Department';

const styles = {
  container: {
    height: '100%',
  },
  buttonContainer: {
    display: 'flex',
    justifyContent: 'center',
  },
  button: {
    width: 360,
  }
};

export const Report = ({ medicalCenter, onReportSubmit }) => {
  const {
    id,
    name,
    departments
  } = medicalCenter;
  return (
    <div css={styles.container}>
      <Typography>דוח יומי:</Typography>
      <Typography>
        {id}
        {name}
      </Typography>
      {
        departments.map(department => (
          <Department key={department.id} department={department}/>
        ))
      }
      <div css={styles.buttonContainer}>
        <StyledButton onClick={onReportSubmit} css={styles.button}>
          שליחת דוח
        </StyledButton>
      </div>
    </div>
  )
};
