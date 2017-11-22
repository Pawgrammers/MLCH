# Shakespeare Script Editor (MLCH)

The Shakespeare Script Editor is a website originally created by team MLCH for CS121: Software Development in the Spring 2017 semester and extended by team Pawgrammers for CS121 in Fall 2017. The website allows users to choose a Shakespeare Play from a list or find one using a search bar, read and abridge it, and print it in several formats. The script editor also analyzes each play, providing line numbers, a synopsis, and a navigation bar with the links to the acts and scenes in the play.

## Installation

Prerequisites: install Ruby/Rails and git on your machine

1. Clone the repo: `git clone https://github.com/Pawgrammers/Shakespeare-Script-Editor.git`
2. cd into the script_editor folder
2. Install gems: Nokogiri, bootstrap,
    use the command `bundle install` in terminal to install gems
3. Run the command `ruby create_scripts.rb all` to process all the plays from XML into a browser-viewable HTML format
4. Run the app: use the command `rails s` in terminal, then navigate to
    localhost:3000 in your prefered browser

## Usage

To run the website on localhost:

in terminal:

`cd Shakespeare-Script-Editor`

`cd script_editor`

`ruby create_scripts.rb all`

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
    
12/10/17: Version 2.0

  Implemented Features:
    Cutting text
    Concise and Full Views
    Cutting speeches
    Saving plays and edits
    Preprocessing XML
    Analytics
    Printing
    
## Credits

Version 1 Contributors: Mahlet Melaku, Holly Mitchell, Lee Norgaard, Crystal Xiang
Version 2 Contributors: Jackson Crewe, Chloe Elliott, Blake Larkin, Montana Roberts

Client Version 1: Prof. Benjamin Wiedermann
Client Version 2: Prof. Ambereen Dadabhoy

CS121 Professor: Yekaterina Kharitonova

## License

See LICENSE.txt
