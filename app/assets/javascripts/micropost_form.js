
$(document).ready(function () {
    $('#micropost_picture').on('change', function () {
      var size_in_megabytes = this.files[0].size / 1024 / 1024;
      alert(size_in_megabytes)
      if (size_in_megabytes > 5) {
        alert(I18n.t('js.alert_danger_size'))
      }
    });
  });
