```
# NetOptimize / نت‌بهینه‌ساز

A lightweight, user-friendly script for optimizing network performance on Ubuntu servers via Linux Traffic Control (`tc`).

اسکریپتی سبک و آسان برای بهینه‌سازی عملکرد شبکه در سرورهای اوبونتو با استفاده از Linux Traffic Control (`tc`).

## Features / امکانات
- Auto-detects the main network interface. / شناسایی خودکار اینترفیس اصلی شبکه
- Applies advanced queue disciplines: CAKE, FQ-CoDel, HTB+Netem. / اعمال صف‌های پیشرفته CAKE، FQ-CoDel و HTB+Netem
- One-click customization of bandwidth & RTT. / امکان سفارشی‌سازی پهنای باند و RTT
- Full cleanup / rollback option. / امکان پاک‌سازی کامل و بازگشت به حالت اولیه
- Installs a cron job to re-apply tweaks after reboot. / نصب کرون جاب برای اجرای خودکار بعد از ریبوت
- Writes logs to /var/log/tc_smart.log. / ذخیره لاگ‌ها در /var/log/tc_smart.log

## Quick Install / نصب سریع

Run the following command as root on your Ubuntu server:

```
bash <(curl -s https://raw.githubusercontent.com/Farsimen/NetOptimize/main/netoptimize.sh)
```

دستور زیر را به عنوان کاربر root در سرور اوبونتو اجرا کنید:

```
bash <(curl -s https://raw.githubusercontent.com/Farsimen/NetOptimize/main/netoptimize.sh)
```

## Menu Guide / راهنمای منو

| Option / گزینه | Action / عملیات |
|----------------|-----------------|
| 1              | Install & apply optimization / نصب و اعمال بهینه‌سازی |
| 2              | Customize bandwidth & RTT / سفارشی‌سازی پهنای باند و RTT |
| 3              | Clean all settings / پاک‌سازی همه تنظیمات |
| 4              | Exit / خروج |

## Notes / نکات

- Requires root privileges. / نیاز به دسترسی روت
- Auto-runs 30s after reboot via cron. / اجرای خودکار بعد از 30 ثانیه از ریبوت با کرون
- Check logs at /var/log/tc_smart.log for troubleshooting. / برای رفع مشکل لاگ‌ها را در /var/log/tc_smart.log بررسی کنید

---

Happy tweaking! / به بهینه‌سازی خوش آمدید! 🚦
```
