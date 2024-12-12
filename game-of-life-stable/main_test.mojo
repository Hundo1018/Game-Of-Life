def foo(word: String) -> String:
    word = "Hi, " + word
    var result: String = word + "!"
    return result


def main():
    var name:String = "Hundo"
    hello = bar(name)
    print(hello)

fn bar(inout word: String) -> String:
    word = "Hi, " + word
    var result: String = word + "!"
    return result
