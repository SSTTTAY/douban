import jieba
import codecs
import jieba.analyse as analyse
from wordcloud import WordCloud
from scipy.misc import imread
from os import path


#结巴分词获取关键字
def get_top_keywords(file_name):
    top_word_lists = [] # 关键词列表
    with codecs.open(file_name,'r',encoding='utf-8') as f:
        texts = f.read() # 读取整个文件作为一个字符串
        Result = analyse.textrank(texts,topK=20,withWeight=True,withFlag=True)
        n = 1
        for result in Result:
            print (u"%d:" % n ,)
            for C in result[0]: # result[0] 包含关键词和词性
                print( C,u"  ",)
            print (u"权重:"+ unicode(result[1])) # 关键词权重
            n += 1

#制作词云
def draw_wordcloud():
   with codecs.open('pjl_comment.txt',encoding='utf-8') as f:
       comment_text = f.read()
   cut_text = " ".join(jieba.cut(comment_text)) # 将jieba分词得到的关键词用空格连接成为字符串
   d = path.dirname(__file__) # 当前文件文件夹所在目录
   color_mask = imread("F:/python2.7work/wordcloud/alice_color.png") # 读取背景图片
   cloud = WordCloud(font_path=path.join(d,'simsun.ttc'),background_color='white',mask=color_mask,max_words=2000,max_font_size=40)
   word_cloud = cloud.generate(cut_text) # 产生词云
   word_cloud.to_file("pjl_cloud.jpg")
