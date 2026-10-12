# All Style Zone Sales Manager — GitHub Pages Edition

A browser-based sales manager for watches, customers, sales/orders, and follow-ups. The frontend is static and can be hosted on GitHub Pages. Supabase provides authentication and PostgreSQL storage, so records sync between devices after you sign into the same account.

## Important architecture note

GitHub Pages only hosts static files; it does not run Python/Flask. This edition is plain HTML, CSS, and JavaScript, with Supabase Auth + PostgreSQL as the backend. The Supabase **publishable/anon** key is intended for frontend use only when Row Level Security (RLS) is correctly enabled. **Never put a Supabase service-role/secret key in `app.js`, GitHub, or any browser code.**

## Setup

1. Create a Supabase project at https://supabase.com/.
2. In Supabase, open **SQL Editor**, create a query, paste the complete contents of `supabase-schema.sql`, and run it.
3. In Supabase **Project Settings / API** (labels can vary), copy the project URL and the publishable key (or legacy anon public key). Do not copy a service-role/secret key.
4. Edit `app.js` and replace:
   - `PASTE_YOUR_SUPABASE_PROJECT_URL_HERE`
   - `PASTE_YOUR_SUPABASE_ANON_OR_PUBLISHABLE_KEY_HERE`
5. In Supabase Authentication settings, set your site URL to your GitHub Pages URL after you create the repository, e.g. `https://YOUR-USERNAME.github.io/all-style-zone-sales-manager/`. Add the same URL to allowed redirect URLs if needed. Configure email confirmation as you prefer; for a real account, leaving confirmation enabled is safer.
6. Create a GitHub repository named `all-style-zone-sales-manager`. Upload `index.html`, `styles.css`, `app.js`, `supabase-schema.sql`, `.nojekyll`, and `README.md` to the repository root.
7. Open **Settings → Pages** in GitHub. Under Build and deployment, choose **Deploy from a branch**, select `main` and `/(root)`, then save.
8. Wait for the Pages deployment and open the URL. Create an account, confirm your email if prompted, and sign in.

## Data and privacy

- Products, customers, orders, and follow-ups are stored in Supabase PostgreSQL, not in GitHub or the browser's local storage.
- RLS policies in `supabase-schema.sql` scope every row to the signed-in user's `auth.uid()`.
- Keep customer information private. Use a private GitHub repository if you do not want to publish the source; the website URL itself can still be public when Pages settings allow it.
- Do not commit customer spreadsheets, exports, `.env` files, database dumps, passwords, or service-role keys.
- Set up backups and test restoring them before using this for important business records.
- A public sign-up flow is included. Every account sees only its own rows. If you want only one authorized account, disable public signups in Supabase Auth after creating your account.

## Current functionality

- Email/password sign-up and sign-in, sign-out
- Dashboard counts and estimated order profit
- Products: name, SKU, cost, sale price, stock, notes
- Customers: contact information, address, notes
- Orders: date, customer/product names, quantity, price/cost, shipping, payment/order status, tracking, notes
- Follow-ups: customer, due date, topic, status, notes
- Add, edit, delete, and search records
- Responsive layout for desktop and mobile

## Known limitations

- This is a first web edition, not a complete accounting/ERP system. Order records currently store customer/product names and price snapshots as entered; they do not automatically decrement inventory, prevent overselling, or enforce links to product/customer records. Review the totals and test with sample data before using for live operations.
- Profit is estimated as `(unit price × quantity) − (unit cost × quantity) − shipping` and excludes any other costs, refunds, or taxes not entered.
- The app has not been independently security-audited. Use strong passwords, enable email confirmation, restrict sign-up if this is a single-user tool, keep Supabase updated, and maintain backups.

## Local preview

Because this uses browser JavaScript and Supabase, it does not require Python. After configuring `app.js`, you can open `index.html` for a quick test, or serve the folder locally with any static web server. For production, use the GitHub Pages URL configured in Supabase Auth.
