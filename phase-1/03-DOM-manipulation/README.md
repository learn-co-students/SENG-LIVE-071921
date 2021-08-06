# Introduction to DOM Manipulation

## Goals:

- Identifying the DOM
- Focusing on key terminology/methods used in DOM manipulation
- Access, add, alter and remove DOM elements

  ### What is the DOM?

  - DOM stands for Document Object Model
  - When does the DOM get created? When HTML is being loaded from a server, the browser takes the HTML and converts it to the DOM
  - It is a programming interface of your HTML or XML that is created by the browser
  - Offers a web page as a tree of objects
  - We use JavaScript with the DOM to make cool things happen!
  - The DOM is a tree of nodes and each node has its own properties and methods
  - What is a node? Anything we can change in the document: element, Text, HTML attributes
  - These nodes also have relationships to one another
  - Element relationships can be really useful for traversing the DOM. This means accessing elements from other elements

  ### How to access elements

  ## Returning 1 element:

  - `document.getElementById()`
    - accepts id as an argument
    - returns first match
  - `document.querySelector()`
    - returns the first value that matches the provided selector.
    - This selector accepts tag names, class names and id’s

  ## Returning multiple element:

  - `document.getElementsByClassName()`
    - accepts class as an argument
    - returns an HTMLcollection
  - `document.getElementsByTagName()`
    - accepts tag name as an argument
    - returns an HTMLcollection
  - `document.querySelectorAll()`
    - returns a node list that matches the provided selector

  ### Traversing the DOM

  - If moving down the tree, we can use:
    - `.children`, `.querySelector`, `.querySelectorAll`
  - If moving up, we can use
    - `.parentElement` or `.closest`
  - We can also traverse sideways
    - `nextElementSibling`, `previousElementSibling`

  ### Adding/Altering Elements on the DOM

  - `document.createElement()`
  - `innerHTML`
  - difference between `+=` and `=`

  ### Modifying Element text

  - `.innerText`: Will only return human readable text
  - `.textContent`: Will return text as well as associated elements like span, style

  ### Removing elements from the DOM

  - `.remove()`

  ### Resources
- [SPA](https://developer.mozilla.org/en-US/docs/Glossary/SPA)
- [Introduction to the DOM](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)
- [DOM Manipulation](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Manipulating_documents)
- [innerText vs textContent](https://kellegous.com/j/2013/02/27/innertext-vs-textcontent/)
- [Using Selectors](https://developer.mozilla.org/en-US/docs/Web/API/Document_object_model/Locating_DOM_elements_using_selectors)