module Main (main) where
import Operazioni  -- Importa il modulo che hai creato

main :: IO ()
main = do
  let x = 5
      y = 5
  putStrLn ("Fattoriale di " ++ show x ++ " = " ++ show (fattoriale x ))
  
