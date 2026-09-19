# Identity Lifecycle Management (JML) with Microsoft Entra ID

A hands-on lab implementing the full **Joiner-Mover-Leaver** identity lifecycle in Microsoft Entra ID, using dynamic group membership and native Lifecycle Workflows — no code, no manual access reviews.

## Why this lab

In a real organization, identity management is a lifecycle: people join, change roles, and leave, and access has to follow them automatically. This lab builds that lifecycle end to end and documents the reasoning behind each design decision, not just the clicks.

## Tech stack

- Microsoft Entra ID (Azure AD)
- Microsoft Entra ID Governance (Lifecycle Workflows, Dynamic Groups)

## Phase 1 — Design

Before touching the portal, I defined the scenario on paper. In a real environment, skipping this step is how you end up with group sprawl and rules nobody can explain later.

### The fictional company: Tech Solutions

A small technological company with three departments, enough to demonstrate dynamic rules without overengineering the lab.

| Department | Sample Role          | Location |
| ---------- | -------------------- | -------- |
| IT         | Support Engineer     | PE       |
| Sales      | Sales Representative | PE       |
| HR         | HR Coordinator       | PE       |

### Attributes used

These are the attributes that drive both the dynamic group rules and the lifecycle workflows later on:

| Attribute       | Purpose                                                                                                                           |
| --------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `department`    | Core attribute for dynamic group membership and for simulating a **Mover** (changing this value triggers automatic re-evaluation) |
| `jobTitle`      | Enables finer-grained rules later (e.g. distinguishing managers from analysts within the same department)                         |
| `usageLocation` | Required by Entra ID before a license can be assigned to a user                                                                   |
| `employeeType`  | Distinguishes employees from contractors; sets up future workflows that treat each type differently                               |

### Naming conventions

- **Users:** `firstname.lastname@domain.onmicrosoft.com`
- **Groups:** `SG-<Department>-Users` (e.g. `SG-IT-Users`); the `SG` (Security Group) prefix follows common enterprise convention, making the group's purpose identifiable at a glance.

### Test identities

| User        | Department | Job Title            | Location | Role in the lab                                 |
| ----------- | ---------- | -------------------- | -------- | ----------------------------------------------- |
| Ana Torres  | IT         | Support Engineer     | PE       | Joiner → later becomes the Mover                |
| Carlos Ruiz | Sales      | Sales Representative | PE       | Stable member of the Sales group (control case) |
| Lucía Vega  | HR         | HR Coordinator       | PE       | Leaver at the end of the lab                    |

Reusing the same identities across phases (instead of creating a new user per scenario) keeps the lab closer to how a real tenant evolves, the same person moves through the organization rather than disappearing and reappearing.

### Dynamic group rule (design)

One rule per department, evaluated automatically by Entra ID whenever a user's `department` attribute changes:

```
(user.department -eq "IT")
```

Three groups in total: `SG-IT-Users`, `SG-Sales-Users`, `SG-HR-Users`.

---

## Phase 2 — Provisioning test users

_(coming next)_

## Phase 3 — Dynamic Groups

_(coming next)_

## Phase 4 — Lifecycle Workflows: Joiner

_(coming next)_

## Phase 5 — Simulating a Mover

_(coming next)_

## Phase 6 — Leaver

_(coming next)_

## Key takeaways

_(coming next)_
