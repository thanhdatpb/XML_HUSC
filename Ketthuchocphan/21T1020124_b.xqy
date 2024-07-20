let $customerID := 't201' (: Mã khách hàng bạn muốn truy vấn :)
for $invoice in /quan_ly_ban_hang/hoa_don[khachhang/makhachhang = $customerID]
let $totalInvoice := count($invoice)
let $totalAmount := sum($invoice/tongtien)
return (
    $invoice/khachhang/hoten/text(),
    $totalInvoice,
    $totalAmount
)