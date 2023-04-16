with open("out.tr", "r") as f:
    lines = f.readlines()

final_time = 0.0
dropped_packets = {}
sent_packets = {}

for line in lines:
    tokens = line.split()
    
    if tokens[0] == "d":
        user = int(tokens[7])
        if(user == 4):
            print("Dropped user is ", user)
        if user in dropped_packets:
            dropped_packets[user] += 1
        else:
            dropped_packets[user] = 1
    else:
        user = int(tokens[7])
        if(user == 4):
            print("User is ", user)
        if user in sent_packets:
            sent_packets[user] += 1
        else:
            sent_packets[user] = 1
        time = float(tokens[1])
        final_time = max(final_time, time)

for user in sent_packets.keys():
    for time in range(int(final_time)):
        if user in dropped_packets:
            ratio = float(dropped_packets[user]) / float(sent_packets[user])
            print("Degradation ratio for user", user, "at second", time, "is", ratio)
        else:
            print("Degradation ratio for user", user, "at second", time, "is 0.0")

#print("Printing", tokens)

#Check if there are any users who aren't being reported
for user in range(1, 5):
    if user not in dropped_packets and user not in sent_packets:
        print("User", user, "has no sent or dropped packets")

print("Final time:", final_time)
print("Dropped packets:", dropped_packets)
print("Sent packets:", sent_packets)