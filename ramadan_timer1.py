import time
import os
from datetime import datetime, timedelta

# Set Ramadan start date
ramadan_start = datetime(2025, 3, 2)

# Initial prayer times
prayer_times = {
    "Fajr": "05:19",
    "Shuruq": "07:12",
    "Dhuhr": "12:41",
    "Asr": "16:16",
    "Maghrib": "18:10",
    "Isha": "19:56",
    "Suhoor": "05:00",
    "Iftar": "18:30"
}

# Convert times to datetime objects
def get_prayer_times():
    return {name: datetime.strptime(time_str, "%H:%M").time() for name, time_str in prayer_times.items()}

prayer_times_today = get_prayer_times()

# Function to increment prayer times daily at midnight
def increment_prayer_times():
    global prayer_times_today
    prayer_times_today = {
        name: (datetime.combine(datetime.today(), time) + timedelta(minutes=1)).time()
        for name, time in prayer_times_today.items()
    }

# Function to calculate time left for each prayer
def get_time_left():
    now = datetime.now()
    time_left = {}

    for name, prayer_time in prayer_times_today.items():
        event_time = datetime.combine(now.date(), prayer_time)

        if now > event_time:
            event_time += timedelta(days=1)  # Move to next day if already passed

        time_left[name] = event_time - now

    return time_left

# Function to display prayer times and countdowns
def display_prayers_and_countdowns():
    last_update_day = datetime.today().day  # Track the day to update times

    while True:
        now = datetime.now()

        # Increment prayer times at midnight
        if now.day != last_update_day:
            increment_prayer_times()
            last_update_day = now.day

        os.system("clear")  # Clear screen for smooth display

        print("\n🕰️ **Ramadan Prayer Times:**\n")
        time_left = get_time_left()

        for name, prayer_time in prayer_times_today.items():
            remaining_time = str(time_left[name]).split('.')[0]  # Remove milliseconds
            print(f"🪬 {name}: {prayer_time.strftime('%H:%M')}")
            print(f"   ⏳ Time left: {remaining_time}\n")

        time.sleep(1)  # Update every second

# Run program
display_prayers_and_countdowns()

