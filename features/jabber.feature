Feature: Offer up Jabber as a service
  As a sysadmin with existing Linux-based infrastructure
  I want to create a Jabber server
  So that I can have Jabber conferences and person-to-person instant messaging enabled

  Background: Always start with a bare Linux VM
    Given I have an empty Linux machine
    And the machine should become a Jabber server

  @wip
  Scenario: Basic set up
    When I provision the host
    Then the Jabber server should be running
    And it should be listening for connections

  @wip
  Scenario: Open up to the outside world
    Given then firewall has been configured to allow Jabber through
    When I provision the host
    Then the Jabber port should be open to the outside world
