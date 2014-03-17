class Guest
    attr_reader :name, :gender, :married, :knighted
    attr_writer :name, :gender, :married, :knighted
    def initialize(name)
        @name = name
        @gender = :male
        @marreid = false
        @knighted = false
    end

    def greet

        lastName = @name.split.last

        if :male == @gender
            honorific = @knighted ? "Sir" : "Mr."
        else
            honorific = @knighted ? "Dame" : @married ? "Mrs." : "Ms."
        end

        return "Hello #{honorific} #{lastName}"
    end
end
