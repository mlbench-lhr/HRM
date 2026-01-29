<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to {{ $orgName }}</title>
    <style>
        /* Fallback for fonts */
        body {
            margin: 0;
            padding: 0;
            background-color: #f4f7fa;
            font-family: 'Figtree', ui-sans-serif, system-ui, sans-serif;
            color: #374151;
        }

        .wrapper {
            width: 100%;
            table-layout: fixed;
            background-color: #f4f7fa;
            padding-bottom: 40px;
        }

        .main {
            background-color: #ffffff;
            margin: 0 auto;
            width: 100%;
            max-width: 600px;
            border-spacing: 0;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .header {
            background-color: #7c3aed;
            /* Purple 600 - Your Theme Color */
            padding: 30px;
            text-align: center;
            color: #ffffff;
        }

        .content {
            padding: 40px 30px;
            line-height: 1.6;
        }

        .credentials-box {
            background-color: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            padding: 20px;
            margin: 25px 0;
        }

        .button-wrapper {
            text-align: center;
            margin: 30px 0;
        }

        .button {
            background-color: #7c3aed;
            color: #ffffff !important;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 9999px;
            font-weight: 600;
            display: inline-block;
        }

        .footer {
            text-align: center;
            padding: 20px;
            font-size: 12px;
            color: #6b7280;
        }
    </style>
</head>

<body>
    <div class="wrapper">
        <table class="main">
            <tr>
                <td class="header">
                    <h1 style="margin: 0; font-size: 24px;">{{ $orgName }}</h1>
                </td>
            </tr>

            <tr>
                <td class="content">
                    <p style="font-size: 18px; font-weight: 600; margin-top: 0;">Hello {{ $credentials['name'] }},</p>
                    <p>Welcome to the team! You have been successfully registered as an employee at
                        <strong>{{ $orgName }}</strong>.
                    </p>

                    <p>You can access your employee dashboard using the credentials below:</p>

                    <div class="credentials-box">
                        <p style="margin: 0 0 10px 0;"><strong>Username:</strong> {{ $credentials['email'] }}</p>
                        <p style="margin: 0;"><strong>Password:</strong> <code
                                style="background: #e5e7eb; padding: 2px 4px; border-radius: 3px;">{{ $credentials['password'] }}</code>
                        </p>
                    </div>

                    <div class="button-wrapper">
                        <a href="{{ config('app.url') }}" class="button">Log In to Dashboard</a>
                    </div>

                    <p style="font-size: 14px; color: #6b7280;"><em>Note: We highly recommend that you change your
                            password immediately after your first login for security purposes.</em></p>

                    <hr style="border: 0; border-top: 1px solid #e5e7eb; margin: 30px 0;">

                    <p>If you have any questions or concerns, please feel free to submit a <strong>Complaint
                            Request</strong> once you're logged into your account.</p>

                    <p>Thank you,<br><strong>The {{ $orgName }} Team</strong></p>
                </td>
            </tr>

            <tr>
                <td class="footer">
                    &copy; {{ date('Y') }} {{ $orgName }}. All rights reserved.<br>
                    This is an automated message, please do not reply to this email.
                </td>
            </tr>
        </table>
    </div>
</body>

</html>
