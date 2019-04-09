# Galaga Tribute

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
A Galaga-style shooter where the player can tilt their phone side to side to move, and tap to shoot. There will be a Title screen, Menu, Gameplay, and a Highscore screen

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Entertainment
- **Mobile:** Not Uniquely Mobile
- **Story:** No Story
- **Market:** Large Market
- **Habit:** Very Habbit Forming
- **Scope:** Very Technically Challenging

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [ ] User is shown a title screen upon launching the game
* [ ] User can view a menu with the buttons: Play, Options, Highscores
* [ ] User can move by tilting and shoot by tapping
* [ ] User sees a highscore board when they lose


**Optional Nice-to-have Stories**

* [fill in your required user stories here]
* ...

### 2. Screen Archetypes

* Title Screen
   * User is shown a title screen upon launching the game
* Menu
   * User can view a menu with the buttons: Play, Options, Highscores
* Game
   * User can move by tilting and shoot by tapping
* High Scores
   * User sees a highscore board when they lose

### 3. Navigation

**Flow Navigation** (Screen to Screen)

* Title Screen
   * => Menu Screen
* Menu Screen
   * => Game Screen 
* Game Screen
   * => Score Screen
* Score Screen
   * => Menu Screen(after finishing, return to play another round)

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="http://i65.tinypic.com/ixdrpu." width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | username      | String   | unique username for the playing user |
   | score         | Number   | the score the user obtained |
   | position      | Number   | the position on the scoreboard |

### Networking
### List of Network Requests by Screen
  - Score Screen  
      - (Read/GET) Grab the top 3 high scores and the current player's score
      - (Update/PUT) Update user high score if conditon is met
 
