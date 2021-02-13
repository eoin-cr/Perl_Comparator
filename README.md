Assignment: Given a large amount of csv files with different layouts and unreliable totals, check if the totals for certain values in all files are correct and if they are not, print how
much they are off by

Completed: 26/10/18


This code takes all the csv files in a folder and enters into them one by one.  It then checks which column (separated by ; in this case, but you can change that in the code) a certain
word is in (in this case both "Duration" and "NbPage").  The totals in my csv files are given at the 2nd row, so the program stores these values.  It then goes to the next rows and
starts adding up the values of all the numbers under the given title.  Finally, at the end of the file it will print the information, such as how far off the intial given total was from 
the actual total, and also each one of the totals.  This code is best used in a corporate setting, where you are receiving a lot of information from clients and want to confirm that
the numbers they are giving you for the totals are accurate.
