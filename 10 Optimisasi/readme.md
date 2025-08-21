# OPTIMISASI DALAM INDUSTRI


- [SEJARAH](#sejarah)
  - [Optimisasi](#optimisasi)
  - [Riset Operasi](#riset-operasi)
- [OPTIMISASI](#optimisasi-1)
  - [Bahasan dalam Optimisasi](#bahasan-dalam-optimisasi)
  - [Masalah Optimisasi](#masalah-optimisasi)
  - [Jenis-Jenis Masalah Optimisasi](#jenis-jenis-masalah-optimisasi)
- [JENIS OPTIMISASI](#jenis-optimisasi)
  - [*Linear Programming*](#linear-programming)
    - [Contoh Masalah *Linear
      Programming*](#contoh-masalah-linear-programming)
  - [*Integer Programming*](#integer-programming)
    - [Contoh *Integer Programming*](#contoh-integer-programming)
      - [Jadwal Kebutuhan Tenaga
        Kesehatan](#jadwal-kebutuhan-tenaga-kesehatan)
  - [*Binary Programming*](#binary-programming)
    - [Contoh *Binary Programming*](#contoh-binary-programming)
      - [Jadwal Tatap Muka Terbatas
        Sekolah](#jadwal-tatap-muka-terbatas-sekolah)
  - [*Mixed Integer Linear
    Programming*](#mixed-integer-linear-programming)
    - [Menyelesaikan *MILP*](#menyelesaikan-milp)
    - [Contoh *MILP*](#contoh-milp)
      - [Pemilihan dan Penentuan Item
        Produksi](#pemilihan-dan-penentuan-item-produksi)
- [ALGORITMA PENYELESAIAN
  OPTIMISASI](#algoritma-penyelesaian-optimisasi)
  - [*Exact Method*](#exact-method)
  - [*Approximate Method*](#approximate-method)

# SEJARAH

## Optimisasi

Optimisasi adalah **proses mencari nilai yang optimal** dari suatu
masalah tertentu. Dalam matematika, optimisasi merujuk pada pencarian
nilai minimal atau maksimal dari suatu *fungsi real*[^1]. Notasi
matematikanya dapat ditulis sebagai berikut:

Misalkan suatu fungsi ![f](https://latex.codecogs.com/svg.latex?f "f")
yang memetakan dari himpunan
![A](https://latex.codecogs.com/svg.latex?A "A") ke bilangan *real*.

![f: A \rightarrow \mathbb{R}](https://latex.codecogs.com/svg.latex?f%3A%20A%20%5Crightarrow%20%5Cmathbb%7BR%7D "f: A \rightarrow \mathbb{R}")

Cari suatu nilai
![x_0 \in A](https://latex.codecogs.com/svg.latex?x_0%20%5Cin%20A "x_0 \in A")
sedemikian sehingga:

- ![f(x_0) \leq f(x), \forall x \in A](https://latex.codecogs.com/svg.latex?f%28x_0%29%20%5Cleq%20f%28x%29%2C%20%5Cforall%20x%20%5Cin%20A "f(x_0) \leq f(x), \forall x \in A")
  untuk proses **minimalisasi**.
- ![f(x_0) \geq f(x), \forall x \in A](https://latex.codecogs.com/svg.latex?f%28x_0%29%20%5Cgeq%20f%28x%29%2C%20%5Cforall%20x%20%5Cin%20A "f(x_0) \geq f(x), \forall x \in A")
  untuk proses **maksimalisasi**.

Di dalam kalkulus, kita mengetahui salah satu pendekatan optimisasi di
fungsi satu variabel bisa didapatkan dari turunan pertama yang bernilai
**nol** (bisa berupa nilai maksimum atau minimum dari fungsi tersebut).

Nilai
![x_0 \in \[a,b\]](https://latex.codecogs.com/svg.latex?x_0%20%5Cin%20%5Ba%2Cb%5D "x_0 \in [a,b]")
disebut minimum atau maksimum di
![f](https://latex.codecogs.com/svg.latex?f "f") unimodal saat memenuhi:

![\frac{d}{dx}f(x_0) = 0](https://latex.codecogs.com/svg.latex?%5Cfrac%7Bd%7D%7Bdx%7Df%28x_0%29%20%3D%200 "\frac{d}{dx}f(x_0) = 0")

**Pierre De Fermat** dan **Joseph-Louis Lagrange** adalah orang-orang
yang pertama kali menemukan formula kalkulus untuk mencari nilai
optimal. Sementara **Isaac Newton** dan **Johann C. F.Gauss**
mengusulkan metode iteratif untuk mencari nilai optimal[^2].

Salah satu bentuk optimisasi yakni *linear programming* dimulai oleh
**Leonid Kantorovich** pada 1939. **Metode Simplex** merupakan salah
satu metode penyelesaian optimisasi yang terkenal, pertama kali
diperkenalkan pada 1947 oleh **George Dantzig** sementara di tahun yang
sama *Theory of Duality* diperkenalkan oleh **John von Neumann**.

## Riset Operasi

**Riset operasi** adalah metode antar disiplin ilmu yang digunakan untuk
menganalisa masalah nyata dan membuat keputusan untuk kegiatan
operasional organisasi atau perusahaan[^3].

Riset operasi dimulai pada era Perang Dunia II. Oleh karena peperangan,
diperlukan suatu cara yang efektif untuk mengalokasikan *resources* yang
ada sehingga pihak militer Inggris dan Amerika Serikat mengumpulkan
ilmuwan-ilmuwan untuk mencari pendekatan yang saintifik dalam memecahkan
masalah.

Pada tahun 1940, sekelompok *researchers* yang dipimpin oleh **PMS
Blackett** dari ***the University of Manchester*** melakukan studi
tentang **Sistem Radar Baru Anti Pesawat Terbang**. Kelompok
*researchers* ini sering dijuluki sebagai **Kelompok Sirkus Blackett**
(*Blackett’s circus*). Julukan ini terjadi karena keberagaman latar
belakang disiplin ilmu para *researchers* tersebut. Mereka terdiri dari
disiplin ilmu fisiologi, matematika, astronomi, tentara, surveyor, dan
fisika. Pada 1941, kelompok ini terlibat dalam penelitian radar deteksi
kapal selam dan pesawat terbang. *Blackett* kemudian memimpin *Naval
Operational Research* pada Angkatan Laut Kerajaan Inggris Raya.
Prinsip-prinsip ilmiah yang digunakan untuk mengambil keputusan dalam
suatu operasi dinamai sebagai **Riset Operasi**.

Saat Amerika Serikat mulai terlibat pada Perang Dunia II, prinsip riset
operasi juga digunakan untuk berbagai operasi militer mereka. Kelompok
riset operasi AS bertugas untuk menganalisis serangan udara dan laut
tentara NAZI Jerman.

Selepas Perang Dunia II, penerapan riset operasi dinilai bisa diperluas
ke dunia ekonomi, bisnis,*engineering*, dan sosial. Riset operasi banyak
berkaitan dengan berbagai disiplin ilmu seperti matematika, statistika,
*computer science*, dan lainnya. Tidak jarang beberapa pihak menganggap
riset operasi itu *overlapping* dengan disiplin-disiplin ilmu tersebut.

Oleh karena tujuan utama dari aplikasi riset operasi adalah tercapainya
**hasil yang optimal** dari semua kemungkinan perencanaan yang dibuat.
Maka **pemodelan matematika dan optimisasi** bisa dikatakan sebagai
disiplin utama dari riset operasi.

# OPTIMISASI

## Bahasan dalam Optimisasi

Bahasan dalam optimisasi dapat dikategorikan menjadi:

- Pemodelan masalah nyata menjadi masalah optimisasi.
- Pembahasan karakteristik dari masalah optimisasi dan keberadaan solusi
  dari masalah optimisasi tersebut.
- Pengembangan dan penggunaan algoritma serta analisis numerik untuk
  mencari solusi dari masalah tersebut.

## Masalah Optimisasi

**Masalah optimisasi** adalah masalah matematika yang mewakili masalah
nyata (*real*). Dari ekspresi matematika tersebut, ada beberapa hal yang
perlu diketahui[^4], yakni:

1.  **Variabel** adalah suatu simbol yang memiliki banyak nilai dan
    nilainya ingin kita ketahui. Setiap nilai yang mungkin dari suatu
    variabel muncul akibat suatu kondisi tertentu di sistem.
2.  **Parameter** di suatu model matematika adalah suatu konstanta yang
    menggambarkan suatu karakteristik dari sistem yang sedang diteliti.
    Parameter bersifat *fixed* atau *given*.
3.  ***Constraints*** (atau kendala) adalah kondisi atau batasan yang
    harus dipenuhi. Kendala-kendala ini dapat dituliskan menjadi suatu
    persamaan atau pertaksamaan. Suatu masalah optimisasi dapat memiliki
    hanya satu kendala atau banyak kendala.
4.  ***Objective function*** adalah satu fungsi (pemetaan dari
    variabel-varibel keputusan ke suatu nilai di daerah *feasible*) yang
    nilainya akan kita minimumkan atau kita maksimumkan.

Ekspresi matematika dari model optimisasi adalah sebagai berikut:

> Cari ![x](https://latex.codecogs.com/svg.latex?x "x") yang
> meminimumkan
> ![f(x)](https://latex.codecogs.com/svg.latex?f%28x%29 "f(x)") dengan
> kendala
> ![g(x) = 0, h(x) \leq 0](https://latex.codecogs.com/svg.latex?g%28x%29%20%3D%200%2C%20h%28x%29%20%5Cleq%200 "g(x) = 0, h(x) \leq 0")
> dan
> ![x \in D](https://latex.codecogs.com/svg.latex?x%20%5Cin%20D "x \in D").

Dari ekspresi tersebut, kita bisa membagi-bagi masalah optimisasi
tergantung dari:

1.  Tipe variabel yang terlibat.
2.  Jenis fungsi yang ada (baik *objective function* ataupun
    *constraints*).

## Jenis-Jenis Masalah Optimisasi

Masalah optimisasi bisa dibagi dua menjadi dua kategori berdasarkan tipe
*variables* yang terlibat[^5], yakni:

<img src="resource_1.png" data-fig-align="center" width="650" />

1.  *Discrete Optimization*: merupakan masalah optimisasi di mana
    variabel yang terkait merupakan variabel diskrit, seperti *binary*
    atau *integer* (bilangan bulat). Namun pada masalah optimisasi
    berbentuk *mixed integer linear programming*, dimungkinkan suatu
    masalah optimisasi memiliki berbagai jeni variabel yang terlibat
    (integer dan kontinu sekaligus).
2.  *Continuous Optimization*: merupakan masalah optimisasi di mana
    variabel yang terkait merupakan variabel kontinu (bilangan *real*).
    Pada masalah optimisasi jenis ini, fungsi-fungsi yang terlibat bisa
    diferensiabel atau tidak. Konsekuensinya adalah pada metode
    penyelesaiannya.

Selain itu, kita juga bisa membagi masalah optimisasi berdasarkan
**kepastian nilai** ***variable*** **dan parameter** yang dihadapi
sebagai berikut:

<img src="resource_2.png" data-fig-align="center" width="650" />

1.  *Optimization under uncertainty*[^6]; Pada beberapa kasus di dunia
    *real*, data dari masalah tidak dapat diketahui secara akurat karena
    berbagai alasan. Hal ini mungkin terjadi akibat:
    - Kesalahan dalam pengukuran, atau
    - Data melibatkan sesuatu di masa depan yang belum terjadi atau
      tidak pasti. Contoh: *demand* produk, harga barang, dan
      sebagainya.
2.  *Deterministic optimization*;
    - Model deterministik adalah model matematika di mana nilai dari
      semua parameter dan variabel yang terkandung di dalam model
      merupakan satu nilai pasti[^7].
    - Pendekatan deterministik memanfaatkan sifat analitik masalah untuk
      menghasilkan barisan titik yang konvergen ke solusi optimal.
    - Semua algoritma perhitungan mengikuti pendekatan matematis yang
      ketat.

# JENIS OPTIMISASI

## *Linear Programming*

*Linear programming* adalah bentuk metode optimisasi sederhana yang
memanfaatkan relasi linear (semua fungsi dan *constraints* merupakan
fungsi linear).

### Contoh Masalah *Linear Programming*

Saya memiliki area parkir seluas 1.960
![m^2](https://latex.codecogs.com/svg.latex?m%5E2 "m^2"). Luas rata-rata
untuk mobil berukuran kecil adalah 4
![m^2](https://latex.codecogs.com/svg.latex?m%5E2 "m^2") dan mobil besar
adalah 20 ![m^2](https://latex.codecogs.com/svg.latex?m%5E2 "m^2"). Daya
tampung maksimum hanya 250 kendaraan, biaya parkir mobil kecil adalah Rp
7.000 per jam dan mobil besar adalah Rp 12.000 per jam. Jika dalam 1 jam
area parkir saya terisi penuh dan tidak ada kendaraan yang pergi dan
datang, maka berapa pendapatan maksimum yang bisa saya dapatkan dari
tempat parkir itu?

Dari kasus di atas kita bisa tuliskan model matematikanya sebagai
berikut:

Misal ![x_1](https://latex.codecogs.com/svg.latex?x_1 "x_1") adalah
mobil kecil dan ![x_2](https://latex.codecogs.com/svg.latex?x_2 "x_2")
adalah mobil besar.

![max(7000x_1 + 12000x_2)](https://latex.codecogs.com/svg.latex?max%287000x_1%20%2B%2012000x_2%29 "max(7000x_1 + 12000x_2)")

Dengan *constraints*:

![4 x_1 + 20 x_2 \leq 1960](https://latex.codecogs.com/svg.latex?4%20x_1%20%2B%2020%20x_2%20%5Cleq%201960 "4 x_1 + 20 x_2 \leq 1960")

dan

![x_1 + x_2 \leq 250](https://latex.codecogs.com/svg.latex?x_1%20%2B%20x_2%20%5Cleq%20250 "x_1 + x_2 \leq 250")

serta
![x_1 \geq 0, x_2 \geq 0](https://latex.codecogs.com/svg.latex?x_1%20%5Cgeq%200%2C%20x_2%20%5Cgeq%200 "x_1 \geq 0, x_2 \geq 0").

## *Integer Programming*

*Integer programming* adalah bentuk metode optimisasi di mana variabel
yang terlibat merupakan bilangan bulat (*integer*). Jika fungsi-fungsi
yang terkait merupakan *linear*, maka disebut dengan *integer linear
programming*.

Sebagai contoh, variabel yang merupakan bilangan bulat adalah banyak
orang.

### Contoh *Integer Programming*

#### Jadwal Kebutuhan Tenaga Kesehatan

Suatu rumah sakit membutuhkan tenaga kesehatan setiap harinya dengan
spesifikasi berikut:

|  hari  | Min Nakes Required | Max Nakes Required |
|:------:|:------------------:|:------------------:|
| Senin  |         24         |         29         |
| Selasa |         22         |         27         |
|  Rabu  |         23         |         28         |
| Kamis  |         11         |         16         |
| Jumat  |         16         |         21         |
| Sabtu  |         20         |         25         |
| Minggu |         12         |         17         |

Tabel Kebutuhan Nakes Harian

Di rumah sakit tersebut berlaku kondisi sebagai berikut:

1.  Setiap nakes hanya diperbolehkan bekerja selama 5 hari
    berturut-turut dan harus libur selama 2 hari berturut-turut.
2.  Tidak ada pemberlakuan *shift* bagi nakes.

Berapa banyak nakes yang harus dipekerjakan oleh rumah sakit tersebut?
Bagaimana konfigurasi penjadwalannya?

Untuk memudahkan dalam mencari solusi permasalahan di atas, kita bisa
membuat tabel ilustrasi berikut:

|  hari  | Min Nakes Required | Max Nakes Required | x1  | x2  | x3  | x4  | x5  | x6  | x7  |
|:------:|:------------------:|:------------------:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Senin  |         24         |         29         |  x  |     |     |  x  |  x  |  x  |  x  |
| Selasa |         22         |         27         |  x  |  x  |     |     |  x  |  x  |  x  |
|  Rabu  |         23         |         28         |  x  |  x  |  x  |     |     |  x  |  x  |
| Kamis  |         11         |         16         |  x  |  x  |  x  |  x  |     |     |  x  |
| Jumat  |         16         |         21         |  x  |  x  |  x  |  x  |  x  |     |     |
| Sabtu  |         20         |         25         |     |  x  |  x  |  x  |  x  |  x  |     |
| Minggu |         12         |         17         |     |     |  x  |  x  |  x  |  x  |  x  |

Konfigurasi Penjadwalan Nakes

Kolom
![x_i, i =1,2,3,4,5,6,7](https://latex.codecogs.com/svg.latex?x_i%2C%20i%20%3D1%2C2%2C3%2C4%2C5%2C6%2C7 "x_i, i =1,2,3,4,5,6,7")
menandakan kelompok nakes yang perlu dipekerjaan pada hari-hari
tertentu. Setiap nilai
![x_i](https://latex.codecogs.com/svg.latex?x_i "x_i") tersebut
merupakan **bilangan bulat positif**
![x \geq 0, x \in \mathbb{Z}](https://latex.codecogs.com/svg.latex?x%20%5Cgeq%200%2C%20x%20%5Cin%20%5Cmathbb%7BZ%7D "x \geq 0, x \in \mathbb{Z}").

Dari ilustrasi di atas, kita bisa membuat model optimisasinya sebagai
berikut:

***Objective Function***

![\min{ \sum\_{i=1}^7 x_i}](https://latex.codecogs.com/svg.latex?%5Cmin%7B%20%5Csum_%7Bi%3D1%7D%5E7%20x_i%7D "\min{ \sum_{i=1}^7 x_i}")

***Constraints***

- Hari Senin:
  ![24 \leq \sum x_i \leq 29, i \in \\1,4,5,6,7\\](https://latex.codecogs.com/svg.latex?24%20%5Cleq%20%5Csum%20x_i%20%5Cleq%2029%2C%20i%20%5Cin%20%5C%7B1%2C4%2C5%2C6%2C7%5C%7D "24 \leq \sum x_i \leq 29, i \in \{1,4,5,6,7\}").
- Hari Selasa:
  ![22 \leq \sum x_i \leq 27, i \in \\1,2,5,6,7\\](https://latex.codecogs.com/svg.latex?22%20%5Cleq%20%5Csum%20x_i%20%5Cleq%2027%2C%20i%20%5Cin%20%5C%7B1%2C2%2C5%2C6%2C7%5C%7D "22 \leq \sum x_i \leq 27, i \in \{1,2,5,6,7\}").
- Hari Rabu:
  ![23 \leq \sum x_i \leq 28, i \in \\1,2,3,6,7\\](https://latex.codecogs.com/svg.latex?23%20%5Cleq%20%5Csum%20x_i%20%5Cleq%2028%2C%20i%20%5Cin%20%5C%7B1%2C2%2C3%2C6%2C7%5C%7D "23 \leq \sum x_i \leq 28, i \in \{1,2,3,6,7\}").
- Hari Kamis:
  ![11 \leq \sum x_i \leq 16, i \in \\1,2,3,4,7\\](https://latex.codecogs.com/svg.latex?11%20%5Cleq%20%5Csum%20x_i%20%5Cleq%2016%2C%20i%20%5Cin%20%5C%7B1%2C2%2C3%2C4%2C7%5C%7D "11 \leq \sum x_i \leq 16, i \in \{1,2,3,4,7\}").
- Hari Jumat:
  ![16 \leq \sum x_i \leq 21, i \in \\1,2,3,4,5\\](https://latex.codecogs.com/svg.latex?16%20%5Cleq%20%5Csum%20x_i%20%5Cleq%2021%2C%20i%20%5Cin%20%5C%7B1%2C2%2C3%2C4%2C5%5C%7D "16 \leq \sum x_i \leq 21, i \in \{1,2,3,4,5\}").
- Hari Sabtu:
  ![20 \leq \sum x_i \leq 25, i \in \\2,3,4,5,6\\](https://latex.codecogs.com/svg.latex?20%20%5Cleq%20%5Csum%20x_i%20%5Cleq%2025%2C%20i%20%5Cin%20%5C%7B2%2C3%2C4%2C5%2C6%5C%7D "20 \leq \sum x_i \leq 25, i \in \{2,3,4,5,6\}").
- Hari Minggu:
  ![12 \leq \sum x_i \leq 17, i \in \\3,4,5,6,7\\](https://latex.codecogs.com/svg.latex?12%20%5Cleq%20%5Csum%20x_i%20%5Cleq%2017%2C%20i%20%5Cin%20%5C%7B3%2C4%2C5%2C6%2C7%5C%7D "12 \leq \sum x_i \leq 17, i \in \{3,4,5,6,7\}").

Kita juga perlu perhatikan bahwa
![x_i \geq 0, i \in \\1,2,3,4,5,6,7\\](https://latex.codecogs.com/svg.latex?x_i%20%5Cgeq%200%2C%20i%20%5Cin%20%5C%7B1%2C2%2C3%2C4%2C5%2C6%2C7%5C%7D "x_i \geq 0, i \in \{1,2,3,4,5,6,7\}").

## *Binary Programming*

*Binary programming* adalah bentuk metode optimisasi di mana variabel
yang terlibat merupakan bilangan biner (0,1). Biasanya metode ini
dipakai dalam masalah penjadwalan yang memerlukan prinsip *matching*
antar kondisi yang ada.

### Contoh *Binary Programming*

#### Jadwal Tatap Muka Terbatas Sekolah

Beberapa minggu ke belakang, kasus harian Covid semakin menurun.
Pemerintah mulai melonggarkan aturan PPKM yang mengakibatkan
sekolah-sekolah mulai menggelar pengajaran tatap muka terbatas (PTMT)
untuk siswanya secara *offline*.

Suatu sekolah memiliki kelas berisi 20 orang siswa. Mereka hendak
menggelar PTMT dengana aturan sebagai berikut:

1.  PTMT digelar dari Senin hingga Jumat (5 hari).
2.  Dalam sehari, siswa yang boleh hadir dibatasi 4-8 orang saja.
3.  Dalam seminggu, diharapkan siswa bisa hadir 2-3 kali.
4.  Siswa yang hadir di selang sehari baru bisa hadir kembali.

Dari uraian di atas, kita bisa membuat model optimisasinya sebagai
berikut:

Saya definisikan
![x\_{i,j} \in (0,1)](https://latex.codecogs.com/svg.latex?x_%7Bi%2Cj%7D%20%5Cin%20%280%2C1%29 "x_{i,j} \in (0,1)")
sebagai bilangan biner di mana
![i \in \\1,2,..,20\\](https://latex.codecogs.com/svg.latex?i%20%5Cin%20%5C%7B1%2C2%2C..%2C20%5C%7D "i \in \{1,2,..,20\}")
menandakan siswa dan
![j \in \\1,2,..,5\\](https://latex.codecogs.com/svg.latex?j%20%5Cin%20%5C%7B1%2C2%2C..%2C5%5C%7D "j \in \{1,2,..,5\}")
menandakan hari. Berlaku:

![x\_{i,j} = \left\\\begin{matrix}
0, \text{ siswa i tidak masuk di hari j}\\ 
1, \text{ siswa i masuk di hari j}
\end{matrix}\right.](https://latex.codecogs.com/svg.latex?x_%7Bi%2Cj%7D%20%3D%20%5Cleft%5C%7B%5Cbegin%7Bmatrix%7D%0A0%2C%20%5Ctext%7B%20siswa%20i%20tidak%20masuk%20di%20hari%20j%7D%5C%5C%20%0A1%2C%20%5Ctext%7B%20siswa%20i%20masuk%20di%20hari%20j%7D%0A%5Cend%7Bmatrix%7D%5Cright. "x_{i,j} = \left\{\begin{matrix}
0, \text{ siswa i tidak masuk di hari j}\\ 
1, \text{ siswa i masuk di hari j}
\end{matrix}\right.")

***Objective Function***

Tujuan utama kita adalah memaksimalkan siswa yang hadir.

![\max{\sum\_{j=1}^5 \sum\_{i=1}^{20} x\_{i,j} }](https://latex.codecogs.com/svg.latex?%5Cmax%7B%5Csum_%7Bj%3D1%7D%5E5%20%5Csum_%7Bi%3D1%7D%5E%7B20%7D%20x_%7Bi%2Cj%7D%20%7D "\max{\sum_{j=1}^5 \sum_{i=1}^{20} x_{i,j} }")

***Constraints***

Dalam sehari, ada pembatasan jumlah siswa yang hadir.

![4 \leq \sum_i x\_{i,j} \leq 8, j \in \\1,2,..,5\\](https://latex.codecogs.com/svg.latex?4%20%5Cleq%20%5Csum_i%20x_%7Bi%2Cj%7D%20%5Cleq%208%2C%20j%20%5Cin%20%5C%7B1%2C2%2C..%2C5%5C%7D "4 \leq \sum_i x_{i,j} \leq 8, j \in \{1,2,..,5\}")

Dalam seminggu, siswa hadir dalam frekuensi tertentu.

![2 \leq \sum_j x\_{i,j} \leq 3, i \in \\1,2,..,20\\](https://latex.codecogs.com/svg.latex?2%20%5Cleq%20%5Csum_j%20x_%7Bi%2Cj%7D%20%5Cleq%203%2C%20i%20%5Cin%20%5C%7B1%2C2%2C..%2C20%5C%7D "2 \leq \sum_j x_{i,j} \leq 3, i \in \{1,2,..,20\}")

Ada jeda sehari agar siswa bisa masuk kembali.

![x\_{i,j} + x\_{i,j+1} \leq 1](https://latex.codecogs.com/svg.latex?x_%7Bi%2Cj%7D%20%2B%20x_%7Bi%2Cj%2B1%7D%20%5Cleq%201 "x_{i,j} + x_{i,j+1} \leq 1")

Jangan lupa bahwa
![x\_{i,j} \geq 0](https://latex.codecogs.com/svg.latex?x_%7Bi%2Cj%7D%20%5Cgeq%200 "x_{i,j} \geq 0").

## *Mixed Integer Linear Programming*

Pada bagian sebelumnya, kita telah membahas masalah optimisasi dengan
variabel berupa diskrit dan kontinu. Permasalahan *real* yang ada di
kehidupan sehari-hari biasanya merupakan memiliki variabel yang *mixed*
antara keduanya. Oleh karena itu, ada metode yang disebut dengan *mixed
integer linear programming*. Pada masalah optimisasi tipe ini, *decision
variables* yang terlibat bisa saja berupa *binary*, *integer*, dan
*continuous* sekaligus.

### Menyelesaikan *MILP*

*MILP* secara eksak bisa diselesaikan dengan metode *simplex* dengan
dikombinasikan dengan teknik *branch and bound*. Penjelasan terkait ini
akan dibahas pada bab `6`.

### Contoh *MILP*

#### Pemilihan dan Penentuan Item Produksi

Suatu pabrik makanan dan minuman berencana untuk membuat tiga produk
baru yang bisa diproduksi di dua *plants* yang berbeda.

| Produk | Runtime Plant 1 | Runtime Plant 2 |
|:-------|----------------:|----------------:|
| Item 1 |               3 |               4 |
| Item 2 |               4 |               6 |
| Item 3 |               2 |               2 |

Tabel Runtime Item Produk per Plant (harian - dalam jam)

**Plant 1** memiliki maksimum *working hours* sebesar 30 jam perhari.

**Plant 2** memiliki maksimum *working hours* sebesar 40 jam perhari.

| Produk | Profit per ton | Sales potential per ton |
|:-------|---------------:|------------------------:|
| Item 1 |              5 |                       7 |
| Item 2 |              7 |                       5 |
| Item 3 |              3 |                       9 |

Tabel Profit dan Potensi Sales Item Produk

Masalah timbul saat mereka harus memilih **dua dari tiga** produk baru
tersebut yang harus di produksi. Selain itu, mereka juga harus memilih
**satu dari dua** *plants* yang memproduksi *items* tersebut.

Misalkan saya definisikan:

- ![x_i \geq 0, i = 1,2,3](https://latex.codecogs.com/svg.latex?x_i%20%5Cgeq%200%2C%20i%20%3D%201%2C2%2C3 "x_i \geq 0, i = 1,2,3")
  sebagai `berapa ton` yang harus diproduksi dari item
  ![i](https://latex.codecogs.com/svg.latex?i "i").
- ![y_i \in \[0,1\], i = 1,2,3](https://latex.codecogs.com/svg.latex?y_i%20%5Cin%20%5B0%2C1%5D%2C%20i%20%3D%201%2C2%2C3 "y_i \in [0,1], i = 1,2,3")
  sebagai *binary*.
  - Jika bernilai 0, maka produk
    ![i](https://latex.codecogs.com/svg.latex?i "i") tidak dipilih.
  - Jika bernilai 1, maka produk
    ![i](https://latex.codecogs.com/svg.latex?i "i") dipilih.
- ![z \in \[0,1\]](https://latex.codecogs.com/svg.latex?z%20%5Cin%20%5B0%2C1%5D "z \in [0,1]")
  sebagai *binary*.
  - Jika bernilai 0, maka *plant* pertama dipilih.
  - Jika bernilai 1, maka *plant* kedua dipilih.

Saya akan mendefinisikan suatu variabel *dummy*
![M = 99999](https://latex.codecogs.com/svg.latex?M%20%3D%2099999 "M = 99999")
berisi suatu nilai yang besar. Kelak variabel ini akan berguna untuk
*reinforce model* (metode pemberian *penalty*) agar bisa memilih *items*
dan *plants* secara bersamaan.

***Objective function*** dari masalah ini adalah memaksimalkan *profit*.

![\max{ \sum\_{i=1}^3 x_i \times \text{profit}\_i }](https://latex.codecogs.com/svg.latex?%5Cmax%7B%20%5Csum_%7Bi%3D1%7D%5E3%20x_i%20%5Ctimes%20%5Ctext%7Bprofit%7D_i%20%7D "\max{ \sum_{i=1}^3 x_i \times \text{profit}_i }")

***Constraints*** dari masalah ini adalah:

Tonase produksi tidak boleh melebihi angka *sales potential* per items.

![x_i \leq \text{sales potential}\_i, i = 1,2,3](https://latex.codecogs.com/svg.latex?x_i%20%5Cleq%20%5Ctext%7Bsales%20potential%7D_i%2C%20i%20%3D%201%2C2%2C3 "x_i \leq \text{sales potential}_i, i = 1,2,3")

Kita akan memilih dua produk sekaligus menghitung tonase. Jika produk
tersebut **dipilih**, maka akan ada angka tonase produksinya.
Sebaliknya, jika produk tersebut **tidak dipilih**, maka tidak ada angka
tonase produksinya.

![x_i - y_i \times M \leq 0, i = 1,2,3](https://latex.codecogs.com/svg.latex?x_i%20-%20y_i%20%5Ctimes%20M%20%5Cleq%200%2C%20i%20%3D%201%2C2%2C3 "x_i - y_i \times M \leq 0, i = 1,2,3")

![\sum\_{i=1}^3 y_i \leq 2](https://latex.codecogs.com/svg.latex?%5Csum_%7Bi%3D1%7D%5E3%20y_i%20%5Cleq%202 "\sum_{i=1}^3 y_i \leq 2")

Kita akan memilih *plant* dari waktu produksinya.

![3x_1 + 4x_2 + 2x_3 - M \times z \leq 30](https://latex.codecogs.com/svg.latex?3x_1%20%2B%204x_2%20%2B%202x_3%20-%20M%20%5Ctimes%20z%20%5Cleq%2030 "3x_1 + 4x_2 + 2x_3 - M \times z \leq 30")

![4x_1 + 6x_2 + 2x_3 + M \times z \leq 40 + M](https://latex.codecogs.com/svg.latex?4x_1%20%2B%206x_2%20%2B%202x_3%20%2B%20M%20%5Ctimes%20z%20%5Cleq%2040%20%2B%20M "4x_1 + 6x_2 + 2x_3 + M \times z \leq 40 + M")

# ALGORITMA PENYELESAIAN OPTIMISASI

Pada bagian ini kita akan membahas macam-macam algoritma yang digunakan
untuk menyelesaikan masalah optimisasi.

<img src="resource_3.png" data-fig-align="center" width="650" />

Secara garis besar ada dua kelompok besar algoritma optimisasi, yakni:

1.  *Exact method*,
2.  *Approximate method*.

Perbedaan keduanya adalah pada **konsep atau pendekatan apa yang
digunakan** untuk menyelesaikan masalah optimisasi. Kita akan bahas
satu-persatu pada bagian selanjutnya.

Dalam beberapa kasus, kita bisa mendapatkan *exact method* bisa untuk
menyelesaikan masalah optimisasi dengan efisien. Namun di kasus lain
yang lebih kompleks tidak demikian. Kelemahan utama metode *exact*
adalah pada waktu komputasinya yang relatif lebih lama.

## *Exact Method*

Ciri khas dari *exact method* adalah metode ini menjamin penyelesaian
yang optimal karena menggunakan pendekatan analitis \[@franz\]. Salah
satu contoh metode eksak adalah *Simplex Method*.

## *Approximate Method*

Ciri khas dari *approximate method* adalah metode ini tidak menjamin
penyelesaian yang optimal karena bersifat *aproksimasi* atau pendekatan
atau hampiran. Oleh karena itu kita perlu melakukan definisi di awal
**seberapa dekat** nilai **hampiran** tersebut bisa kita terima.

Metode ini bisa dibagi menjadi dua berdasarkan keterkaitannya dengan
suatu masalah, yakni:

1.  *Heuristic*, metode ini bersifat *problem dependent*. Artinya metode
    tersebut hanya bisa dipakai untuk jenis permasalahan tertentu.
    - Contoh: metode *nearest neighborhood* hanya bisa dipakai untuk
      menyelesaikan masalah dalam lingkup *travelling salesperson
      problem* (**TSP**).
2.  *Meta heuristic*, metode ini bersifat *problem independent*. Artinya
    metode tersebut tidak tergantung dari jenis permasalahan tertentu.
    Contoh:
    - *Genetic algorithm*.
    - *Simulated annealing*.
    - *Spiral optimization* untuk menyelesaikan masalah *mixed integer
      non linear programming*.
    - *Artifical bee colony algorithm*.

Namun demikian kedua metode ini bisa saling melengkapi dalam prakteknya.

[^1]: https://id.wikipedia.org/wiki/Optimisasi

[^2]: https://empowerops.com/en/blogs/2018/12/6/brief-history-of-optimization

[^3]: Pengantar Riset Operasi dan Optimisasi, KampusX: PO101

[^4]: Pengantar Riset Operasi dan Optimisasi, KampusX: PO101

[^5]: Optimization problem.
    https://en.wikipedia.org/wiki/Optimization_problem

[^6]: https://neos-guide.org/content/optimization-under-uncertainty

[^7]: Pengantar Riset Operasi dan Optimisasi, KampusX: PO101
