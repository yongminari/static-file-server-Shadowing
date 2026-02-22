#include <gtest/gtest.h>
#include <boost/asio/streambuf.hpp>
#include <iostream>
#include <string>
#include <ostream>
#include <istream>

TEST(AsioStreambufTest, BasicWriteAndRead) {
    boost::asio::streambuf sbuf;
    
    // 1. 버퍼에 데이터 쓰기 (std::ostream 사용)
    std::ostream os(&sbuf);
    os << "hello boost asio";
    
    // 2. 버퍼 크기 확인
    EXPECT_EQ(sbuf.size(), 16);
    
    // 3. 버퍼에서 데이터 읽기 (std::istream 사용)
    std::istream is(&sbuf);
    std::string word1, word2, word3;
    is >> word1 >> word2 >> word3;
    
    EXPECT_EQ(word1, "hello");
    EXPECT_EQ(word2, "boost");
    EXPECT_EQ(word3, "asio");
    
    // 4. 읽은 후 버퍼가 비었는지 확인
    EXPECT_EQ(sbuf.size(), 0);
}

TEST(AsioStreambufTest, PrepareAndCommit) {
    boost::asio::streambuf sbuf;
    
    // 1. 5바이트 공간 확보
    auto bufs = sbuf.prepare(5);
    
    // 2. 확보된 공간에 직접 데이터 쓰기
    std::string data = "hello";
    boost::asio::buffer_copy(bufs, boost::asio::buffer(data));
    
    // 3. 데이터가 들어갔음을 알림 (commit)
    sbuf.commit(5);
    
    EXPECT_EQ(sbuf.size(), 5);
    
    // 4. 내용 확인
    std::string result;
    std::istream is(&sbuf);
    is >> result;
    EXPECT_EQ(result, "hello");
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
