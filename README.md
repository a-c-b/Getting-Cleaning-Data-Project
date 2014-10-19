Getting-Cleaning-Data-Project
=============================

This is the project for the coursera course Getting and Cleaning Data.

The script run_analysis.R begins with deleting any previous data sets in
your working directory which would be equal to what the unzipped directory
structure of the down load data would be.

It then downloads the data from the source.  This data is a binary file,
so the download takes that into account, otherwise the unzip would not work.

Libraries which need to be loaded:
dplyr

