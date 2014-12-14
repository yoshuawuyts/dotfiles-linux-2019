lorem-ipsum
==================

Generate lorem ipsum text of varying sizes in Atom.

## Installation

#### For Use
Install the Lorem Ipsum package using the command line

    apm install lorem-ipsum

Or install it from the Atom Package Manager.

#### For Development
If you want to make changes to this project. Install the package using

    apm develop lorem-ipsum

Then open Atom in developer mode (Atom command tools must be installed)

    cd path/to/package
    atom --dev

## Example

#### Generate Sentence (ctrl-alt-s)
> Labore sit nulla amet enim reprehenderit esse laborum Lorem quis in eu.

#### Generate Paragraph (ctrl-alt-p)
> Veniam veniam sit cupidatat mollit dolor proident. Ea est reprehenderit reprehenderit ullamco. Sunt dolore sint velit incididunt dolore reprehenderit ad sit. Do esse voluptate sit in consequat sint Lorem consectetur laboris elit ipsum. Fugiat excepteur dolor veniam sit velit aliquip laboris consectetur dolor incididunt sint proident.

#### Generate Paragraphs (ctrl-alt-shift-p)
> You can probably guess what this will look like... (3-5 paragraphs)

## Settings

It's possible to customize the text generation settings. They are all currently
defined by `ranges`, which are 2 integers in ascending order, separated by a comma
(weird results otherwise).

![settings options](http://i.imgur.com/mUfClaT.png)

#### Paragraph Range - `2, 5`
The number of paragraphs generated when you generate multiple paragraphs.

#### Sentence Range - `4, 10`
Number of sentences in a paragraph.

#### Word Range - `6, 15`
Number of words in a sentence.
