<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        User::factory()->create([
            'email' => 'admin@admin.com',
            'password' => '$2y$10$l5Fa1y/KwZe2h/iOQEKG5ePNBau80cRCQdSV1M084fohaOijS0GkO'
        ]);

        Product::factory(100)->create();
    }
}
