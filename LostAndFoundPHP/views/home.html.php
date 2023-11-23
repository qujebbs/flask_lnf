<?php require_once('views/fragments/nav.php'); ?>
<main class="h-full overflow-y-auto">
    <div class="container px-6 mx-auto mb-6 grid">
        <h2 class="my-6 text-2xl font-semibold text-gray-700 dark:text-gray-200">
            Welcome!! Lost
        </h2>
        <!-- CTA -->
        <!-- Cards -->
        <div class="grid gap-6 h-auto md:grid-cols-2 xl:grid-cols-4  hover:cursor-pointer">
            <a href="/?type=lost" hx-get="/?type=lost" hx-param="*" hx-target="#cardCont" hx-push-url="true">
                <div class="flex items-center h-32 border  p-4 <?php if (isset($_GET['type'])) {
                    $type = $_GET['type'];
                    echo $type === 'lost' ? 'bg-blue-100' : 'bg-white';
                } ?> rounded-lg shadow-xl dark:bg-gray-800">
                    <div class="p-3 mr-4 text-green-500 bg-green-100 rounded-full dark:text-green-100 dark:bg-green-500
                        ">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M9.879 7.519c1.171-1.025 3.071-1.025 4.242 0 1.172 1.025 1.172 2.687 0 3.712-.203.179-.43.326-.67.442-.745.361-1.45.999-1.45 1.827v.75M21 12a9 9 0 11-18 0 9 9 0 0118 0zm-9 5.25h.008v.008H12v-.008z" />
                        </svg>
                    </div>

                    <div>
                        <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                            Lost
                        </p>
                        <p class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                            100
                        </p>
                    </div>
                </div>
            </a>
            <!-- Card -->
            <a href="/?type=found" hx-get="/?type=found" hx-param="*" hx-target="#cardCont" hx-push-url="true">
                <div class="flex items-center h-32 border p-4 <?php if (isset($_GET['type'])) {
                    $type = $_GET['type'];
                    echo $type === 'found' ? 'bg-blue-100' : 'bg-white';
                } ?>  rounded-lg shadow-xl dark:bg-gray-800">
                    <div class="p-3 mr-4 text-blue-500 bg-blue-100 rounded-full dark:text-blue-100 dark:bg-blue-500">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M15.75 15.75l-2.489-2.489m0 0a3.375 3.375 0 10-4.773-4.773 3.375 3.375 0 004.774 4.774zM21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>

                    </div>
                    <div>
                        <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                            Found
                        </p>
                        <p class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                            376
                        </p>
                    </div>
                </div>
            </a>
            <!-- Card -->
            <a href="Requests.html">
                <div class="flex items-center h-32 border p-4 bg-white rounded-lg shadow-xl dark:bg-gray-800">
                    <div class="p-3 mr-4 text-teal-500 bg-teal-100 rounded-full dark:text-teal-100 dark:bg-teal-500">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                        </svg>

                    </div>
                    <div>
                        <p class="mb-2 text-sm font-medium text-gray-600 dark:text-gray-400">
                            Requests
                        </p>
                        <p class="text-lg font-semibold text-gray-700 dark:text-gray-200">
                            35
                        </p>
                    </div>
                </div>
            </a>
            <a href="/?type=claimed" hx-get="/?type=claimed" hx-param="*" hx-target="#cardCont" hx-push-url="true">
                <div class="flex items-center h-32 border p-4 bg-white rounded-lg shadow-xl dark:bg-gray-800">
                    <div class="p-3 mr-4 text-teal-500 bg-teal-100 rounded-full dark:text-teal-100 dark:bg-teal-500">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                            stroke="currentColor" class="w-6 h-6">
                            <path stroke-linecap="round" stroke-linejoin="round"
                                d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                        </svg>

                    </div>
                    <div>
                        <p class="mb-2 text-md font-medium text-gray-600 dark:text-gray-400">
                            Claimed
                        </p>
                        <p class="text-2xl font-bold text-gray-700 dark:text-gray-200">
                            35
                        </p>
                    </div>
                </div>
            </a>
            <!--End of Dashboard-->

        </div>
    </div>
    <div id="cardCont">

        <?php require('views/fragments/feedCard.php') ?>
        <!-- New Table -->
        
    </div>
    <!--Hidden modal-->
    <div id="modal" class="hidden h-full fixed inset-0 top-0 left-0 mx-auto flex flex-col justify-center items-center ">
        <div class=" flex flex-col items-center rounded-lg p-10 imgcont border-2" style="height: 500px; width:600px;">
            <!-- The close button -->
            <div class=" relative">
                <a class="bg-blue-100 absolute m-6 right-0 sticky ml-28 w-auto px-4 text-red-100 rounded-full text-9xl font-bold"
                    style="font-size: 30px;" href="javascript:void(0)" onclick="closeModal()">&times;</a>
                <!-- A big image will be displayed here -->
                <img id="modal-img" width="700" height="300" class="rounded-lg p-4" />
                <img id="modal-img" width="700" height="300" class="rounded-lg p-4" />
                <img id="modal-img" width="700" height="300" class="rounded-lg p-4" />
                <img id="modal-img" width="700" height="300" class="rounded-lg p-4" />
            </div>
        </div>
    </div>
    <!--Hidden modal-->



</main>
<?php require_once('views/fragments/footer.php'); ?>