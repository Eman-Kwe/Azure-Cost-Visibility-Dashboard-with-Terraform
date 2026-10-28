# Azure-Cost-Visibility-Dashboard-with-Terraform
I built a system that watches an Azure subscription's spend, emails the owner at three budget thresholds, and shows spending in a dashboard. Everything except the Logic App steps and the dashboard is built with Terraform.
 
### 🎬 Video Walkthrough
 
[Watch the project walkthrough](VIDEO_LINK_HERE)
 
> **Pending.** The video has not been recorded yet. Replace the link above and delete this note when it is.
 
---
 
### Result at a glance
 
| | |
|---|---|
| **What I built** | A monthly budget with alerts at $50, $100 and $200, an email Action Group, a Logic App for formatted alert emails, a Log Analytics workspace, and an Azure Workbook |
| **Proof it works** | `[FILL IN: e.g. test email from the Action Group received, screenshot 08]` |
| **Cost to run** | `[FILL IN from Cost Management after teardown]` |
| **Cleanup** | `[FILL IN: terraform destroy output, resource group gone]` |
| **Tools** | Terraform, Azure Monitor, Cost Management, Logic Apps, Log Analytics, Azure Workbooks |
 
---
 
## Project Overview
 
### What this project does, in plain English
 
Think of it like a smoke detector for your cloud bill. The budget is the sensor. When spending crosses a line, the Action Group is the alarm that emails the owner, and the dashboard is where you look to see what is burning.
 
Where the analogy breaks down: a smoke detector reacts to something happening right now. Azure cost data arrives with a delay of hours, so alerts can fire after the spend has already happened.
 
### Why it matters
 
Cloud bills are full of line items like `Microsoft.Compute/virtualMachines` that a business owner cannot read or predict. The first FinOps habit is simple: know what you spend and get warned before the limit, not after.
 
### What gets built
 
| Component | Built with |
|---|---|
| Resource group `rg-cost-dashboard-<name>` | Terraform |
| Log Analytics workspace `law-cost-<name>` (30-day retention) | Terraform |
| Action Group `ag-cost-alerts-<name>` (email) | Terraform |
| Monthly budget `budget-cost-<name>`, $200, alerts at 25%, 50%, 100% | Terraform |
| Subscription activity log sent to Log Analytics | Terraform |
| Logic App `la-cost-alert-<name>` (container) | Terraform |
| Logic App steps (HTTP trigger, send email) | Portal designer |
| Cost dashboard | Azure Workbooks (portal) |
 
### Skills demonstrated
 
- Infrastructure as Code with Terraform on Azure
- Azure Cost Management budgets and alert thresholds
- Azure Monitor Action Groups and Log Analytics
- Low-code automation with Logic Apps
- Reading provider errors and fixing them (see Troubleshooting)
- `[ADD ONLY WHAT YOU ACTUALLY DID, e.g. the Cost Management Contributor role fix]`
---
 
## Project Structure
 
```text
cost-dashboard-001/
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example     # placeholders only
├── .gitignore                   # excludes terraform.tfvars, state, .terraform/
└── images/                      # evidence screenshots
```
 
---
 
## Architecture Diagram
 
`[ADD DIAGRAM: images/architecture.png]`
 
### How it works
 
1. **Budget.** A $200 monthly budget watches the subscription's actual spend.
2. **Alert.** At 25% ($50), 50% ($100) and 100% ($200), the budget fires a notification.
3. **Notify.** The Action Group emails the owner.
4. **Format.** The Logic App receives the alert and sends a readable email. `[CONFIRM after you wire the webhook in Step 6]`
5. **Log.** The subscription activity log flows into Log Analytics so you can query who changed what.
6. **See.** An Azure Workbook shows the data in the portal.
### Key terms
 
| Term | What it means |
|---|---|
| **Budget** | A spending limit with alert thresholds, set in Cost Management |
| **Action Group** | A reusable list of who or what gets notified when an alert fires |
| **Log Analytics** | Azure's central place to store and query logs |
| **Logic App** | Low-code workflow: when X happens, do Y |
| **Azure Workbook** | A reporting page inside Azure Monitor |
| **FinOps** | Managing cloud spend as an ongoing practice |
 
---
 
## Prerequisites
 
| Requirement | Version used |
|---|---|
| Azure subscription (active, Owner or Contributor) | `[FILL IN]` |
| Terraform | `[FILL IN: terraform --version]` |
| Azure CLI | `[FILL IN: az --version]` |
| An email address for alerts | any |
 
**Time and cost:** about `[FILL IN]` hours. Cost: `[FILL IN]`.
 
---
 
## Naming Conventions Used
 
| Item | Name |
|---|---|
| Resource group | `rg-cost-dashboard-<name>` |
| Log Analytics | `law-cost-<name>` |
| Action Group | `ag-cost-alerts-<name>` |
| Budget | `budget-cost-<name>` |
| Logic App | `la-cost-alert-<name>` |
 
---
 
## Project Steps
 
Screenshot notes are marked.
 
### Step 1: Create the folder and variables.tf
Four variables: `yourname`, `location` (East US), `alert_email`, and `tags`.
 
### Step 2: terraform.tfvars
Values for the three required variables. This file stays out of Git. `terraform.tfvars.example` is committed with placeholders.
 
### Step 3: main.tf
Resource group, Log Analytics workspace, Action Group, subscription budget with three notifications, Logic App, and the diagnostic setting. **Change the budget `start_date` to the first day of the current month** (the course file ships with `2026-03-01`).
 
### Step 4: outputs.tf
 
### Step 5: Deploy
```bash
terraform init
terraform plan
terraform apply
```
`[SCREENSHOT: apply complete]`
 
### Step 6: Configure the Logic App
Build the HTTP trigger and Send email action in the portal designer, then connect the Action Group webhook with `az monitor action-group update`. The email step needs an interactive sign-in, so Terraform cannot do it. `[NOTE: say which email connection you used]`
`[SCREENSHOT: designer]`
 
### Step 7: Build the dashboard
Create a Workbook in Azure Monitor and add queries. `[LIST what the dashboard actually shows. The course file's example query lists resource groups only, so add a Cost Management view if you want spend by service.]`
`[SCREENSHOT: workbook]`
 
### Step 8: Test the alert
Budgets only fire on real spend, so trigger a test notification from the Action Group in the portal and confirm the email arrives.
`[SCREENSHOT: test email, with your address blurred]`
 
### Step 9: Tear everything down
```bash
terraform destroy
```
`[SCREENSHOT: destroy complete]` Then confirm the resource group is gone in the portal.
 
---
 
## Results
 
| Check | Result |
|---|---|
| Resource group created | `[ ]` |
| Budget visible in Cost Management → Budgets | `[ ]` |
| Action Group exists | `[ ]` |
| Logic App Enabled, trigger and email action in designer | `[ ]` |
| Log Analytics workspace exists | `[ ]` |
| Workbook saved | `[ ]` |
| Test notification received | `[ ]` |
| Teardown verified | `[ ]` |
 
Fill each row with what you saw. Leave a row as "not done" if it is not.
 
---
 
## Security Decisions
 
- **Secrets and state out of Git.** `terraform.tfvars` and state files are in `.gitignore`.
- **No subscription IDs or emails in screenshots.** Blur them.
- **Least privilege.** `[FILL IN: which role you used; the budget needs Cost Management Contributor if you hit AuthorizationFailed]`
- **Short retention.** Log data is kept 30 days to limit cost and exposure.
- **Teardown the same day.**
---
 
## Troubleshooting / Common Issues
 
Keep only the rows you actually hit. From the course file, these are the likely ones:
 
| Issue | Cause | Fix |
|---|---|---|
| `BudgetStartDateInvalid` | Start date must be the first of the current or a future month | Update `start_date` |
| `AuthorizationFailed` on the budget | Missing Cost Management role | Assign Cost Management Contributor |
| Logic App email step asks for sign-in | Office 365 connection needs interactive auth | Sign in through the designer |
| Alert email not received | Budget thresholds need real spend to cross | Send a test notification from the Action Group |
| `[ADD YOURS]` | | |
 
---
 
## Key Takeaways
 
- Know your spend before you optimize it.
- Alerts need a test path. A budget alert may not fire for days, so test the notification channel directly.
- Cost data is delayed, so alerts are early warnings, not real-time controls.
- `[ADD ONE LESSON FROM YOUR OWN BUILD]`
---
 
## Reference
 
- [Azure Cost Management budgets](https://learn.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets)
- [Azure Monitor Action Groups](https://learn.microsoft.com/azure/azure-monitor/alerts/action-groups)
- [Terraform azurerm provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
---
 
**Author:** Manuel Yannick Armah
 
**Project:** Azure Cost Visibility Dashboard with Terraform
 
**Difficulty:** Beginner
 
**Time to Complete:** 3 - 4 hours
 
