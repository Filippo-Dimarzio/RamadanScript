import time
from datetime import datetime, timedelta

# Set Ramadan start date (adjust the year if needed)
ramadan_start = datetime(2025, 3, 2)

# Set daily prayer times (Example: Adjust for your city)
fajr_time = "05:19"    
shuruq_time = "07:12"  #  (sunrise)
dhuhr_time = "12:41"   # Example: 12:41 PM
asr_time = "16:16"     # Example: 4:16 PM
maghrib_time = "18:10" # Example: 6:10 PM
isha_time = "19:56"    # Example: 7:56 PM
suhoor_time = "05:00"  # Example: 5:00 AM
iftar_time = "18:30"   # Example: 6:30 PM

# Convert to datetime
fajr = datetime.strptime(fajr_time, "%H:%M").time()
shuruq = datetime.strptime(shuruq_time, "%H:%M").time()
dhuhr = datetime.strptime(dhuhr_time, "%H:%M").time()
asr = datetime.strptime(asr_time, "%H:%M").time()
maghrib = datetime.strptime(maghrib_time, "%H:%M").time()
isha = datetime.strptime(isha_time, "%H:%M").time()
suhoor = datetime.strptime(suhoor_time, "%H:%M").time()
iftar = datetime.strptime(iftar_time, "%H:%M").time()

# Function to add 1 minute to each prayer time every day
def increment_prayer_times():
    global fajr, shuruq, dhuhr, asr, maghrib, isha, suhoor, iftar
    
    fajr = (datetime.combine(datetime.today(), fajr) + timedelta(minutes=1)).time()
    shuruq = (datetime.combine(datetime.today(), shuruq) + timedelta(minutes=1)).time()
    dhuhr = (datetime.combine(datetime.today(), dhuhr) + timedelta(minutes=1)).time()
    asr = (datetime.combine(datetime.today(), asr) + timedelta(minutes=1)).time()
    maghrib = (datetime.combine(datetime.today(), maghrib) + timedelta(minutes=1)).time()
    isha = (datetime.combine(datetime.today(), isha) + timedelta(minutes=1)).time()
    suhoor = (datetime.combine(datetime.today(), suhoor) + timedelta(minutes=1)).time()
    iftar = (datetime.combine(datetime.today(), iftar) + timedelta(minutes=1)).time()

# Ramadan Countdown
def ramadan_countdown():
    today = datetime.today()
    days_left = (ramadan_start - today).days
    print(f"🌙 Days until Ramadan: {days_left} days")

# Display all prayer times
def display_prayer_times():
    print(f"🕰️ Today's Prayer Times:")
    print(f"🙏  Fajr: {fajr_time}")
    print(f"🙏  Shuruq (Sunrise): {shuruq_time}")
    print(f"🙏  Dhuhr: {dhuhr_time}")
    print(f"🙏  Asr: {asr_time}")
    print(f"🙏  Maghrib: {maghrib_time}")
    print(f"🙏  Isha: {isha_time}")
    print(f"🙏  Suhoor: {suhoor_time}")
    print(f"🙏  Iftar: {iftar_time}")
    print("-" * 30)

# Countdown for each prayer time
def countdown_to_event(event_time, event_name):
    now = datetime.now().time()
    event_time = datetime.combine(datetime.today(), event_time)

    if now > event_time.time():
        event_time = datetime.combine(datetime.today(), event_time.time()) + timedelta(days=1)

    time_left = event_time - datetime.now()
    return f"{event_name}: {str(time_left).split('.')[0]}"

# Display all the timers for each prayer time
def display_all_timers():
    events = [
        ("🪬Fajr", fajr),
        ("🪬Shuruq", shuruq),
        ("🪬Dhuhr", dhuhr),
        ("🪬Asr", asr),
        ("🪬Maghrib", maghrib),
        ("🪬Isha", isha),
        ("🪬Suhoor", suhoor),
        ("🪬Iftar", iftar)
    ]
    
    while True:
        timers = []
        for event, event_time in events:
            timers.append(countdown_to_event(event_time, event))

        print("\033c", end="")  # Clear the console
        print("\n⏳ Time until next events:")
        for timer in timers:
            print(timer)
        
        increment_prayer_times()  # Increment prayer times by 1 minute every day
        time.sleep(86400)  # Wait for 24 hours before updating prayer times (86400 seconds = 1 day)

# Run the timers and prayer display
ramadan_countdown()
display_prayer_times()
display_all_timers()

#!/bin/bash
python3 ~/scripts/ramadan_timer.py

