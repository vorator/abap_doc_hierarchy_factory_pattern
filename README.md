# SAP ABAP RAP: Hierarchy with Factory Pattern (SOLID Principles)

An advanced SAP S/4HANA backend implementation showcasing the integration of Object-Oriented Programming (OOP) design patterns within the ABAP RESTful Application Programming Model (RAP). This project demonstrates how to decouple complex business validation logic from the transactional RAP behavior class using the **Strategy** and **Factory** patterns.

## 🎯 Business Use Case
In financial Record-to-Report (R2R) processes, different document types require strictly different validation rules upon saving:
* **Standard Invoices (C):** Must have a strictly positive amount.
* **Credit Notes (D):** Must have a strictly negative amount to properly reflect balance deductions.
* **Future Documents:** Down-payments, proformas, or customs invoices will require their own specific validations.

Hardcoding these rules with nested `IF` or `CASE` statements inside the RAP Behavior Implementation creates monolithic, unmaintainable code. This project solves that by isolating business rules.

## 🏗️ Technical Architecture (SOLID Patterns)
This solution adheres to the **Open-Closed Principle (OCP)**. The core RAP transactional behavior is closed for modification, but the validation logic is open for extension.

1. **The Contract (Interface):** `ZIF_R2R_DOC_VALIDATOR` defines a single, generic `validate_document` method.
2. **The Base / Template (Abstract Class):** `ZCL_R2R_DOC_BASE` implements common baseline validations (e.g., non-empty Vendor ID, non-zero amounts) and delegates specific rules to child classes via an abstract method.
3. **The Strategies (Concrete Classes):** `ZCL_OOP_VAL_INVOICE` and `ZCL_OOP_VAL_CREDIT` contain only the specific mathematical assertions for their respective document types.
4. **The Brain (Factory Class):** `ZCL_OOP_DOC_FACTORY` evaluates the transactional `DcIndicator` ('C' or 'D') and dynamically instantiates the correct strategy class, returning it as a polymorphic interface reference.
5. **Fail-Fast Exception Handling:** Unrecognized document types trigger a custom business exception (`ZCX_OOP_DOC_EXCEPTION`), ensuring the system never defaults to incorrect validation paths.

## 🛠️ Key Features Implemented
* **Clean RAP Integration:** The behavior implementation (`lhc_Invoice->validateOORules`) contains under 20 lines of code. It acts merely as an orchestrator, catching the current buffer data, calling the Factory, and mapping interface errors to the standard RAP `%msg` structure.
* **Polymorphism in Action:** The transactional engine does not know whether it is validating an invoice or a credit note; it simply calls the interface contract.
* **ABAP Cloud / Clean Core Ready:** Strict syntax (`strict ( 2 )`), entirely separated from classic SAP GUI dependencies.

## 🧪 Test-Driven Development (ABAP Unit)
By decoupling the validation logic from the RAP transactional buffer, the business rules become 100% unit-testable. The project includes local ABAP Unit test classes (`ltcl_factory_test`) that mock in-memory structures to automatically assert:
* Positive amounts on standard Invoices (C) pass validation.
* Negative amounts on Invoices (C) are strictly rejected.
* Positive amounts on Credit Notes (D) are strictly rejected.
* The Factory successfully raises `ZCX_OOP_DOC_EXCEPTION` when encountering an unsupported document indicator.

## 👨‍💻 About the Developer
I am an IT Engineer and Software Developer specializing in SAP ABAP, S/4HANA architecture, and Java. 
With a robust background integrating cross-border financial systems and ERPs (SAP, Navision, SAGE), I build resilient technical solutions grounded in deep business process understanding.
[🔗 Connect with me on LinkedIn](https://linkedin.com/in/luispinto82/) | 💻 **GitHub:** [@vorator](https://github.com/vorator)
