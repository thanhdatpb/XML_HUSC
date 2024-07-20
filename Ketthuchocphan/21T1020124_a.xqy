for $hoadon in /quan_ly_ban_hang/hoa_don
where $hoadon/ngayxuat = '2024-02-03'
return (
    $hoadon/madon/text(),
    $hoadon/khachhang/hoten/text(),
    $hoadon/tongtien/text()
)