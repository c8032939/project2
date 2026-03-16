# Standaholic

Standaholic is a web and mobile app that helps people with standing desks build healthier work routines by switching more consciously between sitting, standing, and walking.

The app is designed for people who work at a computer, either from home or in the office, and want a simple, reliable system that brings more movement into the workday without being distracting.

## Vision

Standaholic brings movement back into everyday work.

Instead of staying in the same mode for hours, users are encouraged to alternate between sitting, standing, and walking in a way that feels natural and sustainable. The goal is not to create another productivity tool, but a calm and dependable companion that supports healthier habits through well-timed reminders and simple routines.

The app should be:
- simple
- accessible
- privacy-friendly
- calm and unobtrusive
- useful in the background without demanding constant attention

## Core idea

Standaholic uses configurable work phases such as:
- Sitting
- Standing
- Walking

A timer runs through these phases and reminds the user when it is time to switch.

Default example routine:
- Sitting: 12:30
- Standing: 12:30
- Walking: 5:00

Users can adjust both:
- the duration of each phase
- the order of phases

## MVP scope

The first version of Standaholic focuses on a local-first experience without accounts or cloud sync.

### Included in MVP
- configurable phase routine
- running timer for the current phase
- automatic transition to the next phase
- local notifications at phase end
- default behavior: wait for user confirmation before switching
- manual phase logging via button
- simple daily statistics
  - time spent sitting
  - time spent standing
  - time spent walking
- local-only data storage
- Flutter app for web and mobile

### Not included in MVP
- gamification
- social features
- account system
- cloud sync
- automatic activity detection

## Product principles

Standaholic should feel:
- quiet
- minimal
- supportive
- not pushy
- privacy-friendly

The app should help users build healthier routines with as little friction as possible.

## Future ideas

Possible future extensions:
- automatic activity detection on mobile
- login and cloud sync
- backend with Supabase
- richer statistics
- more flexible reminder logic
- optional gamification elements

## Target group

People who:
- work at a computer
- work from home or in an office
- use a standing desk
- want to reduce long sitting periods
- want a healthier and more dynamic work rhythm
