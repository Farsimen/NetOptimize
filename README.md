# NetOptimize

A lightweight, user-friendly script for optimizing network performance on Ubuntu servers using Traffic Control (tc). This script includes an interactive menu for installation, customization, and cleanup.

اسکریپتی سبک و آسان برای بهینه‌سازی عملکرد شبکه در سرورهای اوبونتو با استفاده از Traffic Control (tc). این اسکریپت شامل منویی تعاملی برای نصب، سفارشی‌سازی و پاک‌سازی است.

## Key Features / کاربردهای کلیدی

- Automatic detection of the main network interface. / شناسایی خودکار اینترفیس اصلی شبکه.
- Applies advanced queue disciplines: CAKE, FQ-CoDel, HTB+Netem. / اعمال صف‌های پیشرفته: CAKE, FQ-CoDel, HTB+Netem.
- Easy customization of bandwidth & RTT. / سفارشی‌سازی آسان پهنای باند و RTT.
- Full cleanup and rollback options. / گزینه‌های کامل پاک‌سازی و بازگشت به حالت اولیه.
- Sets cron job to auto-run on reboot. / تنظیم کرون جاب برای اجرای خودکار پس از ریبوت.
- Logs activities for monitoring. / ثبت لاگ‌ها برای نظارت.

## Automatic Installation / نصب اتوماتیک

Run the following command in your Ubuntu terminal as root:

```bash
bash <(curl -s https://raw.githubusercontent.com/Farsimen/NetOptimize/main/netoptimize.sh)
```

دستور زیر را در ترمینال اوبونتو به عنوان root اجرا کنید:

```bash
bash <(curl -s https://raw.githubusercontent.com/Farsimen/NetOptimize/main/netoptimize.sh)
```

## Usage / استفاده

Follow the menu options: 
- 1 for install and apply optimization / ۱ برای نصب و اعمال بهینه‌سازی
- 2 for customize bandwidth and RTT / ۲ برای سفارشی‌سازی پهنای باند و RTT
- 3 for clean all settings / ۳ برای پاک‌سازی همه تنظیمات
- 4 to exit / ۴ برای خروج

To check status, use: `tc qdisc show` and view logs at `/var/log/tc_smart.log`.

برای چک وضعیت، از `tc qdisc show` استفاده کنید و لاگ‌ها را در `/var/log/tc_smart.log` ببینید.

## Warnings / هشدارها

- Review script content before running. / محتوای اسکریپت را قبل از اجرا بررسی کنید.
- If conflicts with other tools, use cleanup option. / در صورت تداخل با ابزارهای دیگر، از گزینه پاک‌سازی استفاده کنید.
- Designed for long-term stability. / طراحی شده برای پایداری بلندمدت.

This script is optimized for reliability – good luck! 😊

این اسکریپت برای پایداری بهینه‌سازی شده – موفق باشید! 😊
