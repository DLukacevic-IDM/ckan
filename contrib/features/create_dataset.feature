@demo
Feature: Create a new dataset
  As a researcher,
  I want to save and tag my dataset for projects

  Background:
    Given The user is logged in
    Given The user is added to the organization


  Scenario: Add a dataset from third party source
    Given I have a link for a dataset
    When I click "new dataset"
    Then I am required to fill in these fields
      | field       |
      | Description |
      | Title       |
      | Visibility  |
    And I can optionally add up to 3 of fields
    And I can click add data and enter url of the third party source


  Scenario: Add a dataset by upload
    Given I have a link for a dataset
    When I click "new dataset"
    Then I am required to fill in these fields
      | field       |
      | Description |
      | Title       |
      | Visibility  |
    And I can optionally add up to 3 of fields
    And I can click add data upload myfile


  Scenario Outline: Update dataset
    Given I know my dataset url
    When I Click manage
    And I update these <field>
    Then I can update dataset

    Examples:
      | field       |
      | Description |
      | Title       |
      | Visibility  |


  Scenario: Delete dataset
    Given I know my dataset url
    When I Click manage
    And I click delete
    Then the dataset url should now be invalid





