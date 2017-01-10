/**
 * Created by myLee on 16/5/14.
 */

//读入tree的数据
$.ajaxSettings.async = false;
//$.getJSON("../json/background.json",function(json){
//    var data = json;
//    var temp = "";
//    for(var key in data) {
//        temp += "<li><label class='badge badge-success'>" + key + "</label><ul>";
//        for (var i=0 in data[key]) {
//            temp += "<li><label><span>" + data[key][i] + "</span> <input type='checkbox'/></label></li>";
//        }
//        temp += "</ul></li>";
//    }
//    $("#background-case").append(temp);
//});
$.getJSON("json/sort.json",function(json){
    var data = json;
    var temp = "";
    for(var key in data) {
        temp += "<li><label class='badge badge-success'>" + key + "</label><input type='checkbox' class='js-label-title'/><ul>";
        for (var key1 in data[key]){
            temp += "<li><label class='badge badge-success'><span>" + data[key][key1] + "</span> <input type='checkbox'/></label>";
        }
        temp += "</ul></li>";
    }
    $("#sort-case").append(temp);
});
$.ajaxSettings.async = true;

//树的展开/收缩效果
$('.tree li:has(ul)').addClass('parent_li').find(' > label').attr('title', 'Collapse this branch');
$('.parent_li > ul > li').hide();
$('ul.main-tree > li').show();
$('.tree li.parent_li > label').on('click', function (e) {
    var children = $(this).parent('li.parent_li').find(' > ul > li');
    if (children.is(":visible")) {
        children.hide('fast');
        $(this).attr('title', 'Expand this branch').find(' > i').addClass('icon-plus-sign').removeClass('icon-minus-sign');
    } else {
        $(this).parent().siblings().find('> ul > li').hide('fast');
        children.show('fast');
        $(this).attr('title', 'Collapse this branch').find(' > i').addClass('icon-minus-sign').removeClass('icon-plus-sign');
    }
    e.stopPropagation();
});

//给checkbox绑定label事件
var vm = new Vue({
    el: '#label-section',
    data: {
        backgrounds: [],
        sorts: []
    },
    methods: {
        removeBackgrounds: function (index) {
            this.backgrounds.splice(index, 1)
        },
        removeSorts: function (index) {
            this.sorts.splice(index, 1)
        }
    }
});

$("#emptyBack").click(function(){
    vm.backgrounds.splice(0,vm.backgrounds.length);
    $("#background-case input[type='checkbox']").removeAttr("checked");
});

$("#emptySort").click(function(){
    vm.sorts.splice(0,vm.sorts.length);
    $("#sort-case input[type='checkbox']").removeAttr("checked");
});

//$("#background-case input[type='checkbox']").click(function() {
//    var title = $(this).parent().parent().parent().siblings("label").text();
//    var sub = $(this).siblings("span").text();
//    var index;
//    if($(this).is(":checked")) {
//        if (vm.backgrounds.length == 6 ){
//            alert("最多只能输入六个查询类别");
//            $(this).removeAttr("checked");
//        } else {
//            vm.backgrounds.push( { title: title, sub: sub} );
//        }
//    } else {
//        for(var i in vm.backgrounds) {
//            if (vm.backgrounds[i].title == title && vm.backgrounds[i].sub == sub) {
//                index = i;
//                vm.backgrounds.splice(index, 1);
//                break;
//            }
//        }
//    }
//});

$("#sort-case input[type='checkbox']").not('.js-label-title').click(function() {
    var title = $(this).parent().parent().parent().siblings("label").text();
    var sub = $(this).siblings("span").text();
    var index;
    var flag = false;
    if($(this).parent().parent().parent().siblings("input").is(":checked")) {
        flag = true;
    }
    if($(this).is(":checked")) {
        if (vm.sorts.length == 6 && flag == false){
            alert("最多只能输入六个查询类别");
            $(this).removeAttr("checked");
        } else {
            vm.sorts.push( { title: title, sub: sub} );
            $(this).parent().parent().parent().siblings("input").removeAttr("checked");
            for(var i in vm.sorts) {
                if (vm.sorts[i].title == title && vm.sorts[i].sub == "全部") {
                    index = i;
                    vm.sorts.splice(index, 1);
                    break;
                }
            }
        }
    } else {
        for(var i in vm.sorts) {
            if (vm.sorts[i].title == title && vm.sorts[i].sub == sub) {
                index = i;
                vm.sorts.splice(index, 1);
                break;
            }
        }
    }
});

$("#sort-case input[type='checkbox'].js-label-title").click(function() {
    var title = $(this).siblings("label").text();
    var sub;
    var index;
    var flag = false; //判断在第六个条件是是否可以代替掉sub
    $(this).siblings("ul").children("li").find("input").each(function(){
        if($(this).is(":checked")) {
            flag = true;
        }
    })
    if($(this).is(":checked")) {
        if (vm.sorts.length == 6 && flag== false){
            alert("最多只能输入六个查询类别");
            $(this).removeAttr("checked");
        } else {
            $(this).siblings("ul").children("li").each(function(){
                $(this).children("label").children("input").removeAttr("checked");
                sub = $(this).children("label").children("span").text();
                for(var i in vm.sorts) {
                    if (vm.sorts[i].title == title && vm.sorts[i].sub == sub) {
                        index = i;
                        vm.sorts.splice(index, 1);
                        break;
                    }
                }
            });
            vm.sorts.push( { title: title, sub: "全部"} );
        }
    } else {
        for(var i in vm.sorts) {
            if (vm.sorts[i].title == title) {
                index = i;
                vm.sorts.splice(index, 1);
                break;
            }
        }
    }
});

//function deleteBG(obj){
//    var title = $(obj).children(".js-cate-content").children().eq(0).text();
//    var sub = $(obj).children(".js-cate-content").children().eq(1).text();
//    var findTitle = $("#background-case").children().children("label");
//    var index;
//
//    for(var i in vm.backgrounds) {
//        if (vm.backgrounds[i].title == title && vm.backgrounds[i].sub == sub) {
//            index = i;
//            vm.backgrounds.splice(index, 1);
//            break;
//        }
//    }
//
//    for(var i in findTitle) {
//        if ($(findTitle[i]).text() == title) {
//            var findSub = $(findTitle[i]).siblings("ul").find("span");
//            for(var j in findSub) {
//                if ($(findSub[j]).text()==sub) {
//                    $(findSub[j]).siblings("input").removeAttr("checked");
//                    break;
//                }
//            }
//            break;
//        }
//    }
//};

function deleteSort(obj){
    var title = $(obj).children(".js-cate-content").children().eq(0).text();
    var sub = $(obj).children(".js-cate-content").children().eq(1).text();
    var findTitle = $("#sort-case").find("label");
    var index;
    console.log(title, sub);

    for(var i in vm.sorts) {
        if (vm.sorts[i].title == title && vm.sorts[i].sub == sub) {
            index = i;
            vm.sorts.splice(index, 1);
            break;
        }
    }

    for(var i in findTitle) {
        if ($(findTitle[i]).text() == title) {
            if (sub == "全部") {
                $(findTitle[i]).siblings("input").removeAttr("checked");
            } else {
                var findSub = $(findTitle[i]).siblings("ul").find("span");
                for(var j in findSub) {
                    if ($(findSub[j]).text()==sub) {
                        $(findSub[j]).siblings("input").removeAttr("checked");
                        break;
                    }
                }
            }
            break;
        }
    }
};

$("#background-case > li > label").click(function(){
    var obj = $(this).parent();
    console.log("url('../images/tree-list-active.png')");
    console.log(obj.css("list-style-image"));
    //if(num == 0) {
    //    obj.css("list-style-image", "url(\"../images/tree-list-active.png\")");
    //} else {
    //    obj.css("list-style-image", "url(\"../images/tree-list.png\")");
    //}
});

