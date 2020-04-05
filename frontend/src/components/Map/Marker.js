import React from 'react';
import { Paper, Typography } from '@material-ui/core';
import starOfDavid from './../../images/start_of_david.svg';

const styles = {
  marker: {
    width: 20,
    height: 20,
    background: '#fff',
    borderRadius: '50%',
    cursor: 'pointer',
    position: 'relative',
    boxShadow: '0px 0px 5px rgba(0, 0, 0, 0.3)',
  },
  markerInner: {
    padding: 5,
    position: 'absolute',
    top: -2,
    right: 25,
    zIndex: 999,
    boxShadow: '0px 0px 6px rgba(0, 0, 0, 0.26)',
  },
};

export const Marker = ({ location }) => {
  const { name } = location;
  const [isOpen, setIsOpen] = React.useState(false);

  return (
    <div
      onClick={() => setIsOpen(!isOpen)}
      style={styles.marker}>
      <img src={starOfDavid} style={{ marginLeft: 3, marginTop: 3, }}/>
      {isOpen &&
        <Paper style={styles.markerInner}>
          <Typography variant="caption" style={{ whiteSpace: 'nowrap' }}>{name}</Typography>
        </Paper>
      }
    </div>
  )
};
