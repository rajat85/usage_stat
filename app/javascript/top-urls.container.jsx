import React, { Component } from 'react'
import PropTypes from 'prop-types'
import Loader from 'react-loader';
import Axios from 'axios';
import _get from 'lodash/get';

import DataTable from './common/data-table';

class TopUrls extends Component {
  constructor(props) {
    super(props);

    this.state = {
      data: {
        loading: true,
        loaded: false,
        topUrls: {},
      },
    };
  }

  render() {
    const { data } = this.state;
    const loaded = _get(data, 'loaded');
    const topUrls = _get(data, 'topUrls');

    return (
      <div>
        <h2>Top Urls</h2>
        <Loader loaded={loaded}>
          {Object.keys(topUrls).map((date) => (
            <DataTable key={`top-urls-${date}`} date={date} records={topUrls[date]} />
          ))}
        </Loader>
      </div>
    );
  }

  topUrls = () => {
    Axios.get('/top_urls.json').then(({ data }) => {
      this.setState({
        data: {
          loading: false,
          loaded: true,
          topUrls: data,
        }
      });
    })
  }

  componentDidMount() {
    this.topUrls()
  }
}

export default TopUrls;
