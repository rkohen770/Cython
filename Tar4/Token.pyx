import os
keywords=["class","constructor","function","method","field","static","var","int","char","boolean","void","true","false","null","this","let","do","if","else","while","return"]
symbols=["{","}","(",")","[","]",".",",",";","+","-","*","/","&","|","<",">","=","~"]
op=["+","-","*","/","&","|","<",">","="]

class Token:
    def __init__(self,nameFile):
        if nameFile.endswith(".pyx"):
            self.fdi = open(nameFile, "r")
        else:
            print ("error")
        self.fdo=open(nameFile[:-5]+"Tokens.xml","w")

    def Tokenizing(self):
        self.fdo.write("<tokens>\n")
        flag=True
        for line in self.fdi.readlines():
            #print line
            if flag:
                if line!='\n':
                    if not "//" in line:
                        if not "/**" in line:
                            self.addLine(line)
                        else:
                            if not "*/" in line:
                                flag=False
                    elif not line.startswith("//"):
                        self.addLine(line[:line.find("//")])
            else:
                if "*/" in line:
                    flag=True
        self.fdo.write("</tokens>\n")
        self.fdo.close()
        self.fdi.close()

    def addLine(self,line):
        word=""
        flag=False
        for tav in line:
            if tav in symbols  and not flag:
                self.tipulInWord(word)
                if tav=='<'  and not flag:
                    self.fdo.write("<symbol> &lt; </symbol>\n")
                elif tav=='&'  and not flag:
                    self.fdo.write("<symbol> &amp; </symbol>\n")
                elif tav=='>'  and not flag:
                    self.fdo.write("<symbol> &gt; </symbol>\n")
                else:
                    self.fdo.write("<symbol> " +tav+" </symbol>\n")
                word=""
            elif tav==' ' and not flag:
                self.tipulInWord(word)
                word=""
            elif tav=='/t' and not flag:
                self.tipulInWord(word)
                word=""
            elif tav=='"':
                if flag:
                    self.fdo.write("<stringConstant> " +word+" </stringConstant>\n")
                    flag=False
                    word=""
                else:
                    flag=True
            else:
                word=word+tav

    def tipulInWord(self,word):
        #print "tipulInWord:", word
        if word==" " or word=="\t" or word=="" or word.strip()=="":
            return
        if word in keywords:
            self.fdo.write("<keyword> " +word+" </keyword>\n")
        else:
            try:
                #print "not keywords:", word
                value = int(word)
                self.fdo.write("<integerConstant> " +word+" </integerConstant>\n")
            except ValueError:
                #print "not number:", word
                self.fdo.write("<identifier> " +word+" </identifier>\n")
				
dir="C:\\Users\\hoday\\source\\repos\\Cython\\Cython\\Tar4"
#dir="ArrayTest"
#dir="ExpressionlessSquare"
#dir="Square"
flag_isDir=True
if(flag_isDir):
    for f1 in os.listdir(dir):
        if (f1.endswith(".pyx")):
            j=Token(dir+"/"+f1)
            j.Tokenizing()