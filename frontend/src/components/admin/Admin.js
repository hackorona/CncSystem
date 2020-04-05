/** @jsx jsx */
import React from 'react';
import { Typography, Table, TableBody, TableCell, TextField, TableContainer, TableHead, TableRow, Chip, Paper, Dialog, DialogContent, FormGroup, Select, MenuItem } from '@material-ui/core';
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
  row: {
    display: 'flex',
    marginBottom: 20,
    alignItems: 'center',
  },
  dialog: {
    '.MuiDialog-paper': {
      minWidth: '50%',
      padding: 80,
      paddingBottom: 20,
      boxSizing: 'border-box',
    }
  },
  input: {
    flexGrow: 1,
  },
  label: {
    width: 110,
  },
  select: {
    width: 256,
  },
  buttonContainer: {
    marginTop: 80,
    display: 'flex',
    justifyContent: 'center',
  },
  button: {
    marginBottom: '30px !important',
  },
  dialogButton: {
    marginBottom: 0,
  },
  modalTitle: {
    textAlign: 'center',
    marginBottom: '50px !important',
  }
};

const centerTypesLabels = {
  hospital: 'בית חולים',
  hotel: 'מלון קורונה'
};

export const Admin = ({ medicalCenters }) => {
  const [open, setOpen] = React.useState(false);

  return (
    <div css={styles.container}>
      <Typography variant='h5' css={styles.adminTitle}>ניהול מרכזים רפואיים</Typography>
      <StyledButton css={styles.button} onClick={() => setOpen(true)}>
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
                <TableCell align="left">
                  <Chip label={centerTypesLabels[center.type]}/>
                </TableCell>
                <TableCell align="left">{center.address}</TableCell>
                <TableCell align="left">{center.departments.length}</TableCell>
                <TableCell align="left">-</TableCell>
                <TableCell align="left">-</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
      <Dialog open={open} onClose={() => setOpen(false)} css={styles.dialog}>
        <DialogContent>
          <Typography variant='h5' css={styles.modalTitle}>
            הוספת מרכז רפואי
          </Typography>
          <FormGroup row css={styles.row}>
            <Typography css={styles.label}>שם המרכז</Typography>
            <TextField
              autoFocus
              id="name"
              css={styles.input}
            />
          </FormGroup>
          <FormGroup row css={styles.row}>
            <Typography css={styles.label}>כתובת</Typography>
            <TextField
              autoFocus
              id="name"
              css={styles.input}
            />
          </FormGroup>
          <FormGroup row css={styles.row}>
            <Typography css={styles.label}>סוג המרכז</Typography>
            <Select variant='outlined' defaultValue={1} css={styles.select}>
              <MenuItem value={1}>בית חולים</MenuItem>
              <MenuItem value={2}>מלון קורונה</MenuItem>
            </Select>
          </FormGroup>
          <div css={styles.buttonContainer}>
            <StyledButton css={styles.dialogButton}>
              הוספה
            </StyledButton>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  )
};
