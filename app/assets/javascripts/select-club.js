(function ($) {
    jQuery.expr[':'].Contains = function (a, i, m) {

        return (a.textContent || a.innerText || "").toUpperCase()
            .indexOf(m[3].toUpperCase()) >= 0;
    };

    function listFilter(list) {
        var form = $("<form>").attr({
                "class": "filterform",
                "action": "#"
            }),
            input = $("<input>").attr({
                "class": "filterinput form-control",
                "type": "text",
                "placeholder": "Filter by keyword...",
                "autofocus": "autofocus"
            });
        $(form).append(input);
        $(form).append('<span id="input-cross" onclick="$(\'.filterinput\').val(\'\').keyup().focus()"><i class="icon-remove"></i></span>');
        $(form).prependTo(list);

        $(input).change(
            function () {

                var filter = $.trim($(this).val());
                if (filter) {
                    $(list).find(
                        "li:not(:Contains(" + filter + "))").hide();
                    $(list).find(
                        "li:Contains(" + filter + ")")
                        .show();
                } else {
                    $(list).find("li").show();
                }
                return false;
            }).keyup(function () {
            $(this).change();
        });
    }

    $(function () {
        $menuItem = $('#select-club-menu .user-name');

        $("#select-club-menu ul").on("click", "li", function () {
            var selection = $.trim($(this).text());
            $menuItem.html(selection);
        });

        listFilter($("#select-club-menu ul"));

        $("#select-club-menu ul").find('li.selected').click();
    });
}(jQuery));
