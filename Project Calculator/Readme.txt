
---

**Usage:**

- **Entering Expressions:**
- Use prefix notation with operators `+`, `*`, `/`, and `-` (for negation).
- Reference history with `$n` (e.g., `$1` for the first result).
- **Examples:**
- Simple Addition:
 Enter an expression: + 3 4
 1: 7.0
- Using History:
 Enter an expression: * $1 5
 2: 35.0
- Negation:
 Enter an expression: - $2
 3: -35.0

- **Files Included:**
- PrefixCalculator.hs the Haskell source code containing the calculator implementation
- README.txt: A text file explaining how to compile and run the project
- Writeup.pdf: A document explaining the project approach, structure, and issues encountered

- **Compiling the Project:**
- Install GHC
- Navigate to the directory containing PrefixCalculator.hs
- Run this command
    ghc --make PrefixCalculator.hs
- Run the executable
    ./PrefixCalculator
- Or just run the PrefixCalculator.hs with Haskell installed

- **Additional Notes for the TA:**
- The program handles common errors such as
    - Invalid expressions
    - Division by zero
    - Invalid history references


- **Exiting:**
- Type `quit` and press Enter.

**Notes:**
- **History Management:**
- Results are stored with IDs starting at 1.
- Most recent result is first in the list.
- **Error Handling:**
- The program shows `"Invalid Expression"` for anything such as  errors like malformed input, division by zero, or invalid history references.

---

**Contact:**
- If you have any questions, please contact sxg210254@utdallas.edu

---

**End of Readme**
