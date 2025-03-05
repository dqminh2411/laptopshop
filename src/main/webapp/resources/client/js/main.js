(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);


    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow');
            } else {
                $('.fixed-top').removeClass('shadow');
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow').css('top', 0);
            } else {
                $('.fixed-top').removeClass('shadow').css('top', 0);
            }
        }
    });


    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });


    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 1
            },
            992: {
                items: 2
            },
            1200: {
                items: 2
            }
        }
    });


    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });


    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $('.btn-play').click(function () {
            $videoSrc = $(this).data("src");
        });
        console.log($videoSrc);

        $('#videoModal').on('shown.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
        })

        $('#videoModal').on('hide.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc);
        })
    });



    // Product Quantity
    // $('.quantity button').on('click', function () {
    //     var button = $(this);
    //     var oldValue = button.parent().parent().find('input').val();
    //     if (button.hasClass('btn-plus')) {
    //         var newVal = parseFloat(oldValue) + 1;
    //     } else {
    //         if (oldValue > 0) {
    //             var newVal = parseFloat(oldValue) - 1;
    //         } else {
    //             newVal = 0;
    //         }
    //     }
    //     button.parent().parent().find('input').val(newVal);
    // });

    $('.quantity button').on('click', function () {
        let change = 0;
        var button = $(this)
        const quantityInput = button.parent().parent().find('input');
        var oldVal = quantityInput.val();
        if (button.hasClass('btn-plus')) {
            var newVal = parseInt(oldVal) + 1;
            change = 1;
        }
        else {
            var newVal = 1;
            if (oldVal > 1) {
                newVal = parseInt(oldVal) - 1;
                change = -1;
            }

        }
        quantityInput.val(newVal);

        const price = quantityInput.attr('data-cart-detail-price');
        const id = quantityInput.attr('data-cart-detail-id');

        const sumElement = $(`p[data-cart-detail-id='${id}']`);
        if (sumElement) {
            sumElement.text(formatCurrency(+price * newVal) + " đ");
        }

        const totalPriceElements = $('p[data-cart-detail-total]');
        if (totalPriceElements && totalPriceElements.length) {
            var total = totalPriceElements.first().attr('data-cart-detail-total');
            total = +total + (+price) * change;
            change = 0;
            totalPriceElements?.each(function (index, element) {
                $(totalPriceElements[index]).text(formatCurrency(total) + " đ");
                $(totalPriceElements[index]).attr("data-cart-detail-total", total);
            })
        }

        const idx = quantityInput.attr('data-cart-detail-index');
        // console.log(idx);
        const qtyFormInput = document.getElementById(`cartDetails${idx}.quantity`);
        // console.log(qtyFormInput);
        qtyFormInput.setAttribute("value", newVal);

    })
    function formatCurrency(value) {
        // Use the 'vi-VN' locale to format the number according to Vietnamese currency format
        // and 'VND' as the currency type for Vietnamese đồng
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'decimal',
            minimumFractionDigits: 0, // No decimal part for whole numbers
        });
        let formatted = formatter.format(value);
        // Replace dots with commas for thousands separator
        formatted = formatted.replace(/\./g, ',');
        return formatted;
    }

    $('#btnFilter').click(function (event) {
        event.preventDefault();
        let makeArr = []
        let priceArr = []
        let targetArr = []

        $('#factoryFilter .form-check-input:checked').each(function () {
            makeArr.push($(this).val());
        })

        $('#priceFilter .form-check-input:checked').each(function () {
            priceArr.push($(this).val());
        })
        $('#targetFilter .form-check-input:checked').each(function () {
            targetArr.push($(this).val());
        })

        // console.log(makeArr, priceArr, targetArr);
        // debugger
        const sortVal = $('input[name="radio-sort"]:checked').val();

        let curUrl = new URL(window.location.href)
        const searchParams = curUrl.searchParams;
        // add query string
        searchParams.set('sort', sortVal);
        searchParams.set('page', '1');

        if (makeArr.length > 0) {
            searchParams.set('make', makeArr.join(','))
        }
        else searchParams.delete('make');
        if (priceArr.length > 0) {
            searchParams.set('price', priceArr.join(','))
        }
        else searchParams.delete('price');
        if (targetArr.length > 0) {
            searchParams.set('target', targetArr.join(','))
        } else searchParams.delete('target');

        window.location.href = curUrl.toString();
    })

    const searchParams = new URLSearchParams(window.location.search)
    // set checked boxes for makes
    if (searchParams.has('make')) {
        const makes = searchParams.get('make').split(',')
        makes.forEach(make => {
            $(`#factoryFilter .form-check-input[value="${make}"]`).prop('checked', true);
        })
    }
    // set checked box for targets
    if (searchParams.has('target')) {
        const targets = searchParams.get('target').split(',')
        targets.forEach(trg => {
            $(`#targetFilter .form-check-input[value="${trg}"]`).prop('checked', true);
        })
    }
    //set checked box for prices
    if (searchParams.has('price')) {
        const prices = searchParams.get('price').split(',')
        prices.forEach(price => {
            $(`#priceFilter .form-check-input[value="${price}"]`).prop('checked', true);
        })
    }
    // set checked box for sort
    if (searchParams.has('sort')) {
        const sort = searchParams.get('sort')

        $(`input[type="radio"][name="radio-sort"][value="${sort}"]`).prop('checked', true);

    }

    $('.addToCartBtn').click(function (event) {
        event.preventDefault();
        const productId = $(this).attr('data-product-id');
        addProductToCart(productId, 1);
    })

    $('.addToCartBtnDetail').click(function (event) {
        event.preventDefault();
        const productId = $(this).attr('data-product-id');
        const quantity = $('#cartDetails0\\.quantity').val();
        addProductToCart(productId, quantity);
    })

    function addProductToCart(productId, quantity) {
        if (!isLogin()) {
            $.toast({
                heading: "Lỗi thao tác",
                text: "Bạn cần đăng nhập tài khoản",
                position: "top-right",
                icon: "error"
            })
            return;
        }
        const token = $('meta[name="_csrf"]').attr('content');
        const header = $('meta[name="_csrf_header"]').attr('content');
        $.ajax({
            url: `${window.location.origin}/api/add-product-to-cart`,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            type: 'POST',
            data: JSON.stringify({ productId: productId, quantity: quantity }),
            contentType: 'application/json',
            success: function (response) {
                const sum = +response;
                // console.log(response)
                // console.log(sum)
                // console.log("\\.")
                $('#cartSum').text(response);
                $.toast({
                    heading: 'Giỏ hàng',
                    text: 'Thêm sản phẩm vào giỏ hàng thành công',
                    position: 'top-right',
                    icon: 'success',
                })

            },
            error: function (response) {
                $.toast({
                    heading: 'Giỏ hàng',
                    text: 'Có lỗi xảy ra',
                    position: 'top-right',
                    icon: 'error',
                })
                console.log(response)
            }
        })
    }

    function isLogin() {
        const loginEle = $('.a-login');
        if (loginEle.length > 0)
            return false;
        return true;
    }
})(jQuery);

