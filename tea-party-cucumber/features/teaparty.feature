Feature: Tea Party
    In order to be polite
    As a host
    I want to greet all of my guests appropriately

    Scenario: Greet Jane Austen
        Given my guest is named Jane Austen
        And she is a woman
        And she is not married
        When I greet her
        Then I should say "Hello Ms. Austen"

    Scenario: Greet George Orwell
        Given a guest named George Orwell
        And he is male
        And he is unmarried
        When I greet him
        Then I should say "Hello Mr. Orwell"

    Scenario Outline: greeting
        Given my guest is named <name>
        And they are a <gender>
        And they are <marital_status>
        And they are <knighted_status>
        When I greet them
        Then I should say "<expected_greeting>"

        Examples:
            | name | gender | marital_status | knighted_status | expected_greeting |
            | Jane Austen | female | not married | not knighted | Hello Ms. Austen |
            | George Orwell | male | not married | not knighted | Hello Mr. Orwell |
            | Isaac Newton | male | not married | knighted | Hello Sir Newton |
            | Alleson Buchanan | female | married | not knighted | Hello Mrs. Buchanan |
            | Ellen MacArthur | female | unmarried | knighted | Hello Dame MacArthur |
