# DOCScan

<img src="assets/icon-docscan-transparent-bg.png" style="width: 350px">


DOCScan is a mobile application designed for quick and efficient document scanning. It eliminates the need for traditional scanning devices and manual text conversion, allowing users to scan documents using their mobile phones. This application is ideal for students, teachers, professionals, and anyone who needs to manage documents frequently.

# Table of Contents
1. [**_Motivation_**](#motivation)
2. [**_Project Structure_**](#project-structure)
3. [**_Development Resources_**](#development-resources)
4. [**_Application Architecture_**](#archite)
5. [**_Technical Implementation_**](#technical-implementation)
   - [_Application Creation_](#application-creation) 
   - [_Application Walkthrough_](#application-walkthrough)
6. [**_Login/Authentication System_**](#loginauthentication-system)
   - [_System Architecture_](#system-architecture)
   - [_Firebase Integration_](#firebase-integration)
7. [**_Document Scanning System_**](#document-scanning-system)
   - [_Image to Digital Conversion_](#image-to-digital-conversion)
   - [_Applying Filters_](#applying-filters)
8. [**_Text Extraction System_**](#text-extraction-system)
   - [_Text Processing_](#text-processing)
   - [_Post-Processing and Display_](#post-processing-and-display)
8. [**_Bibliography_**](#bibliography)
   
# Motivation
The idea behind DOCScan stemmed from the need for a mobile application that allows rapid document scanning and dynamic digital interaction with these documents. DOCScan aims to enhance productivity by automating text extraction and facilitating efficient digital document management.

### _Benefits of DOCScan_
1. **Efficiency** – Increases productivity by automating text extraction and organizing digital documents.
2. **Accessibility** – Allows quick access to information and fast searches within scanned documents.
3. **Sustainability** – Reduces dependency on physical documents, contributing to environmental conservation.

DOCScan is developed exclusively for iOS, requiring iOS version 17.0.0 or higher.

# Project Structure
DOCScan consists of the following fundamental components:

1. User Login/Authentication System
2. Document Scanning System
3. Text Detection and Extraction System

4. Each component was developed separately and then integrated into the application.

# Development Resources
The entire application was developed using Xcode, Apple's primary IDE for software development on Apple devices. Xcode provides a complete set of tools for writing code, designing the application interface, debugging, testing, and delivering the application to the App Store.

This project uses Git and GitHub for version control and code management. All media resources of this project are created by Tania Tomici, including logos and icons. 

# Application Architecture
The project is built using an OOP structure, with separate classes and elements for each application screen. Each class receives and renders various information, ensuring ease of navigation and error resolution within the code.

# Technical Implementation
### _Application Creation_
DOCScan is developed using Swift and the SwiftUI framework. Swift is an object-oriented programming language known for its performance, simplicity, safety, and interoperability with Objective-C. SwiftUI is a visual framework that simplifies the creation of intuitive and interactive graphical interfaces.

### _Application Walkthrough_
1. Welcome Screen – Users can learn about the application and choose to log in or create an account.
2. Login/Sign Up – Users can log in with an existing account or sign up to create a new account.
3. Scanning Documents – Users can scan documents by positioning their phone over the document. The application automatically detects the document area and captures the image.
4. Editing Scans – Users can edit scans by cropping, applying filters, or rotating the image. After editing, the scan is saved, and the detected text is displayed.

# Login/Authentication System
### _System Architecture_
The authentication system saves user details (full name, email, and password) in the database for login purposes. Each user's scans and detected texts are also stored in the cloud.

### _Firebase Integration_
DOCScan uses Firebase for backend infrastructure, providing NoSQL databases, user authentication, cloud storage, and security features. Firebase Auth handles user authentication, while Firestore manages the database.

# Document Scanning System
### _Image to Digital Conversion_
DOCScan converts scanned images to digital format, allowing users to work with the text extracted from the documents.

### _Applying Filters_
Users can apply various filters to the scanned documents to enhance the quality and readability of the text.

# Text Extraction System
### _Text Processing_
DOCScan uses Natural Language Processing (NLP) to process and extract text from the scanned documents.

### _Post-Processing and Display_
The extracted text is displayed in the application, allowing users to copy and use it as needed. The scans and texts are stored in the cloud for easy access from any device.

# Bibliography
- https://www.youtube.com/watch?v=QJHmhLGv-_0
- https://developer.apple.com/
- https://github.com/
- https://developer.apple.com/sf-symbols/
- https://firebase.google.com/docs
- https://developer.apple.com/documentation/vision/recognizing_text_in_images
- https://gemini.google.com/
- https://www.pngwing.com/