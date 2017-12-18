import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Loader from 'react-loader';
import Axios from 'axios';
import _get from 'lodash/get';

import DataTable from './common/data-table';

class TopReferrer extends Component {
  constructor(props) {
    super(props);

    this.state = {
      data: {
        loading: true,
        loaded: false,
        topReferrers: {},
      },
    };
  }

  render() {
    const { data } = this.state;
    const loaded = _get(data, 'loaded');
    const topReferrers = _get(data, 'topReferrers');

    return (
      <div>
        <h2>Top Referrers</h2>
        <Loader loaded={loaded}>
          {Object.keys(topReferrers).map((date) => (
            <DataTable key={`top-referrers-${date}`} date={date} records={topReferrers[date]} />
          ))}
        </Loader>
      </div>
    );
  }

  topReferrers = () => {
    Axios.get('/top_referrers.json').then(({ data }) => {
      this.setState({
        data: {
          loading: false,
          loaded: true,
          topReferrers: data,
        }
      });
    })
  }

  componentDidMount() {
    this.topReferrers()
  }
}

export default TopReferrer;
