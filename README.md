# Demo

![Simulator Screen Recording - iPhone 15 Pro - 2024-08-03 at 02 36 09](https://github.com/user-attachments/assets/fb9fabd7-0be8-48ff-8106-e51d63484ca3)

# Requirements:
### Functional
  - Fetching and parsing data from API.
  - Listing Data.
  - Navigation to Details view.
  - Search
    
### Non-Functional:
- Scalability:
  - Modularity.
- Performance:
  - Adding debounce to avoid misusing the search APIs.
 
# Diagrams
 - High-Level Diagram
   ![High-Level Diagram](https://github.com/user-attachments/assets/9056c4e0-25a6-48b5-8cce-3986c665d519)

    
- Low-Level Diagram - MVVM with clean architecture
  ![MVVM](https://github.com/user-attachments/assets/e3aa535c-68d8-42d5-b66e-e8b982671a26)



# Decisions

- IDE & Deployment target:
  - XCode 15.3
  - Deployment target: 17.2
    
- UI:
  - UIKit - Programmatic UI
  - MVVM with Clean Architecture (UseCase & Router)

- Principals and Patterns:
  - SOLID conformance:
    - Features are separated into modules.
    - Factory pattern to create each module.
    - Repository for formatting backend data.
    - Shared Repository to manage communication among modules.
    - UseCases for business logic.
    - Router for navigation

- Dependency Manager:
  - Swift Package Manager

- Dependencies:
  
  [Kingfisher](https://github.com/onevcat/Kingfisher): Downloading and caching images from the web.

# Important notes
1. Communication among modules is being done using SharedRepository which is being implemented using singleton.
2. Caching is not implemented inside the code cause of the time interval for the task.
3. All print statements are being wrapped inside `#if DEBUG` to avoid having it printed in production, it's done one time inside an extension.
4. The errors are being printed just for now, Suppose to handle them in functions and dedicated views for each.
5. I didn't focus on the design as was mentioned to be able to finish ASAP.
   
# What could be improved
- Creating caching layer to cache the data.
- Adding pagination for better performance.
- Adding Loading for better UX.
- Be more secure and include the API keys in keychain ot external tool.
- Implement the needed UI formatting in the viewModel not in the View.
- Seperated branch for each feature.
- Unit testing.
- Caching images.
- CI/CD
