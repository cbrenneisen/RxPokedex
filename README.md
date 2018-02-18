
# RxPokedex

Originally begun as a simple experimentation of RxDataSources, this project has evolved into showcasing what a project built with VIPER, RxSwift, and various Rx community libraries, would look like. 


## Functionality 

The first screen shown is a collection view that will show various Pokemon. These Pokemon are all fetched using the public  <a href="https://pokeapi.co">Pokemon API</a>. At first, 20 Pokemon will be fetched, followed by a fetch for each individual pokemon to get additional information such as images. Every 15 seconds or so, another network request will be made in order to retrieve a new set of Pokemon. While the current set of Pokemon is in play, they will randomly animate across the screen. The user can tap on any Pokemon in order to catch it. 

The second screen is a table view that contains all of the captured Pokemon, sorted alphabetically. Every time a Pokemon is captured from the main screen, a corresponding record is saved to the Realm database. 


## Architecture

(Coming Soon) 
