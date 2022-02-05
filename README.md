# COwin Script

Main Cowin APIs and schemas: https://apisetu.gov.in/public/marketplace/api/cowin

The script contains only the scanner. To notify you need to use a 3rd application interface or API.
I used a 3rd party cloud server or your cloud server which pushes notification to specific devices.
Example: I used https://github.com/mashlol/notify for android.

Just modify the `$vaccine_pin` from the script file.
Example: If you would like to scan for specifix pin codes, then just enter it in the list.

The below line is used to call a second script which contains code for whom to notify, and various other filters.

`source ./notify.sh "$pincode:$Search2" $vaccine $available_cnt $min_age_limit &`

Hope this helps!!

<h1 align="center">Support</h1>
<h2 align="center">

  [![Support via PayPal](https://cdn.rawgit.com/twolfson/paypal-github-button/1.0.0/dist/button.svg)](https://www.paypal.me/abhinandanbr/)    <a href="https://www.buymeacoffee.com/roniemartinez" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

</h2>
