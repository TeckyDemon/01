require 'securerandom'
require 'optparse'

COMMANDS=['>','<','+','-','.',',','[',']','0','1','x','X','c','C','m']

ERROR_NOT_IMPLEMENTED='Command "%s" not implemented in "%s".'
ERROR_NOT_SUPPORTED='Language "%s" is not supported.'

def error(e)
	abort('Error: %s'%e)
end
def _012c(lang,id,count)
	case lang
		when 'raw'
			return id*count
		when 'brainfuck'
			case id
				when 'START','END'
					return ''
				when '>','<','+','-','.',',','[',']'
					return id*count
				when '0'
					return '[-]'
				when 'c'
					return '>[-]>[-]<<[>+>+<<-]>>[-<<+>>]<<'
				when 'm'
					return '[>+<-]'
				else
					error(ERROR_NOT_IMPLEMENTED%[id,lang])
			end
		when 'blub'
			case id
				when 'START','END'
					return ''
				when '>'
					return 'Blub. Blub?'*count
				when '<'
					return 'Blub? Blub.'*count
				when '+'
					return 'Blub. Blub.'*count
				when '-'
					return 'Blub! Blub!'*count
				when '.'
					return 'Blub! Blub.'*count
				when ','
					return 'Blub. Blub!'*count
				when '['
					return 'Blub! Blub?'*count
				when ']'
					return 'Blub? Blub!'*count
				when '0'
					return 'Blub! Blub? Blub! Blub! Blub? Blub!'
				when 'c'
					return 'Blub. Blub? Blub! Blub? Blub! Blub! Blub? Blub! Blub. Blub? Blub! Blub? Blub! Blub! Blub? Blub! Blub? Blub. Blub? Blub. Blub! Blub? Blub. Blub? Blub. Blub. Blub. Blub? Blub. Blub. Blub? Blub. Blub? Blub. Blub! Blub! Blub? Blub! Blub. Blub? Blub. Blub? Blub! Blub? Blub! Blub! Blub? Blub. Blub? Blub. Blub. Blub. Blub. Blub? Blub. Blub? Blub? Blub! Blub? Blub. Blub? Blub.'
				when 'm'
					return 'Blub! Blub? Blub. Blub? Blub. Blub. Blub? Blub. Blub! Blub! Blub? Blub!'
				else
					error(ERROR_NOT_IMPLEMENTED%[id,lang])
			end
		when 'ook!'
			case id
				when 'START','END'
					return ''
				when '>'
					return 'Ook. Ook?'*count
				when '<'
					return 'Ook? Ook.'*count
				when '+'
					return 'Ook. Ook.'*count
				when '-'
					return 'Ook! Ook!'*count
				when '.'
					return 'Ook! Ook.'*count
				when ','
					return 'Ook. Ook!'*count
				when '['
					return 'Ook! Ook?'*count
				when ']'
					return 'Ook? Ook!'*count
				when '0'
					return 'Ook! Ook? Ook! Ook! Ook? Ook!'
				when 'c'
					return 'Ook. Ook? Ook! Ook? Ook! Ook! Ook? Ook! Ook. Ook? Ook! Ook? Ook! Ook! Ook? Ook! Ook? Ook. Ook? Ook. Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook? Ook. Ook. Ook? Ook. Ook? Ook. Ook! Ook! Ook? Ook! Ook. Ook? Ook. Ook? Ook! Ook? Ook! Ook! Ook? Ook. Ook? Ook. Ook. Ook. Ook. Ook? Ook. Ook? Ook? Ook! Ook? Ook. Ook? Ook.'
				when 'm'
					return 'Ook! Ook? Ook. Ook? Ook. Ook. Ook? Ook. Ook! Ook! Ook? Ook!'
				else
					error(ERROR_NOT_IMPLEMENTED%[id,lang])
			end
		when '*brainfuck'
			case id
				when 'START','END'
					return ''
				when '>'
					return '>+'*count
				when '<'
					return '>-'*count
				when '+'
					return '<+'*count
				when '-'
					return '<-'*count
				when '.'
					return '<.'*count
				when ','
					return '<,'*count
				when '['
					return '<['*count
				when ']'
					return ']'*count
				when '0'
					return '<[<-]'
				when 'c'
					return '>+<[<-]>+<[<-]>->-<[>+<+>+<+>->-<-]>+>+<[<->->-<+>+>+]>->-'
				when 'm'
					return '<[>+<+>-<-]'
				else
					error(ERROR_NOT_IMPLEMENTED%[id,lang])
			end
		when 'binaryfuck'
			case id
				when 'START','END'
					return ''
				when '>'
					return '010'*count
				when '<'
					return '011'*count
				when '+'
					return '000'*count
				when '-'
					return '001'*count
				when '.'
					return '100'*count
				when ','
					return '101'*count
				when '['
					return '110'*count
				when ']'
					return '111'*count
				when '0'
					return '110001111'
				when 'c'
					return '010110001111010110001111011011110010000010000011011001111010010110001011011000010010111011011'
				when 'm'
					return '110010000011001111'
				else
					error(ERROR_NOT_IMPLEMENTED%[id,lang])
			end
		when 'c'
			case id
				when 'START'
					return "#include<stdio.h>#include<stdlib.h>\nmain(){char d[30000],*p=d;"
				when '>'
					if count==1 then
						return '++p;'
					else
						return "p+=#{count};"
					end
				when '<'
					if count==1 then
						return '--p;'
					else
						return "p-=#{count};"
					end
				when '+'
					if count==1 then
						return '++*p;'
					else
						return "(*p)+=#{count};"
					end
				when '-'
					if count==1 then
						return '--*p;'
					else
						return "(*p)-=#{count};"
					end
				when '.'
					if count<=2 then
						return 'putchar(*p);'*count
					else
						return "for(int i=#{count};i--;)putchar(*p);"
					end
				when ','
					if count<=2 then
						return 'scanf(\" %c\",&p);'*count
					else
						return "for(int i=#{count};i--;)scanf(\" %c\",p);"
					end
				when '['
					return 'while(*p){'*count
				when ']'
					return '}'*count
				when '0'
					return '*p=0;'
				when '1'
					return 'p=d[0];'
				when 'x'
					return 'exit(0);'
				when 'X'
					return 'exit(*p);'
				when 'c'
					return '*(p+1)=*p;*(p+2)=0;'
				when 'C'
					return '*(p+1)=*p;'
				when 'm'
					return '*(p+1)=*p;*p=0;'
				when 'END'
					return '}'
				else
					error(ERROR_NOT_IMPLEMENTED%[id,lang])
			end
		when 'c++'
			case id
				when 'START'
					return "#include <iostream>\nmain(){unsigned char d[30000],*p=d;"
				when '>'
					if count==1 then
						return '++p;'
					else
						return "p+=#{count};"
					end
				when '<'
					if count==1 then
						return '--p;'
					else
						return "p-=#{count};"
					end
				when '+'
					if count==1 then
						return '++*p;'
					else
						return "(*p)+=#{count};"
					end
				when '-'
					if count==1 then
						return '--*p;'
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
					if count<=2 then
						return 'std::cin>>*p;'*count
					else
						return "for(int i=#{count};i--;)std::cin>>*p;"
					end
				when '['
					return 'while(*p){'*count
				when ']'
					return '}'*count
				when '0'
					return '*p=0;'
				when '1'
					return 'p=d[0];'
				when 'x'
					return 'exit(0);'
				when 'X'
					return 'exit(*p);'
				when 'c'
					return '*(p+1)=*p;*(p+2)=0;'
				when 'C'
					return '*(p+1)=*p;'
				when 'm'
					return '*(p+1)=*p;*p=0;'
				when 'END'
					return '}'
				else
					error(ERROR_NOT_IMPLEMENTED%[id,lang])
			end
		when 'ruby'
			case id
				when 'START'
					return 'd=[0]*3e4;p=0;'
				when '>'
					return "p+=#{count};"
				when '<'
					return "p-=#{count};"
				when '+'
					return "d[p]+=d[p]+#{count}<256?#{count}:-d[p];"
				when '-'
					return "d[p]-=d[p]-#{count}>=0?#{count}:d[p]-255;"
				when '.'
					if count==1 then
						return 'print d[p].chr;'
					else
						return "print d[p].chr*#{count};"
					end
				when ','
					if count==1 then
						return 'd[p]=gets.ord;'
					elsif count==2 then
						return 'gets;d[p]=gets.ord;'
					else
						return "#{count-1}.times{gets};d[p]=gets.ord;"
					end
				when '['
					return 'while d[p]>0;'*count
				when ']'
					return 'end;'*count
				when '0'
					return 'd[p]=0;'
				when '1'
					return 'p=0;'
				when 'x'
					return 'exit;'
				when 'X'
					return 'exit(d[p]);'
				when 'c'
					return 'd[p+1]=d[p];d[p+2]=0;'
				when 'C'
					return 'd[p+1]=d[p];'
				when 'm'
					return 'd[p+1]=d[p];d[p]=0;'
				when 'END'
					return ''
			end
		else
			error(ERROR_NOT_SUPPORTED%lang)
	end
end
def _012(input,output,lang)
	id=0
	last=''
	count=0
	File.open(output,'w+') do |f2|
		f2<<_012c(lang,'START',0)
		File.open(input,'r') do |f|
			while not f.eof?
				c=f.read(1)
				if c=='0' then
					if last=='1' then
						f2<<_012c(lang,COMMANDS[id],count)
						count=1
					end
					id+=id==COMMANDS.length-1?-id:1
				elsif c=='1' then
					if c==last or count==0 then
						count+=1
					end
				end
				last=c
			end
			if last=='1' then
				f2<<_012c(lang,COMMANDS[id],count)
				count=1
			end
		end
		f2<<_012c(lang,'END',0)
	end
end
def _201(input,output)
	last=0
	File.open(input,'r') do |f|
		File.open(output,'w+') do |f2|
			while not f.eof?
				c=f.read(1)
				if not COMMANDS.include?(c) then
					next
				end
				i=COMMANDS.index(c)
				if last<=i then
					f2<<'0'*(i-last)
				else
					f2<<'0'*(COMMANDS.length-last+i)
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
def to_hex(input,output)
	File.open(output,'w+').write(File.open(input,'r').read().to_i(2).to_s(16).upcase)
end

OptionParser.new do |parser|
	options={}
	parser.on('-i','--input INPUT','Set path to input file'){|x|options[:input]=x}
	parser.on('-o','--output OUTPUT','Set path to output file'){|x|options[:output]=x}
	parser.on('-c','--convert LANG','Convert *.zo file to other language source file') do |x|
		if not options[:input] or not options[:output] then
			raise OptionParser::MissingArgument
		end
		_012(options[:input],options[:output],x)
	end
	parser.on('-g','--generate','Convert *.tzo to *.zo file') do |x|
		if not options[:input] or not options[:output] then
			raise OptionParser::MissingArgument
		end
		_201(options[:input],options[:output])
	end
	parser.on('-m','--minify','Minify *.zo file') do |x|
		if not options[:input] or not options[:output] then
			raise OptionParser::MissingArgument
		end
		minify(options[:input],options[:output])
	end
	parser.on('-h','--hex','Convert *.zo file to hex') do |x|
		if not options[:input] or not options[:output] then
			raise OptionParser::MissingArgument
		end
		to_hex(options[:input],options[:output])
	end
end.parse!
