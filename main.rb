require 'securerandom'
require 'optparse'

INSTRUCTIONS=['>','<','+','-','.',',','[',']','0','1']

def _012c(lang,id,count)
	case lang
		when 'raw'
			return id*count
		when 'brainfuck'
			case id
				when '>','<','+','-','.',',','[',']'
					return id*count
				when '0'
					return '[-]'
				else
					return ''
			end
		when 'c'
			case id
				when 'START'
					return "#include<stdio.h>\nmain(){char d[30000],*p=d,s[30000],*a=s;"
				when '>'
					if count==1 then
						return 'p++;'
					else
						return "p+=#{count};"
					end
				when '<'
					if count==1 then
						return 'p--;'
					else
						return "p-=#{count};"
					end
				when '+'
					if count==1 then
						return '(*p)++;'
					else
						return "(*p)+=#{count};"
					end
				when '-'
					if count==1 then
						return '(*p)--;'
					else
						return "(*p)-=#{count};"
					end
				when '.'
					return 'putchar(*p);'*count
				when ','
					if count==1 then
						return 'scanf(\" %c\",&p);'
					elsif count==2 then
						return 'scanf(\" %c\",&p);scanf(\" %c\",&p);'
					else
						return "for(int i=0;i<#{count};i++)scanf(\" %c\",p);"
					end
				when '['
					return 'while(*p){'*count
				when ']'
					return '}'*count
				when '0'
					return '*p=0;'
				when '1'
					return 'p=d[0];'
				when 'END'
					return '}'
			end
		when 'c++'
			case id
				when 'START'
					return "#include <iostream>\nmain(){char d[30000],*p=d,s[30000],*a=s;"
				when '>'
					if count==1 then
						return 'p++;'
					else
						return "p+=#{count};"
					end
				when '<'
					if count==1 then
						return 'p--;'
					else
						return "p-=#{count};"
					end
				when '+'
					if count==1 then
						return '(*p)++;'
					else
						return "(*p)+=#{count};"
					end
				when '-'
					if count==1 then
						return '(*p)--;'
					else
						return "(*p)-=#{count};"
					end
				when '.'
					if count==1 then
						return "std::cout<<*p;"
					else
						return "std::cout<<std::string(#{count},*p);"
					end
				when ','
					if count==1 then
						return 'std::cin>>*p;'
					elsif count==2 then
						return 'std::cin>>*p;std::cin>>*p;'
					else
						return "for(int i=0;i<#{count};i++)std::cin>>*p;"
					end
				when '['
					return 'while(*p){'*count
				when ']'
					return '}'*count
				when '0'
					return '*p=0;'
				when '1'
					return 'p=d[0];'
				when 'END'
					return '}'
			end
	end
end
def _012(input,output,lang)
	id=0
	last=''
	count=0
	File.open(output,'w') do |f2|
		f2<<_012c(lang,'START',0)
		File.open(input,'r') do |f|
			while not f.eof?
				c=f.read(1)
				if c=='0' then
					if last=='1' then
						f2<<_012c(lang,INSTRUCTIONS[id],count)
						count=1
					end
					id+=id==INSTRUCTIONS.length-1?-id:1
				elsif c=='1' then
					if c==last or count==0 then
						count+=1
					end
				end
				last=c
			end
			if last=='1' then
				f2<<_012c(lang,INSTRUCTIONS[id],count)
				count=1
			end
		end
		f2<<_012c(lang,'END',0)
	end
end
def _201(input,output)
	last=0
	File.open(input,'r') do |f|
		File.open(output,'w') do |f2|
			while not f.eof?
				c=f.read(1)
				if not INSTRUCTIONS.include?(c) then
					next
				end
				i=INSTRUCTIONS.index(c)
				if last<=i then
					f2<<'0'*(i-last)
				else
					f2<<'0'*(INSTRUCTIONS.length-last+i)
				end
				f2<<'1'
				last=i
			end
		end
	end
end
def minify(input,output)
	pipe=SecureRandom.hex(32)
	_012(input,pipe,'raw')
	_201(pipe,output)
	File.delete(pipe)
end

OptionParser.new do |parser|
	options={}
	parser.on('-i','--input INPUT','Set INPUT file for program'){|x|options[:input]=x}
	parser.on('-o','--output OUTPUT','Set OUTPUT file for program'){|x|options[:output]=x}
	parser.on('-m', '--minify', 'Minify INPUT and get result in OUTPUT') do |x|
		if not options[:input] or not options[:output] then
			raise OptionParser::MissingArgument
		end
		minify(options[:input],options[:output])
	end
	parser.on('-c', '--convert LANG', 'Convert .zo file to other LANG file') do |x|
		if not options[:input] or not options[:output] then
			raise OptionParser::MissingArgument
		end
		_012(options[:input],options[:output],x)
	end
	parser.on('-g', '--generate', 'Convert ASCII to .zo file') do |x|
		if not options[:input] or not options[:output] then
			raise OptionParser::MissingArgument
		end
		_201(options[:input],options[:output])
	end
end.parse!