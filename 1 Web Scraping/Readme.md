# _Web Scraping_

Sebelum berbicara mengenai _machine learning_ dan _artificial intelligence_, sebaiknya kita membahas _data acquisition_ terlebih dahulu.

> Bagaimana membuat model kalau datanya sendiri tidak ada?

# Teknik _Web Scraping_

_Web scraping_ adalah proses pengambilan data atau informasi dari internet. Sebagaimana kita ketahui bersama, semua yang ada di internet bisa dengan mudah-nya kita ambil (tentu dengan teknik yang tepat _yah_).

Berdasarkan pengalaman saya selama ini, ada beberapa teknik _web scraping_ yang bisa dilakukan. Yakni:

1. `Parsing html` dengan cara membaca `page source` dari `.html` situs yang dituju.
    - Kelebihan:
        - Proses relatif cepat (walau tergantung koneksi juga).
        - Bisa untuk kebanyakan situs, seperti: wikipedia, portal berita, blog, dst.
    - Kelemahan:
        - Harus menentukan target `css` dari situs terlebih dahulu.
        - Untuk beberapa situs, proses mencari objek `css` bisa jadi menyulitkan.
        - Tidak bisa digunakan untuk situs dinamis yang menggunakan `javascript`.
        - Untuk situs yang menggunakan _login_, prosesnya agak rumit.
1. `Mimicking browser` dengan cara membuat bot yang seolah-olah membuka browser tertentu dan berinteraksi seperti layaknya manusia.
    - Kelebihan:
        - Bisa untuk (hampir) semua situs. Termasuk social media atau situs dengan login yang memiliki beberapa steps authetification.
        - Bisa mengambil situs dinamis atau mengandung javascript.
    - Kelemahan:
        - Proses relatif lambat. Karena bertindak seolah-olah layaknya manusia membuka browser.
        - Secara coding lebih rumit karena harus membuat dua bagian algoritma: algoritma mimick dan algoritma scraper css.
1. Mengambil data menggunakan `API`.
    - Kelebihan:
        - Lebih mudah dan relatif cepat.
    - Kelemahan:
        - Proses mendapatkan API kadang cukup rumit. Kadang didapatkan dengan cara mendaftar as developer seperti di Twitter atau mencari sendiri saat inspect network.
        - Biasanya data hasil scrape memiliki format .json yang jarang dikenal orang awam.

_Further reading:_ [ikanx101.com](https://ikanx101.com/blog/webscrape-tutorial/)
