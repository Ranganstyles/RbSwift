//
//  Conversions.swift
//  RbSwift
//
//  Created by draveness on 19/03/2017.
//  Copyright © 2017 draveness. All rights reserved.
//

import Quick
import Nimble
import RbSwift

class StringTransformSpec: BaseSpec {
    override func spec() {
        describe(".concat") {
            it("concats two strings together") {
                expect("Hello".concat(" World")).to(equal("Hello World"))
            }
        }
        
        describe(".chomp(chars:)") {
            it("returns a new string without whitespace in the end") {
                expect("1Hello\r1\n".chomp).to(equal("1Hello\r1"))
                expect("Hello\r\n\r\n".chomp).to(equal("Hello"))
                expect("Hello\n".chomp).to(equal("Hello"))
                expect("Hello  ".chomp).to(equal("Hello"))
                expect("Hello  \r".chomp).to(equal("Hello"))
                expect("  Hello  \r".chomp).to(equal("  Hello"))
                expect("".chomp).to(beEmpty())
            }

            it("returns a new string without the passing chars in the end") {
                expect("Hello\r\n".chomp("o\r\n")).to(equal("Hell"))
                expect("Hello".chomp("o\r\n")).to(equal("Hello"))
            }
            
            it("returns a new string without newline") {
                expect("Hello\r\n\r\n".chomp("")).to(equal("Hello"))
                expect("Hello\r\n\r\r\n".chomp("")).to(equal("Hello\r\n\r"))
            }
        }
        
        describe(".chop") {
            it("returns a new string without the last character") {
                expect("Hello\r\n\r\n".chop).to(equal("Hello\r\n"))
                expect("Hello\r\n".chop).to(equal("Hello"))
                expect("Hello\n\r".chop).to(equal("Hello\n"))
                expect("Hello\n".chop).to(equal("Hello"))
                expect("x".chop).to(beEmpty())
                expect("".chop.chop).to(beEmpty())
            }
        }
        
        describe(".clear") {
            it("makes the string empty") {
                var s = "xyz"
                expect(s.cleared()).to(beEmpty())
                expect(s).to(beEmpty())
            }
        }
        
        describe(".count(str:)") {
            it("returns the count of specific chars inside the receiver string") {
                let a = "hello world"
                expect(a.count("lo")).to(equal(5))
                expect(a.count("lo", "o")).to(equal(2))
                expect(a.count("hello", "^l")).to(equal(4))
                expect(a.count("ej-m")).to(equal(4))

                expect("hello^world".count("\\^aeiou")).to(equal(4))
                expect("hello-world".count("a-eo")).to(equal(4))

                let c = "hello world\\r\\n"
                expect(c.count("\\A")).to(equal(0))
                expect(c.count("X\\-\\\\w")).to(equal(3))
            }
        }
        
        describe(".delete(str:)") {
            it("returns the string with specific chars deleted inside the receiver string") {
                let a = "hello world"
                expect(a.delete("lo")).to(equal("he wrd"))
                expect(a.delete("lo", "o")).to(equal("hell wrld"))
                expect(a.delete("hello", "^l")).to(equal("ll wrld"))
                expect(a.delete("ej-m")).to(equal("ho word"))
                
                expect("hello^world".delete("\\^aeiou")).to(equal("hllwrld"))
                expect("hello-world".delete("a-eo")).to(equal("hll-wrl"))
                expect("hello-world".delete("a\\-eo")).to(equal("hllwrld"))
                
                let c = "hello world\\r\\n"
                expect(c.delete("\\A")).to(equal("hello world\\r\\n"))
                expect(c.delete("X\\-\\\\w")).to(equal("hello orldrn"))
            }
        }
        
        describe(".reverse") {
            it("returns a new string with reverse order") {
                expect("Hello".reverse).to(equal("olleH"))
            }
        }
        
        describe(".split") {
            it("splits string into array") {
                expect(" now's  the time".split).to(equal(["now's", "the", "time"]))
                expect(" now's\nthe time\n\t".split).to(equal(["now's", "the", "time"]))
                expect("hello".split("")).to(equal(["h", "e", "l", "l", "o"]))
                expect("hello".split("l+")).to(equal(["he", "o"]))
                expect(" now's  the time".split(" ")).to(equal(["now's", "the", "time"]))
                expect("mellow yellow".split("ello")).to(equal(["m", "w y", "w"]))
                expect("1,2,,3,4,,".split(",")).to(equal(["1", "2", "", "3", "4"]))
                expect("red yellow and blue".split("[ae ]")).to(equal(["r", "d", "y", "llow", "", "nd", "blu"]))
            }
        }
        
        describe(".ljust") {
            context("when integer is greater than the length of str") {
                it("returns a new String of length integer with str left justified and padded with padstr") {
                    expect("hello".ljust(20)).to(equal("hello" + 15 * " "))
                    expect("hello".ljust(20, "1234")).to(equal("hello123412341234123"))
                }
            }
            
            context("otherwise") {
                it("returns the string") {
                    expect("hello".ljust(4)).to(equal("hello"))
                }
            }
        }
        
        describe(".rjust") {
            context("when integer is greater than the length of str") {
                it("returns a new String of length integer with str right justified and padded with padstr") {
                    expect("hello".rjust(20)).to(equal(15 * " " + "hello"))
                    expect("hello".rjust(20, "1234")).to(equal("123412341234123hello"))
                }
            }
            
            context("otherwise") {
                it("returns the string") {
                    expect("hello".rjust(4)).to(equal("hello"))
                }
            }
        }
        
        describe(".center") {
            context("when integer is greater than the length of str") {
                it("returns a new String of length integer with str centered and padded with padstr") {
                    expect("hello".center(20)).to(equal("       hello        "))
                    expect("hello".center(20).length).to(equal(20))
                    expect("hello".center(20, "123")).to(equal("1231231hello12312312"))
                }
            }
            
            context("otherwise") {
                it("returns the string") {
                    expect("hello".center(4)).to(equal("hello"))
                }
            }
        }
        
        describe(".strip") {
            it("removes both sides whitespace from str") {
                expect("\t \nhello  ".strip).to(equal("hello"))
                expect("\t hello   ".strip).to(equal("hello"))
                expect("hello   ".strip).to(equal("hello"))
            }
        }
        
        describe(".lstrip") {
            it("removes leading whitespace from str") {
                expect("\t \nhello".lstrip).to(equal("hello"))
                expect("\t hello   ".lstrip).to(equal("hello   "))
            }
        }
        
        describe(".rstrip") {
            it("removes trailing whitespace from str") {
                expect("\t \nhello  ".rstrip).to(equal("\t \nhello"))
                expect("\t hello   ".rstrip).to(equal("\t hello"))
            }
        }
        
        describe(".prepend(other:)") {
            it("prepends the given string to str") {
                var str = "yz"
                expect(str.prepend("x")).to(equal("xyz"))
                expect(str).to(equal("xyz"))
            }
        }
        
        describe(".replace(other:)") {
            it("replaces the contents and taintedness of str with the corresponding values in other str") {
                var str = "yz"
                expect(str.replace("x")).to(equal("x"))
                expect(str).to(equal("x"))
            }
        }
        
        describe(".partition") {
            it("searches sep or pattern (regexp) in the string and returns the part before it, the match, and the part after it") {
                expect("hello".partition("l")).to(equal(["he", "l", "lo"]))
                expect("hello".partition("le")).to(equal(["hello", "", ""]))
            }
        }
        
        describe(".rpartition") {
            it("searches sep or pattern (regexp) in the string from the end of it and returns the part before it, the match, and the part after it") {
                expect("hello".rpartition("l")).to(equal(["hel", "l", "o"]))
                expect("hello".rpartition("le")).to(equal(["", "", "hello"]))
            }
        }
    }
}

