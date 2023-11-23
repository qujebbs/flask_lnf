
// ----- Open Upload Form
document.getElementById('openForm').addEventListener('click', function() {
  document.getElementById('popUpload').classList.remove('hidden');
});

document.getElementById('closeFormButton').addEventListener('click', function(e) {
  document.getElementById('popUpload').classList.add('hidden');
  e.preventDefault();
});
// ----- end  Open Upload Form


// ------- Open edit status  modal
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
// ------- end Open edit status  modal

// ------- Open Image Preview
var modal = document.getElementById('modal');
var modalImg = document.getElementById('modal-img');

// this function is called when a small image is clicked
function showModal(src) {
  modal.classList.remove('hidden');
  modalImg.src = src;
}

// this function is called when the close button is clicked
function closeModal() {
  modal.classList.add('hidden');
}

//---- Counter of fields in Upload
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



// check the limit of file upload



const input = document.querySelector('input[type="file"]');
const hiddenTxt = document.getElementById('hiddenTxt');

input.addEventListener('change',()=>{
  validateSize();
  document.getElementById("btnPost").addEventListener('click',function(e){
    if(document.getElementById('file_input').files.length > 5){
      alert("5 files only .|.")
      e.preventDefault();
    }
  });
});

document.querySelector('form').addEventListener('submit',(e)=>{
  alert('Error');
  e.preventDefault('submit');

  const res = validateSize();

  if(res){
    throw res;
  }
  //IBang Validation function

  //ikaw na bahala mag alis neto ranillo placeholder lang to

  hiddenTxt.textContent = "UPLOADING..";

});
//check  size
function validateSize(){
  const file =  input.files[0];

  if(!file){
    const err = new Error("No Selected File");
    hiddenTxt.textContent = err.message;
    return err;
  }

  const limit = 10000;
  // const size = file.size/1024;
  let size = 0;
  for(item of input.files){
    size+= item.size/1024;
  }
  if (size > limit){
    const err = new Error(`File too big :${(size/1024).toFixed(2)} MB`);
    hiddenTxt.textContent = err.message;
    return err;
  }else{
    hiddenTxt.textContent = "✅";
    return false;
  }
}



