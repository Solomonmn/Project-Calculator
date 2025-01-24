-- PrefixCalculator.hs
-- A Prefix-Notation Expression Calculator with History in Haskell

import Data.Char (isDigit, isSpace, toLower)
import Text.Read (readMaybe)
import Control.Monad (when)
import System.IO (hFlush, stdout)
import System.Exit (exitSuccess)

-- Define the data type
data Expr
    = Val Double
    | Add Expr Expr
    | Mul Expr Expr
    | Div Expr Expr
    | Neg Expr
    | HistRef Int
    deriving (Show)

-- Main function to start the calculator
main :: IO ()
main = evalLoop []

-- loop function
evalLoop :: [Double] -> IO ()
evalLoop history = do
    putStr "Enter an expression: "
    hFlush stdout  
    input <- getLine
    let trimmedInput = toLowerTrim input
    if trimmedInput == "quit"
        then exitSuccess  
        else do
            case tokenize trimmedInput of
                Left _ -> putStrLn "Invalid Expression" >> evalLoop history
                Right tokens -> 
                    case parseExpr tokens of
                        Left _ -> putStrLn "Invalid Expression" >> evalLoop history
                        Right (expr, remaining) ->
                            if not (null remaining)
                                then putStrLn "Invalid Expression" >> evalLoop history
                                else case evalExpr expr history of
                                    Left _ -> putStrLn "Invalid Expression" >> evalLoop history
                                    Right result -> do
                                        let newHistory = result : history
                                            id = length newHistory
                                        putStrLn $ show id ++ ": " ++ show result
                                        evalLoop newHistory

-- Function which will be used to trim whitespace and convert to lowercase
toLowerTrim :: String -> String
toLowerTrim = map toLower . trim
    where 
        trim = f . f
            where f = reverse . dropWhile isSpace

-- Tokenizer which works by Converts input string into list of tokens
tokenize :: String -> Either String [String]
tokenize [] = Right []
tokenize (c:cs)
    | isSpace c = tokenize cs
    | c `elem` "+-*/" = do
        rest <- tokenize cs
        return ([ [c] ] ++ rest)
    | c == '$' = do
        let (digits, rest) = span isDigit cs
        if null digits
            then Left "Invalid history reference"
            else do
                restTokens <- tokenize rest
                return (["$" ++ digits] ++ restTokens)
    | isDigit c || c == '.' || (c == '-' && isNextDigit cs) = do
        let (num, rest) = span (\x -> isDigit x || x == '.') cs
            number = if c == '-' then '-' : num else c : num
        if null number || number == "-"
            then Left "Invalid number"
            else do
                restTokens <- tokenize rest
                return (number : restTokens)
    | otherwise = Left "Invalid token"
    where
        isNextDigit (c':_) = isDigit c'
        isNextDigit [] = False

-- Parser which uses tokens and parses them in the list of tokens into expr
parseExpr :: [String] -> Either String (Expr, [String])
parseExpr [] = Left "Unexpected end of input"
parseExpr (token:tokens)
    | token == "+" = do
        (left, rest1) <- parseExpr tokens
        (right, rest2) <- parseExpr rest1
        return (Add left right, rest2)
    | token == "*" = do
        (left, rest1) <- parseExpr tokens
        (right, rest2) <- parseExpr rest1
        return (Mul left right, rest2)
    | token == "/" = do
        (left, rest1) <- parseExpr tokens
        (right, rest2) <- parseExpr rest1
        return (Div left right, rest2)
    | token == "-" = do
        (expr, rest) <- parseExpr tokens
        return (Neg expr, rest)
    | ('$':numStr) <- token = do
        case readMaybe numStr :: Maybe Int of
            Just n -> return (HistRef n, tokens)
            Nothing -> Left "Invalid history reference"
    | all isValidChar token = 
        case readMaybe token :: Maybe Double of
            Just num -> return (Val num, tokens)
            Nothing -> Left "Invalid number"
    | otherwise = Left "Invalid token"
    where
        isValidChar c = isDigit c || c == '.' || c == '-'

-- Also known as the Evaluator which will evaluates the expr using past history
evalExpr :: Expr -> [Double] -> Either String Double
evalExpr (Val n) _ = Right n
evalExpr (Add e1 e2) history = do
    v1 <- evalExpr e1 history
    v2 <- evalExpr e2 history
    return (v1 + v2)
evalExpr (Mul e1 e2) history = do
    v1 <- evalExpr e1 history
    v2 <- evalExpr e2 history
    return (v1 * v2)
evalExpr (Div e1 e2) history = do
    v1 <- evalExpr e1 history
    v2 <- evalExpr e2 history
    if v2 == 0
        then Left "Division by zero"
        else return (v1 / v2)
evalExpr (Neg e) history = do
    v <- evalExpr e history
    return (-v)
evalExpr (HistRef n) history =
    let reversed = reverse history
    in if n <= 0 || n > length history
        then Left "Invalid history reference"
        else Right (reversed !! (n - 1))
