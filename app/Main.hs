{-# LANGUAGE DeriveGeneric #-}

module Main where
import Network.HTTP.Conduit
import Data.Aeson
import GHC.Generics
import Control.Monad

data Joke = Joke {
    joke :: !String,
    category :: !String
} deriving (Generic, Show)

instance FromJSON Joke

fetchJoke :: IO()
fetchJoke = do
    result <- simpleHttp "https://www.yomama-jokes.com/api/v1/jokes/random/"
    case (decode result :: Maybe Joke) of
        Just x -> do
            putStrLn (joke x)
        Nothing -> putStrLn "Error"

loop :: IO()
loop = do
    command <- getChar
    unless (command == 'q') $ do
        fetchJoke
        loop

main :: IO()
main = loop


