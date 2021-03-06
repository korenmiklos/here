# here
`here` is a Stata package roughly replicating the behavior of the R library with the same name.

## Installation

Install with `net install`:

```
net install here, from("https://raw.githubusercontent.com/korenmiklos/here/master/")
```

## Usage

Type the command `here` anywhere inside a project folder and it will put the *root* of the project folder into a global macro called `here`.

```
. pwd
/Users/koren/projects/social-distancing/analysis/counterfactual

. here
/Users/koren/projects/social-distancing

. display "${here}"
/Users/koren/projects/social-distancing

. import delimited "${here}/data/raw/bls/employment.csv"
```

To fix the root folder, use `here, set`.

```
. cd "/Users/koren/projects/social-distancing/analysis"
/Users/koren/projects/social-distancing/analysis

. here, set
/Users/koren/projects/social-distancing/analysis

. display ${here}
/Users/koren/projects/social-distancing/analysis
```

## Under the hood

With the basic usage, `here` looks for a parent folder with the (empty) file `.here` in it. Suppose you have the following folder structure.

```
.
├── .here
├── analysis
│   ├── counterfactual
│   │   └── simulate.do
│   └── regress.do
└── data
    └── raw
        └── employment.csv
```

Whether you call `here` from `analysis/regress.do` or from `analysis/counterfactual/simulate.do`, the value of `${here}` will be absolute path of the folder containing the file `.here`. Whevener you issue
```
here, set
```
here will put a file called `.here` in your current folder.

`here` will also stop if it finds a `.git` folder, with the understanding that git repositories are typically in the root of a project folder. But if this is not case for your project, you can turn off this behavior with the otion

```
here, nogit
```
