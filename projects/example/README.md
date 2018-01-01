# Use Package in Haskell
`jskyzero` `2017/09/11`

## backgroud

+ I want to use test function in Haskell
+ so I found [HUnit](https://hackage.haskell.org/package/HUnit)
+ I download it but I don't know how to use those files

## hardway

+ [how to install packages with local files](https://wiki.haskell.org/Cabal/How_to_install_a_Cabal_package)
+ But I found dependence error and I, anyway, think I shouldn't fix it by hand
+ then I found [Cabal-Install](https://wiki.haskell.org/Cabal-Install) so maybe, cabal is a well solution

## cabal
```shell
# install cabal
sudo apt-get install cabal-install
# sanbox init
cabal sanbox init
# install package
cabal install packge_name
# use exec run command
cabal exec -- ghc Example.hs -main-is Example.main -o bin_file_name
```

## reference

+ [cabal introduction and docs](https://www.haskell.org/cabal/users-guide/intro.html)
+ [Cabal-sandbox Introduction](http://coldwa.st/e/blog/2013-08-20-Cabal-sandbox.html)
