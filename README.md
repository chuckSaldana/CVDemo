The project is structured in the following form:

### Arquitectural design
- Used MVVM to prevent View Controller from having to much responsabilities.
- A launcher object will download, parse and store data at application launch.
- Use of Core Data as object mapping tool and storage via SQLite.
- Code for Networking, Parsing, DB, Views, Controllers, Categories, etc. is separated into folders.
- A sample of Unit Testing for the Parsing functionality is included.

### How to run the code
- Install Xcode 10.1 with swift 4.2
- Run the code

### Notes on Unit Testing
- Decided to use a local JSON file to have fast and reproducible tests.
- Core Data is also mocked by a specific object to allow test isolation.
- No UI tests where added since the developer is proficient with an external tool.

