document.getElementById('openForm').addEventListener('click', function() {
  document.getElementById('popUpload').classList.remove('hidden');
});

document.getElementById('closeFormButton').addEventListener('click', function() {
  document.getElementById('popUpload').classList.add('hidden');
});

// document.getElementById('open').addEventListener('click', function() {
//     document.getElementById('modal').classList.remove('hidden');
//   });

//   document.getElementById('close').addEventListener('click', function() {
//     document.getElementById('modal').classList.add('hidden');
//   });

document.addEventListener('click', function (event) {
  const target = event.target;
  if (target.classList.contains('open-button')) {
      const modal = target.closest('tr').querySelector('.modal');
      modal.classList.remove('hidden');
  } else if (target.classList.contains('close-button')) {
      const modal = target.closest('.modal');
      modal.classList.add('hidden');
  }
});

//   document.getElementById('text').addEventListener('input', function() {
//     var text = this.value;
//     var words = text.split(/\s+/).filter(function(word) {
//         return word.length > 0;
//     });
 
//     document.getElementById('counter').textContent = words.length ;
// });

const inputFields = document.querySelectorAll('input[data-te-input-showcounter="true"]');
const textarea = document.querySelectorAll('textarea[data-te-input-showcounter="true"]');

  
  inputFields.forEach(inputField => {
    const charCount = inputField.nextElementSibling.querySelector('div');

    inputField.addEventListener('input', () => {
      charCount.textContent = `${inputField.value.length} / ${inputField.maxLength}`;
    });
  });

  textarea.forEach(textarea => {
    const charCount = textarea.nextElementSibling.querySelector('div');

    textarea.addEventListener('input', () => {
      charCount.textContent = `${textarea.value.length} / ${textarea.maxLength}`;
    });
  });


document.getElementById('fileInput').addEventListener('change', function() {
  var fileList = document.getElementById('fileList');
  fileList.innerHTML = ''; // Clear the list
  for (var i = 0; i < this.files.length; i++) {
      var fileItem = document.createElement('div');
      fileItem.textContent = this.files[i].name;
      fileItem.className = 'fileItem';
      fileList.appendChild(fileItem);
  }
});

function toggleForm() {
  var formContainer = document.getElementById("form-container");
  if (formContainer.style.display === "none") {
    formContainer.style.display = "block";
  } else {
    formContainer.style.display = "none";
  }
}