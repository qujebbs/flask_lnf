<?php include('views/fragments/errors.php'); ?>
<div class="flex flex-col pt-4">
    <label class="text-lg">Username</label>
    <input type="text" id="Username" name="username" placeholder="Username" value="<?=$username??''?>"
        class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mt-1 leading-tight focus:outline-none focus:shadow-outline" />
</div>

<div class="flex flex-col pt-4">
    <label class="text-lg">Password</label>
    <input type="password" id="password" name="password" placeholder="Password"
        class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mt-1 leading-tight focus:outline-none focus:shadow-outline" />
</div>