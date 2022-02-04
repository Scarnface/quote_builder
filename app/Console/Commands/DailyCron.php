<?php

namespace App\Console\Commands;

use App\Mail\DailyMail;
use App\Models\Quote;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;

class DailyCron extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'daily:cron';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        // Test command
        // \Log::info("Cron is working fine!");

        // Email report of all quotes created today (Runs at midnight so searches previous day)
        $quotes = Quote::where('created_at', '>=', Carbon::yesterday()->startOfDay())->get();
        Mail::to('admin@admin.com')->send(new DailyMail($quotes));
        return 0;
    }
}
