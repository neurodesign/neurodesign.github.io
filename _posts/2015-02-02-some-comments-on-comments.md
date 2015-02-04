---
title: Some comments on comments
tags:
  - comments
  - php
---

I'm sure you already heard about the importance of comments in code. I started hearing about that at school. My teachers made it clear that a good programmer comments his code. However, they "forgot" to tell us what those comments should be. Sure, we learned about those //, #, ; or /* \*/, but not about the contents.

The same happened in my profesionnal life, with managers asking me if the code I had produced was "properly commented". Likewise, some coding standards or oss contribution guidelines are making some comments mandatory. What should those comments say exactly? To what extent should we comment our code? Well, my answer is this: *most of the time, your code should contain no comments*.

Commented code looks like well thought code. When reading it, it makes you feels like the developper paid attention to explain what he did. "How thoughful! Each variable has a little description!". For some time, commenting made me feel as if the code I produced was clearer, cleaner, and easier to maintain. But what really is the added value of those comments? Are they helping you understand what's going on? Would your code be difficult to grasp if those comments were not there? If your answer is yes, maybe your code is not clear enough: your comments are only giving an impression of cleanliness. If your answer is no, then probably you could (and should) delete those comments.

My current policy is: if you need to comment something, then your code is not good enough. Let's look at the most common comments cases you can come across in code you'll read (or code you'll produce).

## Useless comments

Adding useless comments is like crying wolf: your reader will learn to skip then. Somehow, it's brain will totally stop seeing them. Each of the following examples are taken from projects I worked on.

### Variable or function name as a comment

    /**
     * Max session
     */
    protected $maxSession = 5;

    /**
     * Get random ip
     */
    protected function getRandomIp()

I don't think I even need to say more: those comments have zero value.

I'll add this one, just for fun:

    // Mail manager
    $this->mailManager = $mailManager;


### Describing what you're doing

    // retrieve gameType and userType
    $gameTypes = \GameType::getAll();
    $limitTypes = \LimitType::getAll();

    // init connection for database
    $con = $this->getConnectionOnDatabase();

### @author, @since, @version, @revision, @really?

Those comments seem to make their author feel professional. However, if you're using a version control system (and i hope you do), you don't need those. Your vcs will tell you everything you need to know.

### Wrong comments

Worse than useless comments, some comments are just wrong. Either they were not updated when the code changed, or were copy pasted.

#### Not updated

    /**
     * @param User $user
     * @param DateTime $time
     */
    public function getRevision($time)

It looks like this method was once outside of that User class...
If the comment is not updated, maybe it's not that important?

#### Copy pasted comments!

    /**
     * Describes another thing
     * @author Out-of-the-company-since-2-years@company.com
     */
    public function newFunction(...)

How can anyone copy paste a method's docblock? Yet I can't count how many times I found such a thing. At one time, a generic comment had been copy pasted more than 50 times in a project I worked on.

### Commented code and @todo's!

Commented code is always kind of scary: was it a debugging attempt? is there a bug hiding? or some kind of important part of history that must be preserved? an idea for an improvement? an accident? I've already found commented code sitting there for at least 5 years.

Don't comment code, delete it. If you really find out you needed it, it's still there, sitting in your vcs history.

Also, about todo's: code is not a place to keep those. They'll probably just stay there until someone else stumble upon it and is involved enough to wonder what it means. If you like using those, make sure they live no longer than your current branch, and don't send them into production code (grep your diff!).

## Comments instead of clear code

### Comments used in place of good naming

When you're writing a comment about a variable, or a method or function, maybe you should consider changing it's name.

Here is an example:

    // Number of current players
    $nb = ...

How about changing that to:

    $nbOfCurrentPlayers = ...

With that change, the comment is useless. When you find yourself feeling like a comment is needed, change the name of that thing.

### Comments in place of a method or function

I'm sure you already read code like this: 

    //--------------------------
    // Do x to ...
    code, code code...
    code,
    code.
    [...]
    code
    //--------------------------

And the same goes on for 4 or 5 of those blocks. What about extracting methods?

    doXTo...();
    doY...();

Isn't it better?

## How to comment

### Don't

You should code as if comments didn't exist. Refactor, extract, rename: make your code so clear that comments are redundant and useless (and of course, don't add those). When you think about adding a comment, try thinking of a way to avoid that.

### Unless your really need to

These days, I find myself commenting only when an explanation is needed about why I'm doing something: an unexpected api behaviour, a strange reason for doing something, a non obvious webservice response, etc.

### Comments should be red

Since comments are only there where something unexpected or complex is done, they must be considered a signal for danger. Configure your ide to display comments in red.

### Cleanup

Be pitiless with useless and bad comments. Remove those without hesitation. Even remove commented code. If you feel bad about it, ping the commit's author to get his input.

### Share

Finally, do what I just did: share what you think with your peers and your team. Make sure everyone agrees and applies the same principles.
