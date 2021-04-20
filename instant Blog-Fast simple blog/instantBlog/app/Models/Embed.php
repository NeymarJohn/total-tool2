<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Embed extends Model
{
	use HasFactory;
	
    public $table = "embeds";
    protected $fillable = [
        'short_url', 'url', 'embedcode'
    ];
    public $timestamps = false;
}
