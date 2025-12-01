<?php

namespace App\Http\Middleware;

use App\Models\Employee;
use Illuminate\Http\Request;
use Inertia\Middleware;
use Tightenco\Ziggy\Ziggy;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that is loaded on the first page visit.
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determine the current asset version.
     */
    public function version(Request $request): string|null
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        return array_merge(parent::share($request), [
            'auth' => [
                'user' => $request->user() ? $request->user()->only('id', 'name', 'email')
                        + ["roles"=>$request->user()->getRoleNames()] : null,
                // latest 10 notifications (read and unread)
                'notifications' => $request->user()
                    ? $request->user()
                    ->notifications()
                    ->orderBy('created_at', 'desc')
                    ->take(10)
                    ->get()
                    ->map(function ($n) {
                        $data = is_array($n->data) ? $n->data : (array) json_decode($n->data, true);

                        $type = $data['type'] ?? 'Request';

                        // status mapping for legacy numeric values
                        $rawStatus = $data['status'] ?? null;

                        $statusText = match ($rawStatus) {
                            1, '1' => 'Approved',
                            2, '2' => 'Rejected',
                            0, '0' => 'Pending',
                            default => $rawStatus,
                        };

                        // title fallback
                        $title = $data['title'] ?? "{$type} Request";

                        // message fallback with mapped status
                        $message = $data['message']
                            ?? (
                                $rawStatus !== null
                                ? "Your {$type} request has been {$statusText}."
                                : "You have a {$type} notification."
                            );

                        // url fallback
                        $url = $data['url']
                            ?? (
                                !empty($data['request_id'])
                                ? route('requests.show', ['request' => $data['request_id']])
                                : null
                            );

                        return [
                            'id'         => $n->id,
                            'type'       => class_basename($n->type),
                            'title'      => $title,
                            'message'    => $message,
                            'data'       => $data,
                            'url'        => $url,
                            'read'       => (bool) $n->read_at,
                            'created_at' => $n->created_at->toDateTimeString(),
                        ];
                    })
                    : [],

                // unread count
                'unreadCount' => $request->user() ? $request->user()->unreadNotifications()->count() : 0,
            ],
            'ziggy' => function () use ($request) {
                return array_merge((new Ziggy)->toArray(), [
                    'location' => $request->url(),
                ]);
            },
            'ui' => [
                'empCount'=> Employee::count(),
                // Admin sees pending requests count in the sidebar, while employees see only updated requests count.
                'reqCount'=> $request->user() ? ( isAdmin() ? \App\Models\Request::where('status', 0)->count() :
                                        \App\Models\Request::where('employee_id', auth()->user()->id)
                                            ->where('status', '!=', 0)->where('is_seen', false)->count()) : null,
            ],
            'session' => [
                'update_in_progress' => session('update_in_progress'),
            ],
            'locale'=> config('app.locale'),
            'timezone'=> config('app.timezone'),
        ]);
    }
}
