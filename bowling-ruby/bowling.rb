class BowlingGame
    def initialize(throws)
        @throws = throws
    end

    def scoreForBall(throwIndex)
        ball = @throws[throwIndex]
        return ball ? ball : 0
    end

    def scoreForFrameBall(targetFrame, targetBall)
        frame = 0
        ball = 0
        while frame < targetFrame do
            if 10 == scoreForBall(ball) #strike
                ball += 1
            else
                ball += 2
            end
            frame += 1
        end

        return scoreForBall(ball + targetBall)
    end

    def strikeInFrame(frameIndex)
        return (10 == scoreForFrameBall(frameIndex, 0))
    end

    def scoreThroughFrame(targetFrame)
        score = 0
        ball = 0
        frame = 0
        while ball < @throws.length and frame <= targetFrame do
            frameScore = scoreForBall(ball)
            if 10 == frameScore # Strike!
                frameScore += scoreForBall(ball+1)
                frameScore += scoreForBall(ball+2)
                ball += 1
            else
                frameScore += scoreForBall(ball+1)
                if 10 == frameScore # Spare!
                    frameScore += scoreForBall(ball+2)
                end
                ball += 2
            end
            score += frameScore
            frame += 1
        end
        return score
    end

    def score
        return scoreThroughFrame(9)
    end

    def scorecard
        # |5 /|1 8|  X|X X X|
        # | 11| 20| 50|   80|

        line1 = ""
        line2 = ""
        for frame in 0..9
            line1 += "|"
            line2 += "|"

            if frame < 9
                if strikeInFrame(frame)
                    line1 += "X".rjust(3)
                else
                    ball1 = scoreForFrameBall(frame, 0)
                    ball2 = scoreForFrameBall(frame, 1)
                    ball2 = (10 == ball1 + ball2) ? "/" : ball2
                    line1 += "#{ball1} #{ball2}".rjust(3)
                end
                line2 += scoreThroughFrame(frame).to_s.rjust(3)
            else
                ball1 = scoreForFrameBall(frame, 0)
                ball2 = scoreForFrameBall(frame, 1)
                ball3 = scoreForFrameBall(frame, 2)
                if strikeInFrame(frame)
                    ball1 = "X"
                    ball2 = (10 == ball2) ? "X" : ball2
                    if "X" == ball2
                        ball3 = (10 == ball3) ? "X" : ball3
                    else
                        ball3 = (10 == ball2 + ball3) ? "/" : ball3
                    end
                else
                    ball2 = (10 == ball1 + ball2) ? "/" : ball2
                    if "/" == ball2
                        ball3 = (10 == ball3) ? "X" : ball3
                    else
                        ball3 = " "
                    end
                end
                line1 += "#{ball1} #{ball2} #{ball3}".rjust(5)
                line2 += scoreThroughFrame(frame).to_s.rjust(5)
            end
        end
        line1 += "|"
        line2 += "|"
        return "#{line1}\n#{line2}"
    end
end

class BowlingGameTests
    def assertEqual(a, b)
        if (a != b)
            @success = false
            puts "Test \"#{@testName}\" failed! #{a} != #{b}"
        end
    end

    def runTests
        tests = [
            lambda do
                @testName = "Empty game scores zero"
                game = BowlingGame.new([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
                assertEqual(0, game.score)
            end,

            lambda do
                @testName = "All ones scores twenty"
                game = BowlingGame.new([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
                assertEqual(20, game.score)
            end,

            lambda do
                @testName = "Perfect game scores 300"
                game = BowlingGame.new([10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10])
                assertEqual(300, game.score)
            end,

            lambda do
                @testName = "All fives scores 150"
                game = BowlingGame.new([5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5])
                assertEqual(150, game.score)
            end,

            lambda do
                @testName = "All spare-zeroes scores 100"
                game = BowlingGame.new([0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0])
                assertEqual(100, game.score)
            end,

            lambda do
                @testName = "Complex example scores 134"
                game = BowlingGame.new([8, 1, 9, 1, 9, 0, 0, 5, 10, 10, 8, 1, 7, 1, 10, 5, 4])
                assertEqual(134, game.score)
            end,

            lambda do
                @testName = "scoreForBall returns correct value or zero if out of range"
                game = BowlingGame.new([8, 1, 9, 1, 9, 0, 0, 5, 10, 10, 8, 1, 7, 1, 10, 5, 4])
                assertEqual(8, game.scoreForBall(0))
                assertEqual(10, game.scoreForBall(8))
                assertEqual(0, game.scoreForBall(50))
            end,

            lambda do
                @testName = "scoreForFrameBall returns correct value or zero if out of range"
                game = BowlingGame.new([8, 1, 9, 1, 9, 0, 0, 5, 10, 10, 8, 1, 7, 1, 10, 5, 4])
                assertEqual(8, game.scoreForFrameBall(0, 0))
                assertEqual(10, game.scoreForFrameBall(4, 0))
                assertEqual(1, game.scoreForFrameBall(6, 1))
                assertEqual(0, game.scoreForFrameBall(50, 50))
            end,

            lambda do
                @testName = "strikeInFrame works"
                game = BowlingGame.new([8, 1, 9, 1, 9, 0, 0, 5, 10, 10, 8, 1, 7, 1, 10, 5, 4])
                assertEqual(false, game.strikeInFrame(0))
                assertEqual(true, game.strikeInFrame(4))
                assertEqual(false, game.strikeInFrame(14))
                puts(game.scorecard)
            end,

            lambda do
                @testName = "Complex example scores 134"
                game = BowlingGame.new([8, 1, 9, 1, 9, 0, 0, 5, 10, 10, 8, 1, 7, 1, 10, 5, 4])
                expectedCard = "|8 1|9 /|9 0|0 5|  X|  X|8 1|7 1|  X|5 4  |\n|  9| 28| 37| 42| 70| 89| 98|106|125|  134|"
                assertEqual(expectedCard, game.scorecard)
            end,
        ]

        @success = true
        tests.each do |test|
            test.call
            if !@success 
                break 
            end
        end

        if @success
            puts "Tests passed"
        end
    end
end

t = BowlingGameTests.new
t.runTests
