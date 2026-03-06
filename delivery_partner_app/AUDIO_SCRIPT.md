# Delivery Partner App — 10-Minute Audio Script
**Product by QuickPrepAI**  
*Estimated read time: ~10 minutes at 130 words/minute (~1,300 words)*

---

## [INTRO — 0:00 to 0:45]

Welcome. This presentation covers the Delivery Partner App — a complete, end-to-end mobile solution built for delivery partners and fleet administrators. This product is proudly developed by **QuickPrepAI**, a team dedicated to building intelligent, purpose-driven software that solves real-world logistics challenges.

Whether you're a delivery partner looking for a seamless on-the-ground experience, or a business administrator managing a fleet — this app was built for you. Available on both Android and iOS, it is fast, intuitive, and designed to handle everything from sign-up to payout — all in one place.

Let's walk through every feature, step by step.

---

## [SECTION 1: SPLASH SCREEN & ONBOARDING FLOW — 0:45 to 1:30]

The moment you open the app, you're greeted with a polished animated splash screen. The app logo scales in smoothly with an elastic bounce animation, giving a calm, professional first impression before automatically transitioning to the login screen within three seconds.

This isn't just cosmetic — it sets the tone for the entire experience. QuickPrepAI has paid close attention to every transition and micro-interaction so that the app feels alive and responsive from the very first second.

---

## [SECTION 2: AUTHENTICATION — 1:30 to 2:30]

Security and simplicity go hand-in-hand in the authentication module. The login screen features a deep gradient background with glowing decorative elements, creating a visually striking yet distraction-free interface.

Partners log in using their **phone number and a one-time password (OTP)**. The flow works like this:

1. Enter your mobile number
2. Tap "Send OTP"
3. Receive the OTP on your phone
4. Enter the code to verify your identity

The system auto-validates the OTP and logs you in immediately. There are no passwords to remember, no complex forms to fill — just a secure, frictionless entry into the app.

Once authenticated, the app presents a **Role Selector screen** where you choose how you want to use the app — either as a **Delivery Partner** or as an **Admin**. Each role unlocks a completely different interface tailored to that user's needs.

---

## [SECTION 3: PARTNER ONBOARDING — 2:30 to 3:45]

New delivery partners go through a structured, four-step onboarding process before they can start accepting orders. The onboarding screen features a clear visual progress bar at the top so you always know where you are in the setup journey.

**Step 1 — Personal Details:**  
Enter your full name, email address, date of birth, and residential address. A clean form with large tap targets makes data entry fast and error-free.

**Step 2 — Document Upload:**  
Upload three key identity documents — your Aadhaar Card, PAN Card, and Driving License. Each document tile shows a real-time upload status, giving you instant confirmation that your documents have been submitted successfully.

**Step 3 — Vehicle Information:**  
Specify your vehicle type — such as a Bike — along with the vehicle registration number and model. This helps the platform match you with orders that fit your vehicle's capacity.

**Step 4 — Bank Details:**  
Enter your bank name, account number, IFSC code, and account holder name so that earnings can be deposited directly to your account.

Once all four steps are complete, you tap "Complete Setup" and you're taken straight to the partner home screen — ready to go.

---

## [SECTION 4: PARTNER HOME SCREEN — 3:45 to 5:00]

The home screen is the nerve center of a delivery partner's daily workflow. It is designed to be information-dense but never overwhelming.

At the top is a collapsible header banner showing a personalized greeting — "Hello, Amit!" — alongside a **live today's earnings counter** that updates in real time as you complete deliveries. This persistent earnings widget keeps partners motivated throughout their shift.

Below the header, the centerpiece of the home screen is the **Online / Offline Toggle**. When you switch yourself online, the card transitions from a dark grey gradient to a vibrant green gradient — a clear, full-motion visual cue that you are now active and eligible to receive orders.

The home screen also displays three live performance metrics in dedicated stat cards:
- **Orders Delivered Today** — tracks your total deliveries for the current shift
- **Today's Earnings** — shows the exact rupee amount earned so far
- **Distance Covered** — tracks total kilometers driven during the shift

At the top-right of the header, two icon buttons give you quick access to **Notifications** and **Help & Support** — always reachable with a single tap, no matter which sub-page you're on.

---

## [SECTION 5: NEW ORDER ALERTS — 5:00 to 5:45]

When a new order is available, the app displays a **full-screen overlay alert** that demands attention. A circular countdown ring animates from 30 seconds down to zero — shown with a color-coded ring that shifts from blue to red as time runs out.

The alert card displays all the information you need to make a quick decision:
- Store name and pickup address
- Customer delivery address
- Delivery distance
- Payout for this order

You can **Accept** or **Reject** the order directly from this overlay. If the timer expires without a response, the order is automatically released. This ensures that merchants are never left waiting for a confirmation.

---

## [SECTION 6: ACTIVE ORDER SCREEN — 5:45 to 6:45]

Once an order is accepted, you're taken to the Active Order screen — the operational hub for in-progress deliveries.

A **5-step visual tracker** at the top shows your delivery journey in real time:
1. Assigned
2. Reached Store
3. Picked Up
4. En Route
5. Delivered

As you progress through each step, the tracker updates instantly, giving both you and the customer full visibility into the delivery status.

An **interactive map** — powered by Flutter Map — is embedded directly in the screen, showing the route from the store to the customer's location, including estimated distance and travel time.

Two contact buttons let you **call the store** or **call the customer** directly from within the app — no need to save numbers externally.

A full order details card shows the store name, store address, customer name, delivery address, number of items, and the payout for this delivery.

At the final delivery step, instead of a simple button, you see a **Slide to Deliver** gesture control, which prevents accidental taps. A bottom sheet then prompts you to enter the **customer's OTP** — a four-digit code provided by the customer — to confirm delivery. This adds a layer of accountability and prevents false delivery claims.

---

## [SECTION 7: ORDER HISTORY — 6:45 to 7:20]

The Order History screen gives you a complete log of every delivery you've completed. Orders are organized into three tabs:
- **Today** — deliveries from the current calendar day
- **This Week** — the last seven days of activity
- **This Month** — a full monthly view

Each order card in the list shows the order ID, store name, customer address, delivery status, payout, and timestamp. Tapping any order opens a **detailed order summary** so you have a full paper trail on demand.

---

## [SECTION 8: EARNINGS SCREEN — 7:20 to 8:00]

The Earnings screen gives delivery partners complete financial transparency. A large animated counter at the top displays today's total earnings, with secondary stats for **This Week** and **This Month** visible at a glance.

Three tabs break down your financial picture further:

- **Breakdown** — An itemized list of each earning entry, showing the amount, source, and timestamp for every rupee credited.
- **Incentives** — A list of active incentive plans, such as bonuses for completing a target number of deliveries in a day or week, with live progress indicators.
- **Transactions** — A full transaction history of all wallet credits, withdrawals, and adjustments.

The available wallet balance is also prominently displayed, so you always know exactly how much is ready to be withdrawn.

---

## [SECTION 9: PROFILE SCREEN — 8:00 to 8:35]

The Profile screen is your personal control panel. A header card shows your photo, name, phone number, and three career stats at a glance — **total orders completed**, **average customer rating**, and **total lifetime earnings**.

Below the header, the screen is organized into clearly labeled information sections:

- **Personal Details** — name, email, date of birth, and address
- **Vehicle Info** — vehicle type, registration number, and model
- **Documents** — verification status of Aadhaar, PAN, and Driving License
- **Bank Details** — bank name and masked account number for security

An inline **Edit / Save toggle** in the app bar lets you switch into edit mode to update any of your details without navigating away from the page.

Quick-access menu items link directly to Onboarding, Notifications, and Support. A **secure logout** button at the bottom signs you out and clears all local session data.

---

## [SECTION 10: NOTIFICATIONS & SUPPORT — 8:35 to 9:15]

**Notifications Screen:**  
All system messages — such as order assignments, earning credits, incentive unlocks, and account updates — appear in a chronological notifications list. Unread notifications are highlighted with a colored accent dot. Each notification card shows the title, a descriptive message, and a relative timestamp such as "2 hours ago" or "Yesterday." Notification types use distinct icons and colors to let you triage them at a glance.

**Help & Support Screen:**  
The support screen is organized into three tabs:

- **FAQs** — A curated list of frequently asked questions covering order issues, payment queries, and account management — searchable and always accessible offline.
- **Raise a Ticket** — Submit a formal support request with a subject and description. Tickets are tracked with a reference ID so you can follow up with the support team.
- **Live Chat** — A direct messaging interface to connect with a support agent in real time for urgent issues.

---

## [SECTION 11: ADMIN PANEL — 9:15 to 9:45]

For business operators and fleet managers, the app includes a dedicated **Admin Panel** — accessible via the Role Selector at login. The admin dashboard provides a bird's-eye view of all partner activity, active deliveries, and operational metrics.

Admins can monitor partner statuses — who is online, who has an active order, and who is offline — and drill into any partner's profile or delivery history. The panel supports the complete operational oversight needed to run a delivery fleet efficiently.

---

## [OUTRO — 9:45 to 10:00]

That covers every feature of the Delivery Partner App — from first login to final payout.

This product was designed, engineered, and delivered by **QuickPrepAI**. Our mission is to build software that works as hard as the people who use it. If you'd like a live demo, a custom deployment, or want to discuss how this platform can be tailored to your business — reach out to the QuickPrepAI team today.

Thank you for listening.

---

*End of Script — Total Duration: ~10 minutes*
