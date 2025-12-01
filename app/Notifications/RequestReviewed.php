<?php

namespace App\Notifications;

use App\Models\Request as EmpRequest;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class RequestReviewed extends Notification
{
    use Queueable;

    public function __construct(public EmpRequest $request) {}

    public function via($notifiable)
    {
        return ['mail', 'database'];
    }

    public function toMail($notifiable)
    {
        // Always refresh the latest data
        $req = $this->request->fresh(['employee', 'leaveRequest']);

        $statusText = match ($req->raw_status) {
            1 => 'Approved',
            2 => 'Discarded',
            default => 'Pending',
        };

        return (new MailMessage)
            ->subject("Your {$req->type} Request Was Reviewed")
            ->line("Your {$req->type} request has been reviewed.")
            ->line("Status: {$statusText}")
            ->line("Admin Response: " . ($req->admin_response ?: 'No message'))
            ->line("Request Message: " . ($req->message ?: 'N/A'))
            ->action('View Request', url('/requests/' . $req->id));
    }

    public function toArray($notifiable)
    {
        $req = $this->request->fresh(['employee']);

        $statusText = match ($req->raw_status) {
            1 => 'Approved',
            2 => 'Discarded',
            default => 'Pending',
        };

        return [
            'request_id' => $req->id,
            'type'       => $req->type,
            'status'     => $statusText,
            'title'      => "{$req->type} Request {$statusText}",
            'message'    => "Your {$req->type} request has been {$statusText}.",
            'url'        => url("/requests/{$req->id}"),
        ];
    }
}
