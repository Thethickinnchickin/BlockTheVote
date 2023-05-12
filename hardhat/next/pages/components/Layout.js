import React from "react";
import Navbar from "./NavBar";

const Layout = ({ children }) => {
  return (
    <>

        <Navbar />
        {children}


    </>
  );
};

export default Layout;
