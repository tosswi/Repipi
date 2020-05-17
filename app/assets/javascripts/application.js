// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.raty
//= require ratyrate
//= require rails-ujs
//= require bxslider
//= require activestorage
//= require bootstrap-sprockets
//= require cocoon
//= require_tree .

/*
jQuery(document).ready(function ($) {
  $('.slider').bxSlider({
    auto: true,
    controls: true,
    pager: false
  });
});
*/

$(document).ready(function () {
  $('.bxslider').bxSlider({
    auto: true, // 自動スライド
    speed: 5000, // スライドするスピード
    moveSlides: 1, // 移動するスライド数
    pause: 500, // 自動スライドの待ち時間
    maxSlides: 5, // 一度に表示させる最大数
    slideWidth: 250, // 各スライドの幅
    randomStart: true, // 最初に表示するスライドをランダムに設定
    pager: false,
    auto: true,
    controls: true
  });
});

// $(function () {
//   //querySelectorでfile_fieldを取得
//   var file_field = document.querySelector('input[type=file]')
//   //fileが選択された時に発火するイベント
//   $('#img-file').change(function () {
//     //選択したfileのオブジェクトをpropで取得
//     var file = $('input[type="file"]').prop('files')[0];
//     //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
//     var fileReader = new FileReader();
//     //読み込みが完了すると、srcにfileのURLを格納
//     fileReader.onloadend = function () {
//       var src = fileReader.result

//       var html = '<img src="${src}" width="114" height="80">'

//       //image_box__container要素の前にhtmlを差し込む
//       $('#image-box__container').before(html);
//     }
//     fileReader.readAsDataURL(file);
//   });
// });