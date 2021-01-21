class CashRegister
    attr_accessor :discount, :total

    def set_total
        #Resets the @total with a sum of all the items :prices
        @total = @items.inject(0) {|total,item| total + item[:price] * item[:qty]}
    end

    def add_item(title,price,qty = 1) #Setter method for adding value to @items
        item = {
            title: title,
            price: price,
            qty: qty
        }
        @items << item
        self.set_total
    end

    def items
        #Returns an array of each item, repeating for the number of quantities
        return_arr = []
        @items.each do |item|
            item[:qty].times {return_arr << item[:title]}
        end
        return_arr
    end

    def apply_discount
        #Takes the exisiting @total and resets it with a discount
        new_total = @total.to_f * (1-(@discount.to_f / 100))
        self.total = new_total.round(0)
        return "After the discount, the total comes to $#{@total}." if @discount > 0
        "There is no discount to apply."
    end

    def void_last_transaction
        #Removies the last transaction
        @items.pop
        self.set_total
    end



    def initialize(discount = 0) #Default of Zero for the Discount
        @total = 0
        @discount = discount
        @items = [] #Array to be filled with Item Hashes
    end
end