
import * as React from "react";
import { 
    Show,
    SimpleShowLayout,
    TextField,
    NumberField
  } from 'react-admin';


const  DrugSpecificationShow = props => (
    <Show {...props}>
      <SimpleShowLayout>
        <NumberField source="id" label="id" />
        <TextField source="atc" label="ATC" />
        <TextField source="name" label="Dummy Name" />
        <TextField source="description" label="Description" />
      </SimpleShowLayout>
    </Show>
  );

export default DrugSpecificationShow;