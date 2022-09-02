function timeStr = genTimeString()
timeVec = clock;
timeStr = [num2str(timeVec(2)) '_' num2str(timeVec(3)) '_' num2str(timeVec(4)) '_' num2str(timeVec(5))];
