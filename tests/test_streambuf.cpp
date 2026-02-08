#include <gtest/gtest.h>
#include <streambuf>
#include <vector>
#include <string>

// Simple custom streambuf for testing purposes
class SimpleStreambuf : public std::streambuf {
public:
    SimpleStreambuf(std::vector<char>& buffer) {
        setg(buffer.data(), buffer.data(), buffer.data() + buffer.size());
    }

protected:
    // Basic underflow implementation for demonstration
    int_type underflow() override {
        if (gptr() < egptr()) {
            return traits_type::to_int_type(*gptr());
        }
        return traits_type::eof();
    }
};

TEST(StreambufTest, BasicRead) {
    std::string data = "hello world";
    std::vector<char> buffer(data.begin(), data.end());
    SimpleStreambuf sbuf(buffer);
    std::istream in(&sbuf);

    std::string result;
    in >> result;

    EXPECT_EQ(result, "hello");
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
