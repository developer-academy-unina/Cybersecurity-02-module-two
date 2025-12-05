<div align="center">
  <h3>Workshop</h3>
  <h1>
      Cybersecurity 02 - Recognizing Vulnerabilities<br />
  </h1>
  <br />
</div>

<br />

<p align="center">
  <a href="#" alt="Version">
    <img src="https://img.shields.io/static/v1?label=Version&message=1.0.0&color=brightgreen" />
  </a>
  <a href="#" alt="XCode Version">
    <img src="https://img.shields.io/static/v1?label=XCode%20Version&message=26.0&color=brightgreen&logo=xcode" />
  </a>        
  <a href="#" alt="Swift Version">
    <img src="https://img.shields.io/static/v1?label=Swift%20Version&message=6.0&color=brightgreen&logo=swift" />
  </a>
  <a href="#" alt="Framework used">
    <img src="https://img.shields.io/static/v1?label=Framework%20used&message=SwiftUI&color=brightgreen&logo=swift">
  </a>          
</p>

---

## About

In this workshop, you will explore **common security vulnerabilities** by examining simplified, intentionally insecure demos.  
Each screen isolates a single concept, allowing you to understand how and why weaknesses arise in real-world applications.

The project highlights how insecure communication, poor dependency trust, weak authorization, and misuse of platform features can introduce critical risks.

## Learning Goals

In this workshop, you will:

- Understand core categories of mobile security vulnerabilities  
- Recognize the impact of insecure network communication  
- Explore biometric authentication concepts  
- Identify supply-chain risks in third-party libraries  
- Analyze trust boundaries and why client-side authorization fails  

## Screens Demonstrated

### 🔒 ATS Demo (App Transport Security)
- Shows how iOS blocks insecure HTTP traffic by default  
- Demonstrates risks associated with cleartext (HTTP) communication  
- Highlights platform-level security enforcement  

### 🧑‍💻 Face ID Demo
- Demonstrates biometric authentication using Face ID  
- Introduces secure, hardware-backed user verification  
- Shows how Local Authentication protects sensitive actions  

### 📦 Compromised Library (FancyText)
- Mock third-party library used to illustrate dependency trust issues  
- Demonstrates how compromised packages can impact application behavior  
- Explores supply-chain vulnerability concepts  

### ☀️ Weather Lookup
- Performs network requests to a remote weather API  
- Discusses protecting API keys and sensitive configuration data  
- Demonstrates safe communication patterns vs insecure ones  

### 🔓 Frontend-Only Authorization
- Exposes a broken security model where authorization exists only in the UI  
- Shows why client-side access control cannot be trusted  
- Introduces trust boundaries and the need for server-side enforcement  

## Getting Started

### Installation

To get access to the project created during the workshop, you can **download the repository as a zip file** and open it in Xcode.

<br />
