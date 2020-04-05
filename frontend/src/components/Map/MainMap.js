import React from 'react';
import GoogleMapReact from 'google-map-react';
import { inject, Observer } from 'mobx-react';
import { Marker } from './Marker';

const styles = {
  container: {
    height: '100%',
    width: '100%',
    overflow: 'hidden',
  },
};

const AnyReactComponent = ({ text }) => <div>{text}</div>;


export const MainMap = ({ locations }) => {
  const defaultProps = {
    center: {
      lat: 32.0853,
      lng: 34.7818
    },
    zoom: 9
  };

    const distanceToMouse = (pt, mousePos) => {
      if (pt && mousePos) {
        return Math.sqrt(
          (pt.x - mousePos.x) * (pt.x - mousePos.x) +
          (pt.y - mousePos.y) * (pt.y - mousePos.y)
        );
      }
    };

  return (
    <Observer>
      {() => {

        const list = locations;

        return (
          <div style={styles.container}>
            <GoogleMapReact
              bootstrapURLKeys={{ key: "AIzaSyDMr2XC0oWSFbjIYhQlr6sxLz7SmyGS-OA" }}
              defaultCenter={defaultProps.center}
              defaultZoom={defaultProps.zoom}
              distanceToMouse={distanceToMouse}
            >
              {
                list.map(location => {
                  return (
                    <Marker
                      key={location.id}
                      lat={location.coords.lat}
                      lng={location.coords.lng}
                      location={location}
                    />
                  )
                })
              }
            </GoogleMapReact>
          </div>
        )
      }}

    </Observer>
  )
};
