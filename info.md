# Welcome to LedgEx!
## Background 
LedgEx is short for Ledger Explorer. A ledger is a document that summarizes financial transactions for a set of accounts (my own non-expert definition). Ledgers can contain large amounts of data and are generally not formatted for easy analysis. The LedgEx application is designed to create tidy versions of ledgers that can be downloaded from and analyzed on its web-based user interface. 

## Source data example 
The dataset chosen for the app is QuickBooks General Ledger Report from the January 2017 [Data mining your general ledger with Excel](http://www.journalofaccountancy.com/issues/2017/jan/general-ledger-data-mining.html) article by J. Carlton Collins, published in the Journal of Accountancy. 

## Source code
Source code is available in my DDPfinal repo on [GitHub](https://github.com/marskar/DDPfinal).

## Usage notes
### User controls
You can set minimum Credit and Debit values for the all charts and the date range for the pie charts using the sliders located on the left side (sidebar) of the user interface.
Hover over bars or slices of pies in each plots to see the individual values.
Use the tools in the upper right hand corner to customize the look of each graph; visit [Plotly](http://help.plot.ly/getting-to-know-the-plotly-modebar/) to find out more. 
### Plot tabs
The Plot tabs show either two bar charts or two pie charts in the main panel. The bar charts show Credit or Debit values above the respective minimum threshold set by the user. The pie charts show Credit or Debit  values above the threshold for an individual month selected by the user.
