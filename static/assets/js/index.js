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
function showConfirmationDialog() {
  Swal.fire({
    title: 'Are you sure?',
    text: 'You are about to delete this post.',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: '#3085d6',
    confirmButtonText: 'Yes, delete it!'
  }).then((result) => {
    if (result.isConfirmed) {
      document.getElementById('deleteForm').submit();
    }
  });
}

document.getElementById("uploadForm").addEventListener("submit", function(event) {
  event.preventDefault();
  Swal.fire({
    icon: "success",
    title: "File has been uploaded successfully",
    showConfirmButton: false,
    timer: 1500
  }).then(function() {
    event.target.submit();
  });
});

// Comment popup

// document.getElementById('openComment').addEventListener('click', function() {
//   document.getElementById('popComment').classList.remove('hidden');
// });

// document.getElementById('closeComment').addEventListener('click', function(e) {
//   document.getElementById('popComment').classList.add('hidden');
//   e.preventDefault();
// });
// document.getElementById('viewComs').addEventListener('click', function() {
//   document.getElementById('popViewComs').classList.remove('hidden');
// });

// document.getElementById('closeViewComment').addEventListener('click', function(e) {
//   document.getElementById('popViewComs').classList.add('hidden');
//   e.preventDefault();
// });

function popComs(){
  document.getElementById('popViewComs').classList.remove('hidden');
  console.log('error')
}
function closeView(){
  document.getElementById('popViewComs').classList.add('hidden');
}





//close




// Comment popup
// document.querySelectorAll('.commentButton').forEach(function(button) {
//   button.addEventListener('click', function() {
//     // Find the corresponding form based on the button's index
//     var index = Array.from(document.querySelectorAll('.commentButton')).indexOf(button);
//     var forms = document.querySelectorAll('.commentForm');
    
//     if (index < forms.length) {
//       forms[index].classList.remove('hidden');
//     }
//   });
// });

// document.querySelectorAll('.closeCommentButton').forEach(function(button) {
//   button.addEventListener('click', function(e) {
//     // Find the corresponding form
//     var form = button.closest('.commentForm');
    
//     if (form) {
//       form.classList.add('hidden');
//       e.preventDefault();
//     }
//   });
// });
