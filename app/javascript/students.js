document.addEventListener('DOMContentLoaded', function() {
  const toggleSwitches = document.querySelectorAll('.attendance-toggle');

  toggleSwitches.forEach(function(toggleSwitch) {
    toggleSwitch.addEventListener('change', function() {
      const studentId = toggleSwitch.dataset.studentId;
      const isChecked = toggleSwitch.checked;

      const xhr = new XMLHttpRequest();
      xhr.open('PATCH', '/admin/students/' + studentId + '/toggle_attendance', true);
      xhr.setRequestHeader('Content-Type', 'application/json');

      xhr.onload = function() {
        if (xhr.status === 200) {
          console.log('Attendance toggled successfully!');
        } else {
          console.error('Failed to toggle attendance:', xhr.statusText);
        }
      };
      
      xhr.send(JSON.stringify({ attendance: isChecked }));
    });
  });
});

