W = 1280
L = 720

with open('output.mem', 'w+') as out:
	for i in range(1, (W*L)+1):

		# Slot in the middle pattern
		WINDOW = 200
		value = (hex(255)[2:] + ' ') if (W/2)-WINDOW <= (i%W) <= (W/2)+WINDOW else (hex(0)[2:] + ' ')
		out.write(value)