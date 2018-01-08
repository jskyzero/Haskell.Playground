# Heskell-Study
`jskyzero` `2017/09/04`
> 

![haskell](./docs/haskell-logo.png)
## OverView
+ Haskell is a purely functional, lazy, statically-typed programming language with type inference.
  + Functional means that functions are first-class data types.
  + Purely Functional means (roughly) that there are no side effects. Every function will always return the same value for a given argument will do nothing else.
  + Lazy (a.k.a "non-strict") means that the compiler will put off evaluating a thing until absolutely neccessary. This lets you safely do weird stuff like operating on an infinite list--the language will only create it up to the last value you actually use.
  + Statically-typed means that identifiers have a type set at compile time--like those in Java, C++ or C#--instead of holding data of any type like those in Python, Ruby or JavaScript.
  + Type inference means that the compiler will often figure out the type of an identifier by itself so you don't have to specify it. Scala and later versions of C# both do this.
+ Use haskell to learn Functional Programming
  + use `ghci` to enter code in shell
  + use `ghc` to compile code to exe
+ ...

## Structure

```
.
├── docs                                  // documents
├── hardwork
│   ├── hardway                           // hardway
│   ├── helloworld                        // helloworld
│   └── homework                          // homework codes
│       ├── 10.Bid                        // file IO 
│       ├── 11.Functor_Applicative_Monad  // monad in haskell
│       ├── 1.Fraction                    // define (a / b)
│       ├── 2.Newton_Raphson              // solve function
│       ├── 3.Print_Receipt               // screen IO
│       ├── 4.Ascii_Picture               // function compound
│       ├── 5.Check_Validation            // function compound
│       ├── 6.Basic_Expression_System     // + - * / system
│       ├── 7.Boolean_System              // bool system
│       ├── 8.BMI_Game                    // solve your bmi
│       ├── 9.Guess_Game                  // play with computer
│       └── README.md
├── projects
│   └── example                           // A use package sample project
└── README.md
```

## Reference
+ [hoogle](https://www.haskell.org/hoogle/)
+ [Haskell Docs](https://www.haskell.org/documentation)
+ [What I Wish I Knew When Learning Haskell](http://dev.stephendiehl.com/hask/#basics)
+ [Functors, Applicative Functors and Monoids](http://learnyouahaskell.com/functors-applicative-functors-and-monoids)
+ [Haskell函数程序设计](http://my.ss.sysu.edu.cn/qhy/Courses/FP/index.html)

