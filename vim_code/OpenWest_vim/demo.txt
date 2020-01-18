 _
- - /, /,                     |\          222222222222222
  )/ )/ )  '       _           \\        2:::::::::::::::22
  )__)__) \\ /\\  < \, ,._-_  / \\  _-_, 2::::::222222:::::2
 ~)__)__) ||  /   /-||  ||   || || ||_.  2222222     2:::::2
  )  )  ) || /\\ (( ||  ||   || ||  ~ ||             2:::::2
 /-_/-_/  \\  ||  \/\\  \\,   \\/  ,-_-              2:::::2  ::::::
              /                                   2222::::2   ::::::
             (,                              22222::::::22    ::::::
           .--.--.-----.                   22::::::::222
           |  |  |__ --|__                2:::::22222
            \___/|_____|__|              2:::::2
                          _              2:::::2              ::::::
  /\/\  _   _  __ _  __ _| | ___  ___    2:::::2       222222 ::::::
 /    \| | | |/ _` |/ _` | |/ _ \/ __|   2::::::2222222:::::2 ::::::
/ /\/\ \ |_| | (_| | (_| | |  __/\__ \   2::::::::::::::::::2
\/    \/\__,_|\__, |\__, |_|\___||___/   22222222222222222222
              |___/ |___/
    ________         ____               __      __
   /_  __/ /  ___   / __/_ _  ___ _____/ /_____/ /__ _    _____
    / / / _ \/ -_) _\ \/  ' \/ _ `/ __/  '_/ _  / _ \ |/|/ / _ \
   /_/ /_//_/\__/ /___/_/_/_/\_,_/\__/_/\_\\_,_/\___/__,__/_//_/




   ____
  / __ \
 / / / /
/ /_/ /
\____(_) Regular Expressions (a.k.a. regexes) will regularly save your day

How many times does 'jabberwock' appear in this file?

    I could search for it by typing '/jabberwock', and then count how many
    times I press 'n', but then I'd be doing the counting instead of
    making the computer do it, just like a muggle.

    Instead, I'll use the :substitute command

        %s/jabberwock//gn

    The /n flag makes :substitute a NO-OP - it won't actually replace
    any text.

    The /g flag makes it find all occurrences on each line instead of
    stopping at the first.

    But, as a side-effect, the status line now tells how many
    'jabberwocks' it would have replaced in this file.

But wait, there's more!

    I enjoy Lewis Carroll well enough, but I feel like he pulled a total
    Jar-Jar Binks with those borogoves. I'm not too much of a purist to be
    above eliding those from my reading:

        %s/borogoves/midichlorians/g

    Now that's more like it!

            JABBERWOCKY
          by Lewis Carroll

`Twas brillig, and the slithy toves
Did gyre and gimble in the wabe:
All mimsy were the borogoves,
And the mome raths outgrabe.

"Beware the Jabberwock, my son!
The jaws that bite, the claws that catch!
Beware the Jubjub bird, and shun
The frumious Bandersnatch!"

He took his vorpal sword in hand:
Long time the manxome foe he sought --
So rested he by the Tumtum tree,
And stood awhile in thought.

And, as in uffish thought he stood,
The Jabberwock, with eyes of flame,
Came whiffling through the tulgey wood,
And burbled as it came!

One, two! One, two! And through and through
The vorpal blade went snicker-snack!
He left it dead, and with its head
He went galumphing back.

"And, has thou slain the Jabberwock?
Come to my arms, my beamish boy!
O frabjous day! Callooh! Callay!'
He chortled in his joy.

`Twas brillig, and the slithy toves
Did gyre and gimble in the wabe;
All mimsy were the borogoves,
And the mome raths outgrabe.


    :help regexp





This is Traditional vi
    - from the Ancient Unix Ports project
      http://ex-vi.sourceforge.net/

This very program is derived from Bill Joy's original code, ported to run
on a modern POSIX system.

   ___
  <  /
  / /
 / /_
/_/(_) Marks: vi can keep track of a lot of these.

    Use them to hold your place, or to tell vi which text to operate on

    They are a good way to get around the file

        Set a mark with the m{a-zA-Z} command

        Jump to the line containing a mark with '{a-zA-Z}

        Jump to the exact cursor position of a mark with `{a-zA-Z}

        UPPER CASE marks persist *between* files, and across Vim sessions!


        Vim protips:
            '[ and '] mark the boundaries of the chunk of text you
                      previously changed or yanked.

            '< and '> mark the boundaries of your last visual selection.

    :help marks




   ___
  |__ \
  __/ /
 / __/_
/____(_) Ex Commands

    Protip: Ctrl-F opens the :cmdline in its own Vim window, populated
    with the last 50 Ex commands. Now you can edit your command line with
    the full power of Vim!

    Some ex commands don't change your text (:w, :wq, :e) and are
    entered just by themselves.

    The other ex commands can be told which parts of the file to modify
    by specifying a range of lines to operate over. A range of lines is
    given as

        line1,line2

    There is a lot of flexibility in how you tell vi which lines to use:

        {number}       an absolute line number
        .              the current line
        $              the last line in the file
        %              equal to 1,$ (the entire file)
        't             position of mark t
        /{pattern}[/]  the next line where {pattern} matches
        ?{pattern}[?]  the previous line where {pattern} matches

    :help range


    You may also provide an offset after the line specification by giving
    a direction +/- followed by a number. This allows you to specify
    something like "the line AFTER mark a", or "the second line before the
    line containing /foobar/".

    For example, let's set the a mark up on the line reading
    ":help range". Since I didn't think to do it while my cursor was up
    there, I'll just do it from down here:

        /\s:help range/mark a

    Now, let's move that line right above the line beginning with
    "Fortunately" below:

        'am/\sFortunately/-1

    Next, we'll move the line starting with "For example" three lines
    after "Fortunately":

        /\sFor example/m/\sFortunately/+3


    The other day, I noticed that my cherished directory of George Lucas
    crossover fanfic had disappeared. I suspected that one of the users
    who may access that host's guest account had done it, and got a list
    of the incoming IP addresses. But I needed to narrow it down to a
    single person before I could exercise the banhammer.

    Fortunately, this script kiddie didn't think to cover his or her
    tracks and left evidence in ~guest/.bash_history. Now, my task is to
    convert these Unix timestamps into readable dates and times so I can
    correlate this crime to an entry from /var/log/wtmp.


        .+2,/^vim \*.scm/s/^#\(\d\+\)/\="#" . strftime("%Y %b %d %X", submatch(1))/

#1430844589
csc *.o -o main
#1430844592
git add *.scm
#1430844603
git commit -m "works, just need a Makefile to codify how"
#1430844612
./main
#1430844615
cat > .gitignore
#1430844623
git commit -m "add .gitignore"
#1430844624
cat >> .gitignore
#1430844626
git add .gitignore
#1430844628
git add Makefile
#1430844631
git commit -m added\ the\ Makefile
#1430844633
:qa
#1430848133
ls -l /opt/share/Lewis_Carroll_George_Lucas_Crossover_fic
#1430848137
cat > shellcode.c
#1430848158
make shellcode
#1430848160
./shellcode
#1430848184
rm -f shellcode shellcode.c
#1430848188
exit
#1430853730
ls -l /opt/share/Lewis_Carroll_George_Lucas_Crossover_fic
#1430853740
ls -l /opt/share/Lewis_Carroll_George_Lucas_Crossover_fic
#1430853745
ls /opt/share/Lewis_Carroll_George_Lucas_Crossover_fic
#1430853748
ls /opt/share
#1430853750
cd /opt/share
#1430853751
ls -l
#1430853751
ls -l
#1430853752
pwd
#1430853753
ls -l
#1430853774
ls -l
#1430853784
exit
#1430855720
ping taboolasyndication.com
#1430855726
ls -ltr | tail
#1430855734
cd devel/scheme
#1430855742
ls modular
#1430855752
mv modular modular-numbers
#1430855769
ack unit
#1430855776
cd prime-number-stream
#1430855778
cat Makefile
#1430855781
vim *.scm


    :help command-line-mode




   _____
  |__  /
   /_ <
 ___/ /
/____(_) Registers: a handful of clipboard buffers at your fingertips

    Registers are referred to by entering a double-quote followed by the
    name of a register. Like marks, registers each have a single-character
    name.

    Register "" (it's name is double-quote) is the default register. Think
    of it like Perl's $_ variable.  Nearly any operation which can be used
    to fill a register WILL fill this register. When you use the p[ut]
    command, it draws from this register unless told otherwise.

    You can tell a command which register to use by first typing a
    double-quote followed by the register's name.

    For instance, if I wanted to delete a line of text and keep it in the
    "j register, from normal mode I would type:

        "jdd

    I would paste it back again with

        "jp

    Registers "1-9 keep track of your last nine delete operations. They
    operate like a stack, in that older chunks of text are pushed farther
    down the list until they fall off at the end after "9.

    Register "0 is the default yank register. Whenever you type

        yy

    to copy a line of text, it goes into "0 and "". The nice thing is that
    while a subsequent

        dd

    will clobber the contents of "", "0 is *still* holding on to your
    previous yank.

    Registers "a-z are for your own use; vi won't automatically put text
    into these locations.

    You may append text to an alphabetical register by using its name in
    UPPER CASE.  For instance, you can combine non-contiguous lines of
    text from two different parts of your file into the "a register by

        0. Deleting the 1st line of text into the "a register, replacing
           its old contents

            "add

        1. Yanking the 2nd line of text to the end of the "a register

            "Ayy

        2. Later on, when you paste from "a

            "ap

           you'll find that both of the old lines appear together.

    The "* and "+ registers interface with your desktop's clipboard.

    "* corresponds to the X11 selection buffer (the text that is pasted
        when you middle-click)

    "+ is the ordinary cut&paste buffer which most applications fill with
        their Ctrl-C hotkeys or the Edit->Copy menu item.

    These registers are aliases to each other on Windows and platforms
    which don't support a selection buffer.


vi + Registers = macros
    vi has the ability to interpret a register as normal-mode commands,
    giving the user an effective macro capability.

    Vim improves this by *recording* your keystrokes into a register.  You
    may have accidentally done this before - you'll see the word
    "recording" appear down in the command-line. This macro recording mode
    is entered through the "q" command, followed by the name of a
    register. It is concluded by typing a "q" once again.

    To make vi execute the contents of the register as a macro, use the
    "@" command followed by the name of the register containing the macro.

    This feature allows you to show the computer what you want to do once,
    and then letting it replay it as many times as you say.

    Let's use this ability to  do something that is a little tricky to
    accomplish with :substitute//

    I have a list of greetings for some of my friends. These greetings are
    just a bit too honest, so I want to change them into something more
    bland an unoffensive.

    But I don't care about these friends nearly so much to take the time
    to manually un-personalize each of their greetings. What do I look
    like, a noob?

    So, I'll make Vim pay attention to what I'm doing as I fix the first
    one manually:

        03wcWmy goodj

hello there, young fellow.


    I recorded those keystrokes into my trusty "a register. And now I may
    position my cursor on the second line, and "execute" the macro as a vi
    command by typing @a:

hello there, buff fellow.
hello there, slim fellow.
hello there, shady fellow.

    After I've done a few like this, I'm getting tired of typing @a over,
    and over again. If only there were a quicker way!

    Oh wait, there is.

    @@ will replay the last macro over and over again. Now I can just hold
    down the @ key until I'm done!

hello there, strange fellow.
hello there, fairy-god fellow.
hello there, hairy fellow.
hello there, tall fellow.


    But that is still rather muggle-ey. I can see that I have six more
    lines left, so I'll just tell Vim to do this six more times with

        6@@

hello there, short fellow.
hello there, round fellow.
hello there, hygiene-impaired fellow.
hello there, hungry fellow.
hello there, Mac-user fellow.
hello there, shabbily-dressed fellow.

    :help registers




    ______
   / ____/
  /___ \
 ____/ /_
/_____/(_) External tools and programs

    The "vi Way" is to work in harmony with other tools

    :r[ead] FILENAME
        pastes another file into this buffer

    :r[ead] !{cmd}
        pastes the output of an external command into the current buffer

    To see the types of source code Vim knows how to highlight:

        :read !ls $VIMRUNTIME/syntax

    Or that I want to include OpenWest.org's IP address into a script:

        :read !nslookup openwest.org | grep Address

    vi blurs the line between text in files and text generated by any
    program on your computer.


    Now, suppose I want to take text from Vim and use it as input for
    another program.

    :.!{cmd}
        uses the current line (the '.' range) as arguments to {cmd}, and
        *replaces* the current line with {cmd}'s output

    Use this to filter a region of text from a buffer through an external
    program.

        Such as FIGlet

        Or cowsay

        Or pastebinit
                ____                      __
               /\  _`\   __              /\ \__
               \ \ \L\_\/\_\  _ __   ____\ \ ,_\
                \ \  _\/\/\ \/\`'__\/',__\\ \ \/
                 \ \ \/  \ \ \ \ \//\__, `\\ \ \_
                  \ \_\   \ \_\ \_\\/\____/ \ \__\
                   \/_/    \/_/\/_/ \/___/   \/__/
                                 __           __  __  __     _
                                /\ \__       /\ \/\ \/\ \  /' \
         _____      __      ____\ \ ,_\    __\ \ \ \ \ \ \/\_, \
        /\ '__`\  /'__`\   /',__\\ \ \/  /'__`\ \ \ \ \ \ \/_/\ \
        \ \ \L\ \/\ \L\.\_/\__, `\\ \ \_/\  __/\ \_\ \_\ \_\ \ \ \
         \ \ ,__/\ \__/.\_\/\____/ \ \__\ \____\\/\_\/\_\/\_\ \ \_\
          \ \ \/  \/__/\/_/\/___/   \/__/\/____/ \/_/\/_/\/_/  \/_/
           \ \_\
            \/_/


    The normal-mode equivalent to this Ex command is !!{cmd}


    This technique may be applied to useful programs, too!
    
    And what's more useful than your shell? Think about what it would be
    like if you could run shell commands

        figlet -f small right from vi\?

    Wait, wait, don't think. I'll just tell you.

        figlet -f smslant It is awesome!!!


    This is just so useful, you should make it a permanent fixture in your
    .vimrc:

        noremap Q !!sh<CR>

    Now, a list of everybody on the system is just a keystroke away:

        getent passwd | cut -d: -f1

    How much battery life does my laptop have?

        battery

    What's the prime factorization of my favorite numbers?

        factor 1337 31337

    I need a new password for iCloud, AGAIN:

        apg -n 1 -m 32

    One can leverage external programs for more complicated "one-off"
    tasks. These are the sorts of things you might occasionally do in
    another terminal window and cut & paste them back into vi.

    But cut & paste is the muggle way!  Let's see how a wizard would do
    it.

    Suppose I want to generate all 256 two-digit hexadecimal numbers. I
    might write a Perl one-liner to do this, or I might combine the `seq`
    program with printf:

        seq 0 255 | xargs printf '%02x\n'

    That's pretty cool! But it makes an ugly mess of my buffer. There are
    256 numbers in my list, which makes a 16x16 square. Let's see - a
    16x16 square of 2 digit numbers, plus one space in between, plus a
    newline at the end of each line... that's 49 chars per row...

        seq 0 255 | xargs printf '%02x\n' | fmt -w 49

    This capability turns your vi buffer into a text stream, which many
    other programs on your system can understand and manipulate.

For further reading, please see
http://blog.sanctum.geek.nz/series/unix-as-ide/

    :help :read!
    :help filter




   _____
  / ___/
 / __ \
/ /_/ /
\____(_) Split windows

    Isn't it just adorable when another editors allows you to split a
    window in half, or into a pre-determined grid pattern? The really
    progressive ones will let you display the same file in both of its
    splits.

    Vim is like one of Ron Popeil's inventions:

        It slices!

        It dices!

        Satisfaction guaranteed, or your money back!

    Commands pertaining to windows all begin with CTRL-W. Some of the key
    commands are:

        CTRL-W s        split the current window horizontally

        CTRL-W v        split the current window vertically

        CTRL-W h,j,k,l  move the cursor to the split in the indicated
                        direction

        CTRL-W c        close the current split

        CTRL-W o        make the current window the "only" window


    Vim's diff mode is a great keyboard-only way to visualze and compare
    differences amongst up to four buffers, and to merge or revert
    differences between a pair of buffers.

    You may enter diff mode from the commandline by passing Vim the -d
    flag along with the names of the files to compare. This is also the
    only way to start diff mode in NeoVim from the command line.
    Alternatively, Vim installs a symlink to the vim binary named
    'vimdiff' which starts Vim in diff mode.

    Within a buffer opened in diff mode, the following motions are
    available:

        [c  Jump to the previous difference

        ]c  Jump to the next difference

    You may copy the difference under your cursor to the other buffer, or
    pull the accompanying difference over into this buffer with a
    normal-mode command. Doing so will make this region of the file the
    same between the two buffers.

        dp  Put the difference under the cursor into the other buffer

        do  Obtain the difference from the other buffer into this buffer

        :help :split
        :help diff-mode




 _____
/__  /
  / /
 / /_
/_/(_) Visual Mode

    Visual mode is entered when you press "v".

    Visual line mode is entered when you press "V". It highlights entire
    lines.

    Visual block mode is entered with "Ctrl-v" It lets you select a
    rectangular area by "drawing" a rectangular selection area.

    You can jump between the start and end of the selection by pressing
    "o" while in any of these modes.


    Multiple-cursors is the new must-have feature in any text editor
    released in the past few years.

    One of the touted uses is to rename many instances of the same
    variable in one shot. Most Vimmers would just use a :substitute to do
    this... but what the heck, we've been able to it their way for years
    with Vim's visual block selection mode.


        elements[0] = NULL;
        elements[1] = NULL;
        elements[2] = NULL;
        elements[3] = NULL;
        elements[4] = NULL;
        elements[5] = NULL;
        elements[6] = NULL;
        elements[7] = NULL;
        elements[8] = NULL;
        elements[9] = NULL;
        elements[10] = NULL;
        elements[11] = NULL;

    Another thing we can easily do with a block selection is to add to
    each array indexing expression.

    After you "draw" a rectangle once (which can be an inherently muggle-y
    thing to do), you can recall that same rectangle at your current
    cursor location by giving visual block mode a count:

        1<C-V>

    Predictably, a count greater than 1 multiplies your selections width
    and height by that same factor.

    :help visual
    :help visual-block




   ____
  ( __ )
 / __  |
/ /_/ /
\____(_) Insert mode completion

    Like many other editing-type softwares in the world, Vim can spare you
    the trouble of typing everything out. This, of course, only works from
    insert mode.

    <C-N> Pops up a small window containing keywords from your files

    <C-X><C-F> Pops a list of filenames

    Arre yuo a badd speler? <C-X>s suggests spelling alternatives

    <C-X><C-V> Vim keywords (best in the command-line window)

    <C-X><C-L> Completely finishes an entire line

    :help ins-completion




   ____
  / __ \
 / /_/ /
 \__, /
/____(_) Text Objects

    Text objects aren't quite like motions in the sense that it doesn't
        really matter where the cursor is when you invoke it.

    Two ways to use a text object:
        If its name begins with the letter 'a', the object includes the
        delimiters.
        Mnemonic: AN object

        When its name begins with the letter 'i', the object includes
        everything INSIDE of the delimiters.
        Mnemonic: INSIDE object

    Here is a snippet of HTML/JavaScript I borrowed from
    http://bsidesslc.org:

    <script>
        !function(d, s, id) {
            var js,
                fjs = d.getElementsByTagName(s)[0],
                p = /^http:/.test(d.location) ? 'http' : 'https';

            if ( !d.getElementById(id) ) {
                js = d.createElement(s);
                js.id = id;
                js.src = p + "://platform.twitter.com/widgets.js";
                fjs.parentNode.insertBefore(js, fjs);
            }

        }(document, "script", "twitter-wjs");
    </script>

    :help text-objects




            _____  .__                   .__        _____
           /     \ |__| ______ ____      |__| _____/ ____\____
          /  \ /  \|  |/  ___// ___\     |  |/    \   __\/  _ \
         /    Y    \  |\___ \\  \___     |  |   |  \  | (  <_> )
         \____|__  /__/____  >\___  > /\ |__|___|  /__|  \____/
                 \/        \/     \/  \/         \/

Don't forget to try `vimtutor`!


Vim community
        Webs:
                http://www.vim.org
                http://vimcasts.org/
                http://vi.stackexchange.com/ (beta)
                http://vimawesome.com/
                http://www.reddit.com/r/vim
                https://vim.wikia.com/
                http://vimgolf.com/
        Mailing lists:
                vim@vim.org
                vim_dev@googlegroups.com
                vim_use@googlegroups.com
        IRC:
                irc://#vim@freenode.net
        Codez:
                hg clone https://vim.googlecode.com/hg/ vim.hg

Neovim community:
        Webs:
                http://neovim.org
                https://github.com/neovim/neovim/wiki
                http://www.reddit.com/r/neovim
        Mailing list:
                neovim@googlegroups.com
        IRC:
                irc://#neovim@freenode.net
        Codez:
                git clone https://github.com/neovim/neovim neovim.git




       ___________      .__ __   /\        ____   ____.__
       \_   _____/______|__|  | _)/ ______ \   \ /   /|__| _____
        |    __)_\_  __ \  |  |/ / /  ___/  \   Y   / |  |/     \
        |        \|  | \/  |    <  \___ \    \     /  |  |  Y Y  \
       /_______  /|__|  |__|__|_ \/____  >    \___/   |__|__|_|  /
               \/               \/     \/                      \/
  _________ .__                   __         .__                   __
  \_   ___ \|  |__   ____ _____ _/  |_  _____|  |__   ____   _____/  |_
  /    \  \/|  |  \_/ __ \\__  \\   __\/  ___/  |  \_/ __ \_/ __ \   __\
  \     \___|   Y  \  ___/ / __ \|  |  \___ \|   Y  \  ___/\  ___/|  |
   \______  /___|  /\___  >____  /__| /____  >___|  /\___  >\___  >__|
          \/     \/     \/     \/          \/     \/     \/     \/

    I use these mappings in my presentation to speed things up a bit.
    If you want to Vim faster, add these lines to your own .vimrc:


    " execute the current line of text as a shell command
    noremap Q !!$SHELL<CR>


    " Map alt-v in command-line mode to replace the commandline
    " with the Ex command-line beneath the cursor in the buffer
    cnoremap     <Esc>v <C-\>esubstitute(getline('.'), '^\s*\(' . escape(substitute(&commentstring, '%s.*$', '', ''), '*') . '\)*\s*:*' , '', '')<CR>


    " CTRL-L refreshes the screen by default
    " (this keystroke works the same way in many other text programs, too.
    "  try it in your shell to clear the screen)
    "
    " This mapping also un-highlights text matching the current search
    "pattern
    noremap <silent> <C-L> :nohlsearch <bar> redraw<CR>
    inoremap <silent> <C-L> <C-O>:nohlsearch <bar> redraw<CR>


    " Cycle between displaying absolute line numbers, relative numbers, or
    " no line numbers
    "
    " CTRL-N by default moves the cursor down by one line.
    " Personally, I never use it that way as there are already four other
    " ways to do that
    if exists('+relativenumber')
        nnoremap <expr> <C-N> CycleLNum()
        xnoremap <expr> <C-N> CycleLNum()
        onoremap <expr> <C-N> CycleLNum()

        " this function cycles between normal, relative, and no line
        numbering
        function! CycleLNum()
            if &l:rnu
                setlocal nonu nornu
            elseif &l:nu
                setlocal nu rnu
            else
                setlocal nu
            endif

            " sometimes (op-pending mode) the redraw doesn't happen
            " automatically - so I'll force it to happen
            redraw

            " return nothing; this is important to op-pending mode
            return ""
        endfunc
    endif


vim: set filetype=txt textwidth=74 tabstop=4 shiftwidth=4 expandtab nofoldenable :
