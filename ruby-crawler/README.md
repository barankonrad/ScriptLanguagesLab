# Amazon Crawler

Web scraper using Ruby for Amazon product data extraction and MongoDB for data storage.

## Features

- **Search Products**: Scrapes product names, prices, links, and descriptions based on a specified
  keyword.
- **Data Storage**: Saves extracted data in a MongoDB database for future use.
- **Real User Emulation**: Uses user-agent strings to mimic browser behavior for seamless scraping.
- **Sleep Interval**: A delay is added between requests to prevent Amazon from blocking the scraper.

## Project structure

- **main.rb**: Main script responsible for crawling Amazon and inserting data into MongoDB.
- **docker-compose.yml**: Sets up the MongoDB instance for local use.
- **requirements**: Ruby libraries required for the project (`nokogiri`, `open-uri`, `mongo`).

## How to run

1. Install required Ruby libraries:
   ```bash
   gem install nokogiri mongo
   ```
2. Set up MongoDB using Docker:
   ```bash
    docker-compose up -d
   ```
3. Run the crawler:
    ```bash
    ruby main.rb
    ```

## Example
Database objects found for keyword `rower`

```json
[
  {
    "_id": {
      "$oid": "6766e095b4e89f2ce056826c"
    },
    "name": "Bodywel A275 ebike Rower Elektryczny Miejski 27.5'' z Wyjmowanym Akumulatorem 36V 15.6Ah, Wyświetlacz LED 4.5 cala, Maksymalny Zasięg 100km, Hamulce Tarczowe, Rower Elektryczny Górski dla Dorosłych",
    "price": "3 299,99 zł",
    "link": "https://amazon.pl/sspa/click?ie=UTF8&spc=MTozNjgyNjE5OTUyMjEwMDA5OjE3MzQ3OTUzOTU6c3BfYXRmOjMwMDMyODY5NDA5NTAzMjo6MDo6&url=%2FBodywel-A275-Elektryczny-Akumulatorem-Wy%25C5%259Bwietlacz%2Fdp%2FB0CNKG651K%2Fref%3Dsr_1_3_sspa%3Fdib%3DeyJ2IjoiMSJ9.1TVghSVPBIv524RTdOtnLEQj1dTynGigxhwQ2y4wqmYiawt8orMXsUcrMy5ijGAn_G85vM19jsI8pMx9BLM0bTcO_jiAOBlIIuUJFK4sae-aa2mxkNeO6Sa8BBbes9XgEORiyB66VvdPs0MBW5guzy8rIENn76GztYgnnxPJEvPryJtxetfDTHiBBhO4y-maMbH8Bt-8nE-Qj0_d2xM-th_ffbsPLSee9DbdlTZydmLh9hyFpbwyBLXSCPJHrAji-sfxTeyDN1RwuhQd-iuv4iodMIFDM_NkOjtr3Pr8G2E.DjdL3G-dzrb2jK-d0QSaIWNoS7zuHoWSdN6QGViE2vQ%26dib_tag%3Dse%26keywords%3Drower%26qid%3D1734795395%26sr%3D8-3-spons%26sp_csd%3Dd2lkZ2V0TmFtZT1zcF9hdGY%26psc%3D1"
  },
  {
    "_id": {
      "$oid": "6766e099b4e89f2ce056826d"
    },
    "name": "GUNAI-M2 Dual Motor Electric Bike z akumulatorem 48V17.5AH, 7-biegowy rower z pełnym zawieszeniem Fat Tire",
    "price": "7 099,00 zł",
    "link": "https://amazon.pl/sspa/click?ie=UTF8&spc=MTozNjgyNjE5OTUyMjEwMDA5OjE3MzQ3OTUzOTU6c3BfYXRmOjMwMDM2NDg5OTQ1MDAzMjo6MDo6&url=%2FGUNAI-M2-akumulatorem-48V17-5AH-7-biegowy-zawieszeniem%2Fdp%2FB0D17G5916%2Fref%3Dsr_1_4_sspa%3Fdib%3DeyJ2IjoiMSJ9.1TVghSVPBIv524RTdOtnLEQj1dTynGigxhwQ2y4wqmYiawt8orMXsUcrMy5ijGAn_G85vM19jsI8pMx9BLM0bTcO_jiAOBlIIuUJFK4sae-aa2mxkNeO6Sa8BBbes9XgEORiyB66VvdPs0MBW5guzy8rIENn76GztYgnnxPJEvPryJtxetfDTHiBBhO4y-maMbH8Bt-8nE-Qj0_d2xM-th_ffbsPLSee9DbdlTZydmLh9hyFpbwyBLXSCPJHrAji-sfxTeyDN1RwuhQd-iuv4iodMIFDM_NkOjtr3Pr8G2E.DjdL3G-dzrb2jK-d0QSaIWNoS7zuHoWSdN6QGViE2vQ%26dib_tag%3Dse%26keywords%3Drower%26qid%3D1734795395%26sr%3D8-4-spons%26sp_csd%3Dd2lkZ2V0TmFtZT1zcF9hdGY%26psc%3D1",
    "description": "Model: GUNAI-M2Wyświetlacz licznika: YL81FMateriał ramy: AL6061Akumulator: 48 V, 17,5 Ah, akumulator, 840 WhCzas ładowania: 6– godzinyMoc silnika: Podwójny silnik z przodu i z tyłuMoment obrotowy: 130N.MPoziom prędkości: 5Mechaniczna zmiana biegów: 7 biegówTryby jazdy: Jazda na rowerze przez człowieka /wspomagane Do użytku podczas jazdy na rowerze/jazdy wyłącznie na napędzie elektrycznymOpona: 26x4,0 ChaoyangHamulec: hamulec olejowyAmortyzator: amortyzatory przednie i tylneZdolność pokonywania wzniesień: 30°Przebieg czystej energii elektrycznej: 45 kmPrzebieg pomocy: 55kmMaksymalne obciążenie: 150 kgOdpowiednia wysokość: 165-195 cmPoziom wodoodporności: IP5 Masa netto roweru: 41 kgWaga akumulatora: 4,8 kgMasa brutto: 50 kgRozmiar produktu: 210*72*120cmWielkość opakowania: 170*30*83cmp>"
  },
  {
    "_id": {
      "$oid": "6766e09cb4e89f2ce056826e"
    },
    "name": "LABGREY Rower treningowy, rower stacjonarny z czujnikiem tętna i wygodną poduszką do siedzenia, cichy rower fitness do domu, treningu cardio",
    "price": "1 244,15 zł",
    "link": "https://amazon.pl/treningowy-magnetyczny-stacjonarny-czujnikiem-siedzenia/dp/B0CCYWBDDV/ref=sr_1_5?dib=eyJ2IjoiMSJ9.1TVghSVPBIv524RTdOtnLEQj1dTynGigxhwQ2y4wqmYiawt8orMXsUcrMy5ijGAn_G85vM19jsI8pMx9BLM0bTcO_jiAOBlIIuUJFK4sae-aa2mxkNeO6Sa8BBbes9XgEORiyB66VvdPs0MBW5guzy8rIENn76GztYgnnxPJEvPryJtxetfDTHiBBhO4y-maMbH8Bt-8nE-Qj0_d2xM-th_ffbsPLSee9DbdlTZydmLh9hyFpbwyBLXSCPJHrAji-sfxTeyDN1RwuhQd-iuv4iodMIFDM_NkOjtr3Pr8G2E.DjdL3G-dzrb2jK-d0QSaIWNoS7zuHoWSdN6QGViE2vQ&dib_tag=se&keywords=rower&qid=1734795395&sr=8-5",
    "description": "LABGREY Rower treningowy, rower treningowy, wewnętrzny rower treningowy z ekranem LCD, cichy do domowego treningu cardio, regulowana kierownica i siedzisko [Heavy Duty Indoor Exercise Bike]: Wykonany z komercyjnej stali, ten rower fitness ma solidną konstrukcję, która może wspierać użytkowników o wadze do 136 kg. Cztery poziome pokrętła regulacji z przodu i z tyłu zapewniają wyjątkową stabilność na różnych powierzchniach. [Magnetycznie sterowany rower treningowy]: Potężny magnetyczny system oporu zapewnia płynną i precyzyjną kontrolę oporu, co umożliwia bezproblemowe dostosowanie programu treningowego. Niezależnie od tego, czy jesteś początkującym, czy profesjonalnym sportowcem, łatwo jest osiągnąć spersonalizowaną intensywność ćwiczeń, naśladując górzysty lub płaski teren. [Inteligentne śledzenie fitnessu]: Nowy cyfrowy monitor ciekłokrystaliczny skrupulatnie wyświetla dane dotyczące ćwiczeń, w tym czas trwania, prędkość, dystans, całkowity przebieg (licznik kilometrów), tętno i szacowanie ilości spalonych kalorii. Czujnik tętna umieszczony na kierownicy monitoruje tętno i dostarcza szczegółowych danych na temat stanu fizycznego. [Cichy rower stacjonarny]: Dzięki konstrukcji magnetycznego systemu oporu rower fitness obraca się cicho, dzięki czemu nie przeszkadza członkom rodziny ani sąsiadom, co pozwala cieszyć się spokojnym treningiem w dowolnym momencie. Ponadto system hamowania awaryjnego zwiększa bezpieczeństwo, umożliwiając bezpieczne zatrzymanie przez cały czas."
  }
]
```