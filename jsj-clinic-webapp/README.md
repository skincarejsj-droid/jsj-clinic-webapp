# JSJ Skin Care - Clinic Operations (hosted version)

This is a ready-to-deploy version of the clinic app: a real login screen, a real shared
database (Supabase), and live sync so every computer sees the same data instantly. It's
built with React + Vite and deploys to a normal website URL.

Total setup time: roughly 15-20 minutes, no coding required, just following the steps below.

---

## 1. Create your database (Supabase)

1. Go to https://supabase.com and sign up for a free account.
2. Click **New Project**. Pick any name (e.g. "jsj-clinic"), set a database password
   (save it somewhere safe), choose the region closest to the Philippines, and create it.
   Wait ~2 minutes for it to finish provisioning.
3. In the left sidebar, open **SQL Editor** -> **New query**.
4. Open `supabase-schema.sql` (included in this folder), copy its entire contents, paste
   it into the SQL editor, and click **Run**. This creates the table that stores all
   clinic data and turns on live sync.
5. In the left sidebar, open **Project Settings -> API**. You'll need two values from
   this page in step 3 below:
   - **Project URL**
   - **anon / public** key

## 2. Create staff logins

Still in Supabase: open **Authentication -> Users -> Add user** (top right). Create one
user per staff member who should have access (email + password). There's no public
sign-up page in this app on purpose — only people you personally create an account for
can log in. You can add or remove staff here at any time.

> Note: right now, anyone with a login can see and edit everything (sales, inventory,
> attendance, and payroll including SSS/Pag-IBIG amounts). If you'd like separate
> permission levels later (e.g. front desk can't see payroll), that's a reasonable next
> upgrade — just ask.

## 3. Connect the app to your database

1. In this project folder, copy `.env.example` to a new file named `.env`.
2. Open `.env` and paste in the Project URL and anon key from step 1.5 above:
   ```
   VITE_SUPABASE_URL=https://your-project-ref.supabase.co
   VITE_SUPABASE_ANON_KEY=your-anon-public-key
   ```

## 4. Try it locally (optional but recommended)

If you have Node.js installed (https://nodejs.org, LTS version):

```
npm install
npm run dev
```

Open the URL it prints (usually http://localhost:5173), log in with a staff account you
created in step 2, and confirm everything works.

## 5. Put it on the internet (Vercel)

1. Go to https://vercel.com and sign up (the free plan is enough for this).
2. Easiest path: install the Vercel CLI and deploy straight from this folder:
   ```
   npm install -g vercel
   vercel
   ```
   Follow the prompts (accept the defaults). When it asks about environment variables,
   or afterward in the Vercel dashboard under **Settings -> Environment Variables**, add
   the same two values from your `.env` file (`VITE_SUPABASE_URL`,
   `VITE_SUPABASE_ANON_KEY`).
3. Run `vercel --prod` to publish it live. Vercel will give you a URL like
   `jsj-clinic.vercel.app` — that's the address every clinic computer will use.

   (Alternative: connect this folder to a GitHub repo and import it in the Vercel
   dashboard for automatic deploys whenever you make changes — ask if you'd like help
   setting that up.)

## 6. Use it on every clinic computer

On each computer, open a normal browser (Chrome, Edge, etc.), go to the URL from step 5,
and log in with a staff account. All data is shared and updates live across every
computer — no more per-computer copies.

---

## If you'd rather not do this yourself

Everything above can also be done by:
- **Claude Code** — it can run the `npm`/`vercel` commands and walk through the Supabase
  dashboard steps with you interactively.
- A developer or IT-savvy staff member, using this same folder and these same steps.

## What's included

- `src/App.jsx` — the full clinic app (Sales, Medications & Supplies Inventory,
  Attendance with holiday pay/overtime/leave credits, Payroll with 13th month pay,
  Dashboard analytics)
- `src/supabaseClient.js` — connects the app to your database
- `supabase-schema.sql` — one-time database setup script
- Login screen backed by Supabase Auth; sign-out button in the sidebar

## Data backups

Supabase automatically backs up your database, but it's still good practice to use the
CSV export buttons already built into each section (Sales, Inventory, Attendance,
Payroll) periodically as an extra safety net.
