# **Arbiter: Choose-your-own FAQ** #

# **1. What the hell is going on?** #

A: This is the Frequently Asked Questions file for an open source software project called Arbiter. Arbiter is a suite of scripts and open source tools designed to accommodate a very wide range of models in evolutionary game theory, without privileging the methodologies historically associated with economic or biological research. An Arbiter environment is also designed to be more computationally efficient for many game theory modelling tasks than a single tool such as NetLogo or Mathematica.
> This is a choose-your-own FAQ, and you may be advised at various points to skip questions that are less likely to be helpful or of interest to you. The Arbiter project involves researchers with a variety of skill sets and foci, and this document is intended to assist all of them. So right now, if you think of yourself more as a programmer, go ahead to question 2. If you think of yourself more as a game theorist, you probably want to skip to question 5.

# **2. What does a game theory modelling environment do, exactly?** #

A: Great question, Hypothetical Interested Party! This sort of environment offers a way for a researcher to set up a “game”, which we define more precisely in question 3, set up a population of players pursuing pre-defined strategies in the game, and see which players get rewarded the most for their strategies. Furthermore, the results are recorded in a flexible, efficient way that allows subsets of the data obtained to be passed to mathematical tools for analysis.

# **3. What is a “game”, in this context?** #

A: A game, in the context of evolutionary game theory, is made up of a set of players, a set of  available moves, and a set of results from those moves. (Nota bene: What we are referring to as “moves” are often called “pure strategies” in game theory texts.) So you see, HIP, to define the traditional Prisoner's Dilemma, we specify the players Alice and Betty, the moves Cooperate and Defect, and a matrix that shows the result for each player (Alice, Betty) of each combination of what Alice does and what Betty does.  Or PD=({A,B}, {C,D}, {(3,3), (4,0), (0,4), (1,1}}, meaning if  Alice and Betty both make move C, they each get 3 units of result, if Alice makes move D and Betty C, Alice gets 4 units and Betty 0, and so on.

# **4. Why is Arbiter built the way it is?** #

A: This is a big question, and we'll address it in parts. First, we'll touch on implementation language. The real answer there is “because whosoever has been contributing lately likes it that way.” At the time of this writing, it's in Perl, because Arbiter's main job is to pass information around to various other scripts and software tools, not to do any heavy lifting. But that shouldn't matter too much.
> A more interesting question is: Why is Arbiter structured the way it is? Well, HIP, the notion is that various computationally intensive tasks in a game theory model are separable, to the extent that they can be handled by modules placed on different machines and exchange information over a network. So if the players in a game use very sophisticated algorithms to select moves, computational load from that can separated from the computational load of calculating the results of an iteration of the overall game. Furthermore, if more than one player is using the same algorithm, Arbiter can be taught to know better than to calculate the same result in multiple places, and simply query a given strategy engine for a particular result given particular parameters, and then applies that result to all players using that engine from that position. Furthermore, obtaining results is handled separately from analysing those results, so that a model can be run through a large number of iterations quickly and imaged or interpolated later.

# **5. What's the deal with these “Definitions” and “Dynamics”?** #

A: These categories basically revolve around the distinction between elements that are invariant across the life of the model (definitions), and elements that change from iteration to iteration (dynamics). Alternately, you may want to think about the distinction between low level (in CS terms) controlling processes and responsive modules. Of course, thinking about it this way, some definitions are partially dynamics in that they can be modified by more structurally primitive definitions. It will depend on the desired implementation of a given model what is designated as definitional and what is designated as dynamic. For example, in many traditional models of two-player non-cooperative games, the pay-off matrix is invariant across iterations. But we can imagine a game in which some moves not only generate scalar utility, but also impact the pay-off matrix of future iterations. So in such a game, the pay-off matrix itself would be recorded in the dynamics, and only the master algorithm that generates it would be part of the definitions.

# **6. So... what do I do with this thing?** #

A: At this point, everyone's a developer of one sort of another. If you are conversant with game theory and programming isn't baffling to you, you may want to examine our examples and generate some of your own for classic games such as Stag Hunt or Matching Pennies. You'll have to pick up a little Perl; so it goes. If you really think you get what's going on here, you could standardize and document the protocols, basing your version on usage examples. There are plenty of other goals for the Arbiter project as well. If you are interested in expanding it from the game theory end, there are some interesting goals discussed in question 9. If you are interested in really improving the implementation and creating an interface for non-coding users, check out question 11. If you have some other ideas about how we should move forward, you should probably just implement them send us a link to somewhere where we can see them demonstrated—contact info is found in question 16. But as you can see, we have plenty on our plates.
> If you're not actually interested in helping us develop, read on.

# **7. My girlfriend is making me look at this thing, but I really don't care. How can I gain a basic familiarity with your stuff, or at least seem to, with minimal effort?** #

The Google Code page, which is probably where you got this CYOFAQ, has instructions on how to get the Arbiter code using svn. Download it and run bin/start. It'll give you a prompt and tell you how to run one of the examples, which will leave a directory full of results that show you at least executed the code. If your girlfriend is really into this stuff, you should also read question 3 and if you don't understand the answer, spend some time on Wikipedia until you do.
> But more importantly, you should stop trying to feign an interest in things that your girlfriend is genuinely into. Either you should be able to honestly explain to her that this isn't engaging to you, and talk about how to spend meaningful time together despite each having some bracketed areas of interest, or you should genuinely make the effort to see what it is about modelling game theoretic process that she finds so fascinating. Or, maybe it's not meant to be. You seem restless, and you need to be honest about what's really going on. Would it kill you to get her flowers for no reason once in a while, or at least remember which movies she was really excited about after seeing the trailers?

# **8. I tried to follow your advice, because at the end of the day I really do care. But it all went wrong and we had a big fight. Now she's thrown me out of the apartment. Can I crash on your couch?** #

A: No.

# **9. What sorts of game theory research goals motivate Arbiter, and what can be done to advance them?** #

A: Great question, HIP. I like the cut of your jib. One important concern we have in developing Arbiter has to do with very sophisticated players; having players that use very sophisticated decision procedures to choose moves creates massive computational overhead in models that are developed with a single program emulating an entire population (see question 4). One good project would be to program some very sophisticated decision engines that are designed to interface with Arbiter and show how they could be run as separate processes, perhaps even on separate hardware over a network, and then pass moves to Arbiter using tokens it understands.
> Another great idea would be to develop a game using the evolving pay-off matrix notion described in question 5. I kinda want to do that, but I'm stuck writing this CYOFAQ for the moment.

# **10. Does Arbiter work better for demonstrating replicator dynamics or identifying stability criteria?** #

A: Yes.

# **11. What are the goals for Arbiter's user interface?** #

A: Eventually, we'd like for Arbiter to have a GUI interface (maybe in a web browser) that basically involves a series of pull-down menus specifying what sort of model a researcher wants: symmetric or not, what the population for the model should be, what the pay-offs look like. Then, the model generates results with the click of a button. Something like that. It'll be awesome. You should build it for us. You're really smart, we know you'd do a good job.

# **12. Okay, I'm in. What else?** #

A: Really? You're so great. So, there might be also be a tools panel for exporting data from the results to an analysis tool like R or SAGE. And if there could be some pre-defined scripts for common kinds of graphs and other visualizations, that would be even better.

# **13.  Wait a second... are these actually frequently asked questions, or just excuses to ask for us to do cool things for you?** #

A: Are you kidding? This is totally an excuse to write something less rigorous than a proper SRS, while also avoiding answering actual FAQs. Let's face it, the questions we really get the most often (over the 'Net, anyway) are kind of dumb and the people who ask them are basically just showing that they wouldn't really be very helpful with the project.

# **14. You're kind of a jerk.** #

That's not really a question, more of an observation.

# **15. Did you know that you're kind of a jerk?** #

A: Ha. Ha. Ha.

# **16. I really want to chastise you for your intellectual/moral failings in specific detail. How can I contact you in order to ruin your day with judgmental, irrelevant and possibly incoherent rambling?** #

Well, I want nothing to do with this, but I know a couple of chumps who will take your abuse. Email Robert, guitar.robot@gmail.com, or Nathan, metabeardo@gmail.com, and they are likely to take you seriously. Noobs.