// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Row from 'react-bootstrap/lib/Row';
import Col from 'react-bootstrap/lib/Col';

import TopReferrer from './top-referrer.container';
import TopUrls from './top-urls.container';

import './style.scss';

const App = () => (
  <Row>
    <Col md={6}>
      <TopUrls />
    </Col>
    <Col md={6}>
      <TopReferrer />
    </Col>
  </Row>
);

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.getElementById("app"),
  )
})
