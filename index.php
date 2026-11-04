<?php
/**
 * Demo PHP app using guzzlehttp/psr7 1.9.1 (CVE-2023-29197 remediated).
 * Used for Port + Aikido + Cursor triage demonstrations.
 */
require __DIR__ . '/vendor/autoload.php';

use GuzzleHttp\Psr7\Response;

header('Content-Type: text/plain');
$response = new Response(200, ['X-Demo' => 'php-bad'], "php-bad demo app\n");
echo $response->getBody();
