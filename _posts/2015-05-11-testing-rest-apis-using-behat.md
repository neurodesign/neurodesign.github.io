---
title: Testing a rest api using behat
tags:
  - behat
  - rest
  - test
---

I've recently been involved in a heatful debate regarding the use of behat (cucumber) for testing rest apis. While testing features should generally avoid implementation specifics, this "good pratice" can be misunderstood and taken to far in the context of apis. I first try to show the issue with this heuristic, demonstrating that there is no way to reliably test an api without a strong focus on the implementation, and then propose to focus on what matters: the user, to build really valuable tests.


## Good pratices and implementation details

Generally speaking, gherkin features are not supposed to be procedural references. Procedures belong in the implementation details. Here is a typical feature for a login feature:

	Given the system has a valid user with username "Bob" and password "tester"
	When I try to login with "Bob" and "tester"
	Then I should be logged in
	And I should see a welcome message

For a website, this feature seems nice, and won't need to change if the implementation changes. It is generic and allows to test the value added by the login feature in all cases. I don't care about the login field having a specific class, a particular id or even a unique name. Changing those details won't break the feature.


##Are those really details?

However, in the case of an api, what happens if I change the username field to user_name or userName? What happens if you now require the user details to be posted as XML instead of submitted as form values? Sure, the context can be updated, the tests will pass, and you'll still have a login feature. What you won't have anymore is the logging feature you commited to deliver. What you've got is a broken api and angry users. A test that fails preventing that is a bad test.


##Adopt the user perspective

Instead of relying on the "hide the details" dogma, what I propose is to consider your behat features and scenarios as an extensive user manual (remember the name of the default cucumber features folder? docs!).
A useful heuristic consists in asking yourself those questions: is my scenario testable by a naive human being? Is my system documented enough to be usable if the only information I provide to my users is my docs folder? If cucumber did not exist, would the scenario still be enough to test the feature? "Given I try to login with..." might be enough for your website, but my guess is it won't be for an api: how should I format my data? Am i supposed to use SOAP? post the values as a form? in the body? as Json?

Always take the point of view of your user and focus on what matters to him. Of course, a website user does not care if your username input field is named "username" or "whatever". On the contrary, an api user cares for such a thing. He wants to know the uris of each of your public resources, does not want those to change, and needs to know the exact details of all requests and responses he's going to use.

Actually, that's the whole point of the focus on "stakeholders". This term is generally understood as a non technical business owner, and who doesn't care for the implementation details. However, in the case of an api, the stakeholder is another developper trying to write a client.


##Read more

I suggest you to have a look at the cumcumber feature files themselves, or the behat sources. See all that code in the features? Do the authors look like they are trying to hide implementation details?
Also, the cucumber book has a short chapter on rest api testing (chapter 12), in which the same approach is adopted. However, it does not discusses the reasons for their approach, but instead focus on in-process and out-of-process testing of apis (whether to test through the web server or by using an instance of your controllers to test the features).
