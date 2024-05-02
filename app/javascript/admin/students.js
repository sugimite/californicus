document.addEventListener('turbo:load', function() {
  const toggleSwitches = document.querySelectorAll('.attendance-toggle');
  console.log("test");

  toggleSwitches.forEach(function(toggleSwitch) {
    toggleSwitch.addEventListener('change', function() {
      const studentId = toggleSwitch.dataset.studentId;
      const isChecked = toggleSwitch.checked;

      if (isChecked) {
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/admin/students/' + studentId + '/toggle_attendance', true);
        xhr.setRequestHeader('Content-Type', 'application/json');

        xhr.onload = function() {
          if (xhr.status === 200) {
            console.log('Attendance toggled successfully!');
          } else {
            console.error('Failed to toggle attendance:', xhr.statusText);
          }
        };
        
        xhr.send();
      }
    });
  });
});
console.log("JStest");
