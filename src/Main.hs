{-# LANGUAGE OverloadedStrings, OverloadedLabels #-}

import Data.GI.Base

import qualified GI.Gtk as GI (main) -- solve the main problem
import GI.Gtk as Gtk hiding (main)

       -- (buttonBoxNew, buttonBoxSetChildSecondary, widgetShowAll,
       --  setButtonBoxLayoutStyle, buttonNewWithLabel, setContainerChild,
       --  setContainerBorderWidth, mainQuit, onWidgetDestroy, windowNew)
import GI.Gtk.Enums
       (Orientation(..), WindowType(..), ButtonBoxStyle(..))

main :: IO ()
main = do
  Gtk.init Nothing

  win <- new Gtk.Window [ #title := "Hi there" ]
  on win #destroy Gtk.mainQuit

  hbuttonbox <- buttonBoxNew OrientationHorizontal

  button1 <- new Gtk.Button [ #label := "Click me" ]
  on button1 #clicked (set button1 [ #sensitive := False,
                                   #label := "Thanks for clicking here" ])


  -- https://github.com/haskell-gi/gi-gtk-examples/blob/master/buttonbox/ButtonBox.hs
  button2 <- new Gtk.Button [ #label := "Two"]
  on button2 #clicked (putStrLn "second button clicked")

  button3 <- new Gtk.Button [ #label := "Three"]
  on button3 #clicked (putStrLn "3rd button clicked")

  -- Add each button to the button box with the default packing and padding
  mapM_ (setContainerChild hbuttonbox) [button1, button2, button3]

  -- This sets button3 to be a so called 'secondary child'. When the layout
  -- stlye is ButtonboxStart or ButtonboxEnd, the secondary children are
  -- grouped seperately from the others. Resize the window to see the effect.
  --
  -- This is not interesting in itself but shows how to set child attributes.
  -- Note that the child attribute 'buttonBoxChildSecondary' takes the
  -- button box container child 'button3' as a parameter.
  setButtonBoxLayoutStyle hbuttonbox ButtonBoxStyleStart
  buttonBoxSetChildSecondary hbuttonbox button3 True

  #add win hbuttonbox

  widgetShowAll win
  -- #showAll win
  GI.main
