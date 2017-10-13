# -*- coding: utf-8 -*-
"""
Created on Fri Jul 14 10:51:35 2017

@author: tangshihua
"""
from urllib.request import urlopen
from bs4 import BeautifulSoup
import requests
import re
import time
import sys
import urllib
import codecs
import jieba
import jieba.analyse as analyse
from wordcloud import WordCloud
from scipy.misc import imread
s = requests.Session()
url1 = 'https://accounts.douban.com/login'
url2 = 'https://movie.douban.com/subject/26387939/comments?sort=new_score&status=P'

formdata={
  "redir":"https://www.douban.com/",
  "form_email":"15627868532",
  "form_password":"ll19960918",
  #'captcha-solution':'blood',
  #'captcha-id':'cRPGXEYPFHjkfv3u7K4Pm0v1:en',
  "login":u"登录"
  } 

headers = {
  "user-agent":"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36"
#"Location": "https://accounts.douban.com/login"
  }
 
r1 = s.post(url1,data=formdata,headers=headers)      #发送登录请求
rcontent = r1.text

soup = BeautifulSoup(rcontent,"html.parser")

#如需验证码
captchaAddr = soup.find('img',id='captcha_image')['src']
if captchaAddr != None:
    reCaptchaID = r'<input type="hidden" name="captcha-id" value="(.*?)"/'
    captchaID = re.findall(reCaptchaID,rcontent)
    print(captchaID)
    urllib.request.urlretrieve(captchaAddr,"captcha.jpg")
    captcha = input('please input the captcha:')
    formdata['captcha-solution'] = captcha
    formdata['captcha-id'] = captchaID
    r1 = s.post(url1,data=formdata,headers=headers)      

