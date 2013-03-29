kangaroo.vim
============

Kangaroo.vim is an incredibly simple plugin that allows you to manually
maintain a jump stack. With the jump stack, you can push a location, jump
around in this and other buffers, and then pop back to where you were.

To push the current cursor position onto the jump stack, press `zp`. To
pop the last position off the stack and return to it, press `zP`.

Can't I just use marks or the regular jump list for that?
---------------------------------------------------------

Yup.

So why is this any better?
--------------------------

Marks are good, but coming up with letters to use and remembering where
you used them is a pain. The jump list is good, but they get set far more
often than you care about. Enter a nice middleground: Manually manipulate
a stack of positions when you know you are going to engage in a quick
interruption.

Installation
------------

If you don't have a preferred installation method, I recommend
installing [pathogen.vim](https://github.com/tpope/vim-pathogen), and
then simply copy and paste:

    cd ~/.vim/bundle
    git clone git://github.com/tommcdo/vim-kangaroo.git

Once help tags have been generated, you can view the manual with
`:help kangaroo`.
