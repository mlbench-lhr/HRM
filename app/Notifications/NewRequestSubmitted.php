<?php

namespace App\Notifications;

use App\Models\Request;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\MailMessage;

class NewRequestSubmitted extends Notification
{
    use Queueable;

    public function __construct(public Request $request) {}

    public function via($notifiable)
    {
        return ['mail', 'database'];
    }

    public function toMail($notifiable)
    {
        return (new MailMessage)
            ->subject('New Request Submitted')
            ->line("A new {$this->request->type} request was submitted.")
            ->line("Employee: " . $this->request->employee->name)
            ->line("Message: " . $this->request->message)
            ->action('Open Requests Panel', url('/admin/requests'));
    }

    public function toArray($notifiable)
    {
        $req = $this->request->fresh(['employee']);

        $isEmployee = $notifiable->id === $req->employee_id;

        if ($isEmployee) {
            return [
                'request_id' => $req->id,
                'type'       => $req->type,
                'title'      => "Request Submitted",
                'message'    => "You applied for a {$req->type} request.",
                'url'        => url("/requests/{$req->id}"),
            ];
        }

        return [
            'request_id' => $req->id,
            'type'       => $req->type,
            'title'      => "New {$req->type} Request",
            'message'    => "A new {$req->type} request was submitted by {$req->employee->name}.",
            'url'        => url("/requests/{$req->id}"),
        ];
    }
}
