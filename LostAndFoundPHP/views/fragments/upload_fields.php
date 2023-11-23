<?php include('views/fragments/errors.php'); ?> 
<input data-te-input-showcounter="true"
    class=" text-gray-800  title bg-gray-100 w-full border border-green-900 p-2 outline-none rounded-md" maxlength="50"
    spellcheck="false" placeholder="Lost item name" type="text" name="postTitle">
<!-- icons -->
<div class=" flex text-gray-500 m-2 p-3">
    <div id="char-count" class="count ml-auto text-black text-xs font-semibold">0</div>
</div>
<textarea data-te-input-showcounter="true" id="text"
    class="w-full description bg-gray-100 p-3 h-60 border border-green-900  rounded-md" spellcheck="false" maxlength="255"
    placeholder="Describe lost item" name="postDesc"></textarea>

<!-- icons -->
<div class=" flex text-gray-500 m-2 p-3">
    <div id="char-count" class="count ml-auto text-black text-xs font-semibold">0</div>
</div>
<!-- buttons -->

<label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="file_input">Upload file limit (10 MB per file)<span id="hiddenTxt" style="color: red;" class="ml-4"></span></label>
<input
    class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400"
    id="file_input" type="file" name="postFiles[]" multiple accept=".png,.jpg,.jpeg,.bmp">