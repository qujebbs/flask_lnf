document.getElementById('openForm').addEventListener('click', function() {
    document.getElementById('popUpload').classList.remove('hidden');
  });

  document.getElementById('closeFormButton').addEventListener('click', function() {
    document.getElementById('popUpload').classList.add('hidden');
  });