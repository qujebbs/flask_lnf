<?php if (isset($postList)): ?>
    <!-- New Table -->
    <div class="container px-6 mx-auto mb-6 grid w-full">
        <div class="grid gap-1 h-auto md:grid-cols-2 xl:grid-cols-4  hover:cursor-pointer">
            <?php foreach ($postList as $post): ?>
                <!--Start of Cards-->
                <div class="grid col-span-3">
                    <div class="flex items-center h-auto shadow-xl p-6 bg-gray-100  dark:bg-gray-800">
                        <div class="w-full">
                            <div class="flex justify-between">
                                <p class="mb-2 text-lg font-medium text-gray-600 dark:text-gray-400">
                                    <?= $post['username']?? '' ?>
                                </p>
                                <p class="mb-2 text-lg font-medium text-gray-600 dark:text-gray-400">
                                <?= $post['itemName']?? '' ?>
                                </p>
                                <?Php if ($_SESSION['userRole'] === 'admin' && $_GET['type'] === 'found'): ?>

                                    <button class="rounded-full text-white text-sm p-2 flex items-center " hx-post="/updateStatus"
                                        hx-include="[name='claimant']" hx-vals='{"id":"<?= $post['postID'] ?>","from":"found"}'
                                        style="background-color: rgb(75, 145, 114);"><img width="20" height="20"
                                            src="assets/img/svg-loaders/ball-triangle.svg" alt=""> Mark as Claimed</button>
                                <?php elseif ($_SESSION['userRole'] === 'admin' && $_GET['type'] === 'claimed'): ?>

                                    <button class="rounded-full text-white text-sm p-2 flex items-center " hx-post="/updateStatus"
                                        hx-vals='{"id":"<?= $post['postID'] ?>","from":"claimed"}'
                                        style="background-color: rgb(75, 145, 114);"><img width="20" height="20"
                                            src="assets/img/svg-loaders/ball-triangle.svg" alt=""> Mark as Unclaimed</button>

                                <?php endif ?>
                            </div>


                            <p class="text-sm font-semibold text-gray-700 dark:text-gray-200">
                                <?= $post['userEmail'] ?? '' ?>
                            </p>


                            <p class="text-sm font-semibold  text-gray-700 dark:text-gray-200 ">
                                <?= $post['itemDescription'] ?? '' ?>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- Card -->
                <div
                    class="flex items-center h-auto justify-between border-b w-full p-4 bg-white rounded-b-lg dark:bg-gray-800 ">
                    <div>
                        <img width="190" height="100" class="rounded-lg" src="./assets/img/registerbg.png" alt="gf" />
                    </div>
                    <?php if ($_SESSION['userRole'] === 'admin'): ?>
                        <div hx-post="/deletePost" hx-vals='{"id":"<?= $post['postID'] ?>","type":"<?=$_GET['type']?>"}'
                            class="p-3 mr-4 text-teal-500 bg-red-100 border rounded-full  dark:text-teal-100 dark:bg-teal-500">
                            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                stroke="currentColor" class="w-6 h-6 text-black">
                                <path stroke-linecap="round" stroke-linejoin="round"
                                    d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                            </svg>

                        </div>
                    <?php endif ?>
                </div>
                <!--End of Cards-->
            <?php endforeach ?>
        </div>
    </div>
    <!-- New Table -->
<?php else: ?>
    <div class="lg:w-full  flex justify-center items-center">
        <div class="pb-16">
            <img class=" lg:max-w-2xl max-h-xl dark:opacity-50" src="./assets/img/dash.svg" alt="Research">
        </div>
    </div>
<?php endif ?>