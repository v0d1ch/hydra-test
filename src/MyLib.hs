module MyLib where


data HydraState
  = Initialising
  | Open
  | Closed
  deriving (Eq, Show)

data Utxo = Utxo deriving (Eq, Show)

data HydraHead =
  HydraHead
    { hydraHeadState :: HydraState
    }
  deriving (Eq, Show)

canInitialise :: HydraState -> Bool
canInitialise Initialising = True
canInitialise _ = False

canClose :: HydraState -> Bool
canClose Open = True
canClose _ = False

doCloseHydraHead :: HydraState -> HydraState
doCloseHydraHead s =
  case s of
    Open -> Closed
    x  -> error $ "Cannot close hydra head using state " <> show x


testClose :: IO ()
testClose = do
  let s = Open
  if canClose s
    then print $ doCloseHydraHead s
    else error "Cannot close hydra head"
