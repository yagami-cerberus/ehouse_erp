# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.fn.products_editor = (options) ->
    $this = $(this)
    product_url = options.product_url
    form_prefix = options.form_prefix || ""
    
    $(this).bind 'add-product', (e, product_id) ->
        $contents = $('[data-role=product-container]', $this)
        if $("[data-product-id=" + product_id + "]", $contents).length > 0
            alert "產品已經存在"
            return
        
        $.ajax product_url, {type: 'get', dataType: 'html', data: {
            id: product_id, form_prefix: form_prefix},
        success: (html) ->
            $(html).appendTo($('[data-role=product-container]', $this))
        error: (xhr) ->
            if xhr.status == 404
                alert('找不到產品')
            else
                alert('伺服器錯誤')
        }
    
$.fn.checkbox_toggle = (children_selector) ->
    $children = $(children_selector)
    $(this).bind "change", () ->
        $children.prop("checked", this.checked).trigger("change");

$.fn.create_shipping = (url) ->
    $(this).bind "click", ->
        product_list = $($(this).attr "data-products").map () ->
            "p[]=" + $(this).val()
        window.location = url + "?" + product_list.toArray().join "&"

$.fn.press_enter = (fn) ->
    $(this).bind "keypress", (e) ->
        if e.keyCode == 10 || e.keyCode == 13
            fn.call(this, e)
            false

    
