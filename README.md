<h1>INLÄMNING 2 – William Minnert – YH2025 – Bokhandel</h1>

<p>
Detta projekt innehåller en relationsdatabas för en bokhandel med fokus på dataintegritet och struktur.
</p>

<h2>Tabeller</h2>
<ul>
  <li>Kund</li>
  <li>Bok</li>
  <li>Beställning</li>
  <li>Orderrad</li>
  <li>Kundlogg</li>
</ul>

<h2>Syfte</h2>
<p>
Databasen lagrar information om kunder, böcker, beställningar samt vilka böcker och antal som ingår i varje beställning.
Kundlogg används för att logga nya kunder.
</p>

<h2>Relationer</h2>
<ul>
  <li>Kund (1) – (N) Beställning</li>
  <li>Beställning (1) – (N) Orderrad</li>
  <li>Bok (1) – (N) Orderrad</li>
</ul>

<p>
Orderrad fungerar som en kopplingstabell som löser en många-till-många-relation mellan Beställning och Bok.
</p>

<h2>Designval</h2>
<ul>
  <li><strong>Primärnycklar:</strong> AUTO_INCREMENT används för unika ID:n.</li>
  <li><strong>ISBN:</strong> VARCHAR(20) då det är ett identifierande värde och kan innehålla bindestreck.</li>
  <li><strong>RadPris:</strong> sparas i orderrad för att behålla historiskt pris.</li>
  <li><strong>Constraints:</strong> säkerställer rimliga värden (t.ex. pris &gt; 0, lager ≥ 0).</li>
  <li><strong>Index:</strong> på Epost för snabbare sökningar.</li>
</ul>

<h2>Triggers</h2>
<ul>
  <li>Minskar lagersaldo automatiskt vid ny orderrad.</li>
  <li>Loggar nya kunder i kundlogg.</li>
</ul>

<h2>Övrigt</h2>
<p>
Projektet innehåller även exempel på SELECT, JOIN, GROUP BY och transaktioner (ROLLBACK) för att visa praktisk användning.
</p>

![ER-diagram](images/erdiagram.png)
