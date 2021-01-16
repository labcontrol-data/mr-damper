# mr-damper

<p align="center"><a href="http://www.labcontrol.xyz/dokuwiki" target="_blank" rel="noopener"><img src="images/logo.png"></a></p>

# [Labcontrol, Brazil](http://www.labcontrol.xyz/dokuwiki)

[**Labcontrol**](http://www.labcontrol.xyz/dokuwiki) 
    Lab Control is a research laboratory located at Universidade Tecnológica Federal do Paraná (UTFPR), Brazil. UTFPR is a public Brazilian university located in the Paraná state, Brazil. Lab Control develops research on Control Systems and Automation.  The Scientific Director of Labcontrol is [Prof. Dr. Alessandro N. Vargas](http://www.anvargas.com). Most projects developed in the Labcontrol are [described here](http://www.anvargas.com/blog) 

About
============

This page provides information about the project developed in Labcontrol called "Shaking table with mr-damper". Experiments were carried out in practice in a laboratory testbed, and the data contained in this Github repo were collected in those experiments. 

[![DOI](https://zenodo.org/badge/330236633.svg)](https://zenodo.org/badge/latestdoi/330236633)

**Please check more details about this project [in the blog page](http://www.anvargas.com/blog)**


`maincode.m` is a MATLAB(R) script that calls Simulink-Matlab, generates simulation data, and generates figures. The figures contain both simulation and real-time data collected in a laboratory testbed.

For more details about the experimental data, as long as the corresponding academic publications, please visit the project page on [FileExchange](http://www.anvargas.com/blog).


Installation
============

1. Extract the ZIP file (or clone the git repository) in your computer.
2. Add the folders `matlab-code/` and `data/` to your path in MATLAB/Octave: e.g. 
    - using the "Set Path" dialog in MATLAB, or 
    - by running the `addpath` function from your command window or `startup` script.

Make sure that you are running Matlab 2017a (or a newer version). Older versions may work depending on the actual MATLAB(R) you are running.

Usage
=====

Typical usage of `maincode.m` consists of running your MATLAB. The code will generate ten figures.

MATLAB
------
  1. Run `maincode.m`, e.g. using

More information
================

* For more information about `maincode.m`, visit the page from the author [Prof. Alessandro N. Vargas at](http://www.anvargas.com). You are always welcome to help improving the code in `maincode.m`.
* If you want to use the data for your research, please feel free to contact the author [Prof. Alessandro N. Vargas at](http://www.anvargas.com). The author can help you to interpret the data according to your application, as well as suggesting you citations or books in which you can find more details about the project.
