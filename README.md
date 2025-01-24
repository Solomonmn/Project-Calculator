# Project-Calculator
The Prefix Calculator is a Haskell-based command-line tool for evaluating mathematical expressions in prefix notation. It supports arithmetic operations, history referencing for results, and robust error handling for invalid input and operations like division by zero. The tool is interactive, user-friendly, and includes detailed setup and usage.

# Prefix Calculator - Readme

---

## **Usage**

### **Entering Expressions:**
- Use prefix notation with operators `+`, `*`, `/`, and `-` (for negation).
- Reference history with `$n` (e.g., `$1` for the first result).

### **Examples:**
1. **Simple Addition:**
    ```
    Enter an expression: + 3 4
    1: 7.0
    ```
2. **Using History:**
    ```
    Enter an expression: * $1 5
    2: 35.0
    ```
3. **Negation:**
    ```
    Enter an expression: - $2
    3: -35.0
    ```

---

## **Files Included**
- `PrefixCalculator.hs`: The Haskell source code containing the calculator implementation.
- `README.txt`: A text file explaining how to compile and run the project.
- `Writeup.pdf`: A document explaining the project approach, structure, and issues encountered.

---

## **Compiling the Project**
1. Install GHC.
2. Navigate to the directory containing `PrefixCalculator.hs`.
3. Run the following command:
    ```
    ghc --make PrefixCalculator.hs
    ```
4. Run the executable:
    ```
    ./PrefixCalculator
    ```
5. Or just run the `PrefixCalculator.hs` directly if Haskell is installed.

---

## **Additional Notes for the TA**
The program handles common errors such as:
- Invalid expressions.
- Division by zero.
- Invalid history references.

---

## **Exiting**
- Type `quit` and press Enter.

---

## **Notes**

### **History Management**
- Results are stored with IDs starting at 1.
- The most recent result is listed first.

### **Error Handling**
- The program shows `"Invalid Expression"` for errors like malformed input, division by zero, or invalid history references.

---

## **Contact**
- If you have any questions, please contact **som21aaron@gmail.com**.

---

**End of Readme**
