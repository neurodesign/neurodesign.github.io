---
layout: post
title: Some comments on comments
tags:
  - comments
  - php
---

I'm sure you already heard about the importance of comments in code. I started hearing about that at school. Most teachers constantly repeated that a good programmer comments his code. However, they "forgot" to tell us what those comments should be. Sure, we learned about those //, or #, or /* \*/, but not about the contents. The same happened in my profesionnal life, with managers asking me if the code I had produced was "properly commented". Some coding standards or oss contribution guidelines are making some comments mandatory. But, to what extent should we comment our code? What should those comments say exactly? Well, *most of the time, your code should contain no comments*.

Commented code looks like well thought code. When reading it, it makes you feels like the developper paid attention to explain what he did. "Man, each variable has a little description!". For some time, commenting made me feel as if the code I produced was clearer, cleaner, and easier to maintain. But what really is the added value of those comments? Are they helping you understand what's going on? Would your code be difficult to grasp if those comments were not there? If your answer is yes, maybe your code is not clear enough. And then, comments are only hidding the uglyness. If your answer is no, then probably you could delete those comments.

My current policy is: if you need to comment something, then your code is not good enough. Let's look at the most common cases you can come across in code you'll read (or code you'll produce).

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

### @author, @since, @revision

Those comments seem to make their author feel professional. However, are you using a version control system? Sure you do. Then you don't need those. Your vcs will tell you everything you need to know. If you don't use one yet, change that.

### Wrong comments

Worse than useless comments, some comments are just wrong. Either they were not updated when the code changed, or were copy pasted.

#### Not updated

    /**
     * @param User $user
     * @param DateTime $time
     */
    public function getRevision($time)

Looks like this method was once outside of that User class...
If the comment is not updated, was it that important in the first place?

#### Copy pasted comments!

    /**
     * Describes another thing
     * @author Out-of-the-company-since-2-years@company.com
     */
    public function newFunction(...)

How can anyone copy paste a method's docblock? Yet I can't count how many times I found such a thing. At one time, a generic comment had been copy pasted more than 50 times in a project I worked on.

### Commented code and @todo's!

Commented code is always kind of scary: is that a debugging attempt? some kind of important part of history that must be preserved? an idea for an improvement? an accident? I've already found commented code sitting there for like 5 years. Don't comment code, delete it. If you really find out you needed it, it's still there, sitting in your vcs history.
Also, about todo's: code is not a place to keep those. They'll probably just stay there until someone else stumble upon it and is involved enough to wonder what it means. If you like those, make sure they live no longer than your current branch, and don't send them into production code (grep your diff).

## Comments instead of clear code

### Comments used in place of good naming

When you're writing a comment about a variable, or a method or function, maybe you should consider changing it's name.

Here is an example:

    // Number of current players
    $nb = ...

How about changing that to:

    $nbOfCurrentPlayers = ...

And then the comment is useless. When you find yourself feeling like a comment is needed, change the name of that thing.

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

Isn't it better?

## When to comment

You should code as if comments didn't exist. Refactor, extract, rename: make your code so clear that comments are redundant and useless (and of course, don't add those). When you think about adding a comment, try thinking of a way to avoid that.
These days, i find myself commenting only when dealing with weird stuff: an unexpected api behaviour, a strange reason for doing something, a non obvious webservice response, etc.

Be pitiless with useless and bad comments. Remove those without hesitation. Even remove commented code. If you feel bad about it, ping the commit's author to get his input.

Finally, do what I just did: share what you think with your peers and your team. Make sure everyone agrees and applies the same principles.
