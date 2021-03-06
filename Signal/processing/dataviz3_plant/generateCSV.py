import glob
import csv
import re
import os

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
            n = line.replace("\n", "")
            n = n.split(" ")[2]
            numbers.append(int(n))
        obj[fileName] = numbers;
    return obj


def outputCSV(obj):
    with open('02.15.csv', 'w', newline='') as file:
        fieldnames = ['time','data', 'avg']
        writer = csv.DictWriter(file, fieldnames=fieldnames)
        writer.writeheader()
        for key in obj:
            avg = sum(obj[key])/len(obj[key])
            writer.writerow({'time': key,
            'avg':avg,
            'data': " ".join(str(obj[key]))})
            if("29_" in key):
                print("\"" + str(key) + "\":")
                print(obj[key])
                print(",")

def dateFormat(files):
    for i, file in enumerate(files):
        txt_files[i] = re.sub('_([0-9])_', r'_0\1_', file)
        os.rename(file, txt_files[i])

txt_files = glob.glob("data/*.txt")
#dateFormat(txt_files)
txt_files.sort()
#print(txt_files)
obj = getObj(txt_files)
outputCSV(obj)
