def format_time(number)
  minutes = number / 60
  seconds = number % 60
  sprintf("%02d:%02d", minutes, seconds)
end
