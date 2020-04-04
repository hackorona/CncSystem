/** @jsx jsx */
import React from 'react';
import { Typography, Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper } from '@material-ui/core';
import { Add } from '@material-ui/icons';
import { jsx } from '@emotion/core'
import { StyledButton } from '../StyledButton';

const styles = {
  container: {
    height: '100%',
  },
  adminTitle: {
    marginBottom: '50px !important',
  },
  centerName: {
    marginBottom: '25px !important',
  },
  tableHead: {
    background: '#F5F6F8',
  },
  buttonContainer: {
    display: 'flex',
    justifyContent: 'center',
  },
  button: {
    marginBottom: '30px !important',
  }
};

export const Admin = ({ medicalCenters }) => {
  return (
    <div css={styles.container}>
      <Typography variant='h5' css={styles.adminTitle}>ניהול מרכזים רפואיים</Typography>
      <StyledButton css={styles.button}>
        <Add/>&nbsp;הוספת מרכז רפואי
      </StyledButton>
      <TableContainer component={Paper}>
        <Table aria-label="simple table">
          <TableHead css={styles.tableHead}>
            <TableRow>
              <TableCell>מספר זיהוי</TableCell>
              <TableCell align="left">שם המרכז הרפואי</TableCell>
              <TableCell align="left">סוג</TableCell>
              <TableCell align="left">כתובת</TableCell>
              <TableCell align="left">מחלקות</TableCell>
              <TableCell align="left">מיטות</TableCell>
              <TableCell align="left">מכונות הנשמה</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {medicalCenters.map((center) => (
              <TableRow key={center.id}>
                <TableCell component="th" scope="row">
                  {center.id}
                </TableCell>
                <TableCell align="left">{center.name}</TableCell>
                <TableCell align="left">{center.type}</TableCell>
                <TableCell align="left">{center.address}</TableCell>
                <TableCell align="left">{center.departments.length}</TableCell>
                <TableCell align="left">-</TableCell>
                <TableCell align="left">-</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    </div>
  )
};
