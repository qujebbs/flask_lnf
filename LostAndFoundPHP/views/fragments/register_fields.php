
<?php include('views/fragments/errors.php'); ?> 

<div class="flex flex-col pt-4">
              <label class="text-lg">Student ID</label>
              <input
                type="text"
                id="studID"
                name="studID"
                placeholder="SUM2021-01384"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mt-1 leading-tight focus:outline-none focus:shadow-outline"
                value="<?=$studIDNum??''?>"
              />
            </div>
            <div class="flex flex-col pt-4">
              <label class="text-lg">Username</label>
              <input
                type="text"
                id="username"
                name="username"
                placeholder="DragonMaster23"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mt-1 leading-tight focus:outline-none focus:shadow-outline"
                value="<?=$username??''?>"
              />
            </div>

            <div class="flex flex-col pt-4">
              <label class="text-lg">E-mail</label>
              <input
                type="text"
                id="email"
                name="email"
                placeholder="E-mail"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mt-1 leading-tight focus:outline-none focus:shadow-outline"
                value="<?=$email??''?>"
              />
            </div>
            <div class="flex flex-col pt-4">
              <label class="text-lg">Password</label>
              <input
                type="password"
                id="password"
                name="password"
                placeholder="Password"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mt-1 leading-tight focus:outline-none focus:shadow-outline"
                value=""
              />
            </div>
            <div class="flex flex-col pt-4">
              <label class="text-lg">Confirm Password</label>
              <input
                type="password"
                id="passwordComf"
                name="passwordConf"
                placeholder="Confirm Password"
                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mt-1 leading-tight focus:outline-none focus:shadow-outline"
                value=""
              />
            </div>
