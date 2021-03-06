#!/bin/bash


##============================================================================== 
# File:         michiganrun.sh 
# Date: 		Mon Jan  2 14:11:53 EST 2017
# Author(s):    Thalita Coleman  <thalitaneu@gmail.com>
# Abstract: Executes programs michigan.py and parsemichigan.py. 
#       Parses the files michigan.html -- which contains the HTML source for
#       the page http://www.michigan.gov/mdhhs/0,5885,7-339-71550_2955_22779_40563-143382--,00.html,
#       and returns the URL of all weekly flu reports. Downloads the flu reports 
#       in .pdf format and transforms into .txt.  
#       Scrapes the .txt files and returns a CSV file named michiganresults.csv 
#       with "Week", "Week Ending", "State", "Season", "Total", "Lab", "Visits", and 
#       "Hospitalizations" data for each week. When the data is not available in the report, 
#       it returns N/A value. When the program was not able to parse the data, it returns a 
#       "could not retrieve" message. The "could not retrieve" values can then be collected manually.        
#------------------------------------------------------------------------------ 
# Requirements: Python 2.7 
#------------------------------------------------------------------------------ 
# Notes: 
#==============================================================================

# defines output file 
CSV="michiganresults.csv"

# removes previous newmexicoresults.csv files, if any
rm -i $CSV

# writes header
echo '"Week", "Week Ending", "State", "Season", "Total", "Lab", "Visits", "Hospitalizations"' >> $CSV

# downloads .csv files
./michigan.py

# transforms files into .txt, parse files and creates delawareresults.csv file with the data
for file in *.pdf
do
	echo "parsing file $file..."
	textfile=`echo "$file" | sed 's/.pdf/.txt/'`
	pdf2txt.py -t text -o "$textfile" "$file"
	./parsemichigan.py "$textfile" >> $CSV
done


		





















