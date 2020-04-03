import React from 'react';
import { Provider } from 'mobx-react';

const WithMobx = (Comp, store) => {
  return class WithMobx extends React.Component {
    render () {
      return (
        <Provider store={store}>
          <Comp {...this.props} />
        </Provider>
      );
    }
  };
};

export default WithMobx;
