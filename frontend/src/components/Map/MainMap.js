import React from 'react';
import GoogleMapReact from 'google-map-react';
import { inject, Observer } from 'mobx-react';

const styles = {
  container: {
    height: '100%',
    width: '100%',
  },
};

const AnyReactComponent = ({ text }) => <div>{text}</div>;


const MainMapView = ({ locations }) => {
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

                    <AnyReactComponent
                      lat={59.955413}
                      lng={30.337844}
                      text="My Marker"
                    />


            </GoogleMapReact>
          </div>
        )
      }}

    </Observer>
  )
};

export const MainMap = inject('store')(MainMapView);

