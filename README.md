# SoalShiftSISOP20_modul1_E01

## Soal 1


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :</br></br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(state) hasil poin b</br></br>
Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.
*Gunakan Awk dan Command pendukung<br>
### solusi
a. Menampilkan region yang punya keuntungan terendah
```
West95
```
--revisi<br>
Asumsi yang digunakan sebelum revisi salah yaitu mencari 1 nilai terkecil dari keseluruhan dataset dan pada revisi ini menggunakan asumsi total tiap region
```
satu=$(awk -F'\t' '{sum[$13]+=$21} END {for (i in sum) print i }' dataset.tsv | sort -g | head -n1)

```
menjumlahkan kolom 21 berdasar baris 13 nya jika sudah di sort dan ditampilkan nilai tertingginya

b. Menampilkan 2 state yang punya keuntungan terendah berdasar hasil a
```
dua=$(awk -v satu=$satu -F'\t' '{if ($13==satu) sum[$11]+=$21;} END {for (i in sum) print i }' dataset.tsv | sort -g | head -n2)

```
Caranya sama hanya diberi keadaan hanya menjumlahkan berdasar hasil nomor a
c. Menampilkan 10 barang yang laku keuntungannya paling rendah berdasar hasil b
```
dua=($(echo $dua | tr " " "\n"))
for i in "${dua[@]}"
do
	echo $i
	awk -v dua=$i -F'\t' 'BEGIN {print dua} {if($11==dua) sum[$17]+=$21;} END {for (i in sum) print i}' dataset.tsv | sort -g | head -n10
	echo " "
done
```
karena hasil ke-b disimpan dalam satu string yang dipisah oleh spasi maka harus dipisah menggunakan tr dan variable dua menjadi array maka harus di lakukan loop dan  mencari 10 barang yang keuntungan terendah dengan kondisi hasil nomer b

## Soal 2

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan
data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka
meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.
Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide
tersebut cepat diselesaikan. Idenya adalah kalian (a) membuat sebuah script bash yang
dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf
besar, huruf kecil, dan angka. (b) Password acak tersebut disimpan pada file berekstensi
.txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.
(c) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan di
enkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan
dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal:
password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt
dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan
file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula
seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28,
maka akan menjadi huruf b.) dan (d) jangan lupa untuk membuat dekripsinya supaya
nama file bisa kembali.
<br><br>
HINT: enkripsi yang digunakan adalah caesar cipher.
*Gunakan Bash Script

### solusi
a. Generate password
```
pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
```
b. Memasukkan password ke file
```
echo $pass > $filename.txt
```
c. enkripsi nama file
```
hour=$(date +"%H")
hour=$((hour))

pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 28 | head -n 1)
lower=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

filename=$1
filename=$(echo $filename | tr "${lower:0:26}" "${lower:$hour:26}" | tr "${upper:0:26}" "${upper:$hour:26}")
```
--Revisi
d. dekripsi nama file
```
#!/bin/bash

hourMake=$(date -r $1 +"%H")
hourMake=$((hourMake))

filename=$1
filename=$(echo "${filename%.*}")

lower=abcdefghijklmnopqrstuvwxyz
upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ

filename=$(echo $filename | tr "${lower:$hourMake:26}" "${lower:0:26}" | tr "${upper:$hourMake:26}" "${upper:0:26}")

mv $1 $filename.txt
```
Perbedaan antara enkripsi dan dekripsi yaitu pada bagian  tr "${lower:0:26}" "${lower:$hour:26}" dan tr "${lower:$hourMake:26}" "${lower:0:26}" jika enkripsi 0 - $hour dan jika dekripsi $hourMake - 0

## Soal 3
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati
kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang
sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma,
kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk
menjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya
merupakan hasil dari grep "Location".
<br>*Gunakan Bash, Awk dan Crontab

a. mendownload 28 gambar dengan penamaan pdkt_kusuma_@ dan buat log
```
for ((i=1;i<=28;i++))
do
	wget -a wget.log https://loremflickr.com/320/240/cat
	mv "cat" "pdkt_kusuma_$i"
done
```
b. Melakukan crontab
```
5 6-23/8 * * 0-5 /home/salim/praktikum/test/soal3.sh

```
