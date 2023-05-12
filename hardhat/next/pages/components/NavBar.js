import React from "react";
import Link from "next/link";

const Navbar = () => {
  return (
    <nav className="flex items-center justify-between flex-wrap bg-blue-900 p-6">
      <div className="flex items-center flex-shrink-0 text-white mr-6">
      <img width={100} height={100} src="./vote-nav.svg" />
        <a className="text-white font-bold text-xl" href="/">
          Rock The Vote
        </a>
      </div>
      <div className="w-full block flex-grow lg:flex lg:items-center lg:w-auto">
        <div className="text-sm lg:flex-grow">
          <Link href="/" className="block mt-4 lg:inline-block lg:mt-0 text-white hover:text-gray-400 mr-4">
              Home
            
          </Link>
          <Link href="/about" className="block mt-4 lg:inline-block lg:mt-0 text-white hover:text-gray-400 mr-4">
              About

          </Link>
          <Link href="/contact" className="block mt-4 lg:inline-block lg:mt-0 text-white hover:text-gray-400">
              Contact

          </Link>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;

