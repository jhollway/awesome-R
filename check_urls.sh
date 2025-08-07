#!/bin/bash
while IFS= read -r url; do
  curl -o /dev/null --connect-timeout 10 --max-time 30 -s -L -w "%{http_code} %{url_effective}\n" "$url"
done < all_urls.txt > url_status.txt
