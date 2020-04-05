import React, { useRef } from 'react';
import usePlacesAutocomplete, { getGeocode, getLatLng } from 'use-places-autocomplete';
import useOnclickOutside from 'react-cool-onclickoutside';
import { TextField, MenuItem } from '@material-ui/core';
import { jsx } from '@emotion/core';

export const PlacesAutocomplete = ({ onSelect }) => {
  const {
    ready,
    value,
    suggestions: { status, data },
    setValue,
    clearSuggestions
  } = usePlacesAutocomplete({
    requestOptions: {},
    debounce: 300
  });
  const ref = useRef();
  useOnclickOutside(ref, () => {
    clearSuggestions();
  });

  const handleInput = e => {
    setValue(e.target.value);
  };

  const handleSelect = ({ description }) => () => {
    setValue(description, false);
    clearSuggestions();

    getGeocode({ address: description })
      .then(results => getLatLng(results[0]))
      .then(({ lat, lng }) => {
        onSelect({ lat, lng, name: description })
      }).catch(error => {
      console.log(' Error: ', error)
    });
  };

  const renderSuggestions = () =>
    data.map(suggestion => {
      const {
        id,
        structured_formatting: { main_text, secondary_text }
      } = suggestion;

      return (
        <MenuItem
          key={id}
          onClick={handleSelect(suggestion)}
        >
          <strong>{main_text}</strong>&nbsp;<small>{secondary_text}</small>
        </MenuItem>
      );
    });

  return (
    <div ref={ref} style={{ flexGrow: 1 }}>
      <TextField
        value={value}
        onChange={handleInput}
        disabled={!ready}
        variant='outlined'
        size='small'
        fullWidth
      />
      {status === 'OK' &&
        <ul style={{ margin: 0, padding: 0, width: '100%', maxWidth: 500, background: '#fff', border: '1px solid #B0B4B3', position: 'absolute', zIndex: 999 }}>
          {renderSuggestions()}
        </ul>
      }
    </div>
  );
};
