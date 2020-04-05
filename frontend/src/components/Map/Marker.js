import React from 'react';
import { Paper, Typography } from '@material-ui/core';

const styles = {
  marker: {
    width: 50,
    height: 50,
    background: 'rgba(243,7,7,0.3)',
    borderRadius: '50%',
    cursor: 'pointer',
    position: 'relative',
  },
  markerInner: {
    padding: 5,
    position: 'absolute',
    top: -95,
    height: 80,
    width: 110,
    zIndex: 999,
    display: 'flex',
    flexDirection: 'column',
  },
};

export const Marker = ({ location }) => {
  const { name } = location;
  const [isOpen, setIsOpen] = React.useState(false);

  return (
    <div
      onClick={() => setIsOpen(!isOpen)}
      style={styles.marker}>
      {isOpen &&
        <Paper style={styles.markerInner}>
          <Typography variant="caption">{name}</Typography>
        </Paper>
      }
    </div>
  )
};
