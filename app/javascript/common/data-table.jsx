import React from 'react';
import PropTypes from 'prop-types';

import Table from 'react-bootstrap/lib/Table';
import Panel from 'react-bootstrap/lib/Panel';

const renderReferrers = ({ records = [] }) => {
  if (records.length === 0) {
    return null;
  }

  return (
    <tr key={`referrers-Date.now()`}>
      <td colSpan={3}>
        <DataTable date="Referrers" records={records} />
      </td>
    </tr>
  );
}

const DataTable = ({ date, records }) => {
  if (records.length === 0) {
    return null;
  }

  return (
    <Panel collapsible defaultExpanded header={date}>
      <Table responsive fill style={{marginBottom: 0}}>
        <thead>
          <tr>
            <th>#</th>
            <th>URL</th>
            <th>Visits</th>
          </tr>
        </thead>
        <tbody>
          {records.map((record, index) => (
            [
              <tr key={`${date}-${index}-${Date.now()}`}>
                <td>{index + 1}</td>
                <td>{record.url}</td>
                <td>{record.visits}</td>
              </tr>,
              renderReferrers({ records: record.referrers })
            ]
          ))}
        </tbody>
      </Table>
    </Panel>
  );
};

DataTable.propTypes = {
  date: PropTypes.string.isRequired,
  records: PropTypes.array,
};

DataTable.defaultProps = {
  records: [],
};

export default DataTable;
