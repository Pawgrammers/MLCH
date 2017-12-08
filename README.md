# Shakespeare Script Editor (MLCH)

The Shakespeare Script Editor is a website made by team MLCH for CS121: Software Development in the Spring 2017 semester. The website allows users to choose a Shakespeare from a list or find one using a search bar, read the play, and cut words from the play. The script editor also analyzes each play, providing line numbers, a synopsis, and a navigation bar with the number of acts and scenes in the play.

## Architecture
This app is built using Ruby on Rails, Javascript, HTML, and CSS. 
The backend consists of a ruby script that parses all the XML scripts into HTML files and plays_controller which responds to HTTP requests from the browser and serves the scripts. The frontend is mainly Show.hmtl.erb which renders the HTML properly and stores all the Javascript functions that create the page functionality and interactivity of the script.

## Installation

Prerequisites: install Ruby/Rails and git on your machine

1. Clone the repo: `git clone https://github.com/hmc-cs-lnorgaard/MLCH.git`
2. cd into the script_editor folder
2. Install gems: Nokogiri, bootstrap,
    use the command `bundle install` in terminal to install gems
    
Gems

1.Nokogiri - this gem is used to parse XML files into HTML files.

## Usage

To run the website on localhost:

in terminal:

`cd Shakespeare-Script-Editor`

`cd script_editor`

`rails s`

in browser:

localhost:3000


## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

5/4/2017: Version 1.0
  
  Implemented Features:
    Homepage
    Search Bar
    Formatted Play Display
    Editing interface
    Internal Play Navigation
    Synopsis
    
12/8/2017: Version 2.0
  
  Implemented Features:
    Cutting text by highlighting and clicking speaker names
    Clear All Edits Button
    Play Analytics Modal
    Preprocessing XML scripts
    Saving Edited Scripts
    Toggle view with hidden and visible cut text
    
## Credits

Contributors version 1.0: Mahlet Melaku, Holly Mitchell, Lee Norgaard, Crystal Xiang
Contributors version 2.0: Jackson Crewe, Chloe Elliott, Blake Larkin, Montana Roberts

Clients: Prof. Benjamin Wiedermann, Prof. Ambereen Dadabhoy

CS121 Professor: Yekaterina Kharitonova

## License

See LICENSE.txt
