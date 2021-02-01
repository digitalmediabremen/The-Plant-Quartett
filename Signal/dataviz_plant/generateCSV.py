import glob
import csv
import re

def getObj(txt_files):
    obj = {}
    for fileName in txt_files:
        file = open(fileName, 'r')
        fileName = fileName.replace(".txt", "");
        fileName = fileName.replace("longTerm/-", "");
        #fileName = fileName.replace(//g, "_0" + $1 + "_");
        lines = file.readlines()
        numbers = [];
        for line in lines:
            n = line.replace("\n", "");
            numbers.append(int(n))
        obj[fileName] = numbers;
    return obj


def outputCSV(obj):
    with open('01.28-30.csv', 'w', newline='') as file:
        fieldnames = ['time','data', 'avg']
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        for key in obj:
            writer.writerow({'time': key,
            'avg':sum(obj[key])/len(obj[key]),
            'data': " ".join(str(obj[key]))})


txt_files = glob.glob("longTerm/*.txt")
for i, file in txt_files:
    txt_files[i] = re.sub('_([0-9])_', r'_0\1_', f);
txt_files.sort()
#print(txt_files)
obj = getObj(txt_files)
print(obj)
# outputCSV(obj)