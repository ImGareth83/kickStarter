import React from 'react';
import { Container } from 'semantic-ui-react';
import Header from './Header';
import Head from 'next/head';

const Layout=(props)=>{
  return(
    <Container>
      <head>
        <link async rel="stylesheet" href="//cdn.jsdelivr.net/npm/semantic-ui@2.4.1/dist/semantic.min.css"/>
        <script async src="//cdn.jsdelivr.net/npm/semantic-ui@2.4.1/dist/semantic.min.js"></script>
      </head>
      <Header/>
      {props.children}
    </Container>
  );
};

export default Layout;
