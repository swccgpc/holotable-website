#!/usr/bin/env ruby




def indexpage(filename, permalink, subpages)
  fh = File.open("_news_indexes/"+filename+".html", "w")
  fh.write("---\n")
  fh.write("layout: holotable\n")
  fh.write('title: News "'+permalink+'"'+"\n")
  fh.write("permalink: /news/"+permalink+"/\n")
  fh.write("---\n\n")
  fh.write("<h2>"+permalink+" News</h2>\n\n")
  fh.write("<ul>\n")
  subpages.sort.each do |subpage|
    out = permalink + "/" + subpage
    fh.write('<li><a href="/news/' + out + '">' + out + "</a></li>\n")
  end
  fh.write("</ul>\n")
  fh.close()
end

alldates = Hash.new

`rm _news_indexes/*`
posts = `find _posts/ -type f`
posts.split(/[\r\n]+/).each do |post|

  #post = "_posts/2011-03-07-news.html"
  post = post.gsub("_posts/", "")
  post = post.split("-")
  if (alldates[post[0]].class == NilClass)
    alldates[post[0]] = Hash.new
  end
  if (alldates[post[0]][post[1]].class == NilClass)
    alldates[post[0]][post[1]] = Array.new
  end
  if (! alldates[post[0]][post[1]].include?(post[2]))
    alldates[post[0]][post[1]] << post[2]
  end

end

puts alldates

alldates.each do |y, m|

  puts y + " (y)"
  indexpage(y, y, alldates[y].keys)
  m.each do |mm, dd|
    puts y+"_"+mm + " ("+y+"/"+mm+")"
    indexpage(y+"_"+mm, y+"/"+mm, alldates[y][mm])
    #dd.each do |ddd|
      #puts y+"_"+mm+"_"+ddd + " ("+y+"/"+mm+"/"+ddd+")"
      #indexpage(y+"_"+mm+"_"+ddd, y+"/"+mm+"/"+ddd)
    #end
  end

end

