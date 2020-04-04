/** @jsx jsx */
import React from 'react';
import { TextField, Typography, FormGroup } from '@material-ui/core';
import { jsx } from '@emotion/core'
import { Box } from '../../Box';

const styles = {
  title: {
    background: '#F5F6F8',
    fontWeight: 600,
    padding: '15px 20px',
  },
  inner: {
    padding: '35px 0',
    minHeight: 200,
    display: 'flex',
    justifyContent: 'space-evenly'
  },
  columnTitle: {
    marginBottom: '18px !important',
    textDecoration: 'underline',
  },
  row: {
    marginBottom: 10,
    alignItems: 'center',
  },
  label: {
    width: 110,
  },
  input: {
    width: 115,
    'input': {
      textAlign: 'center',
    }
  }
};

const PATIENT_STATUS_LABELS = {
  stable: 'מצב קל',
  serious: 'מצב בינוני',
  critical: 'מצב קשה',
};
const BED_LABELS = {
  all: 'סה״כ מיטות',
  used: 'מיטות בשימוש',
};
const VENTILATOR_LABELS = {
  all: 'סה״כ מכונות',
  used: 'מכונוות בשימוש',
};

export const Department = ({ department }) => {
  const {
    id,
    name,
    patients,
    beds,
    ventilators,
  } = department;

  const displayData = [{
    title: 'סה״כ מאושפזים',
    data: patients,
    labels: PATIENT_STATUS_LABELS
  },{
    title: 'מיטות אשפוז',
    data: beds,
    labels: BED_LABELS
  }, {
    title: 'מכונות הנשמה',
    data: ventilators,
    labels: VENTILATOR_LABELS,
  }];

  const titleStart = 'מחלקה מספר';

  return (
    <Box title={`${titleStart} ${id} - ${name}`}>
      <div css={styles.inner}>
        {
          displayData.map(column => {
            return (
              <div css={styles.column}>
                <Typography variant='subtitle1' css={styles.columnTitle}>
                  {column.title}
                </Typography>
                {
                  Object.keys(column.data).map(portion =>
                    <FormGroup row css={styles.row}>
                      <Typography css={styles.label}>
                        {column.labels[portion]}
                      </Typography>
                      <TextField
                        type="number"
                        variant='outlined'
                        size='small'
                        disabled={portion === 'all'}
                        css={styles.input}
                        defaultValue={column.data[portion]}/>
                    </FormGroup>
                  )
                }
              </div>
            )
          })
        }
      </div>
    </Box>
  )
};
