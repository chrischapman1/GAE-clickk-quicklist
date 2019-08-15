package objects;

import java.util.LinkedList;

public class Cart {
    private LinkedList<Item> cart = new LinkedList<>();
    private float total = 0;

    public LinkedList<Item> getCart() {
        return cart;
    }

    public void addCart(Item item) {
        this.cart.add(item);
    }

    public void addCart(String itemName) { addCart(getItem(itemName)); }

    public Item getItem(String itemName) {
        switch (itemName){
            case "mensHaircut" :
                return new Item("Men\'\'s Haircut", 28);
            case "mensBuzzcut" :
                return new Item("Men\'\'s Buzzcut", 20);
            case "mensFade" :
                return new Item("Men\'\'s Fade", 20);
            case "mensBeard" :
                return new Item("Men\'\'s Beard", 18);
            case "ladiesHaircut" :
                return new Item("Ladies Haircut", 28);
            case "boysCut" :
                return new Item("Boy\'\'s Haircut", 20);
            case "girlsCut" :
                return new Item("Girl\'\'s Haircut", 20);
            case "pensionCut" :
                return new Item("Pensioner Haircut", 23);
            default: return null;
        }
    }

    public float getTotal()
    {
        total = 0;
        for (Item i : cart)
        {
            total += i.getValue();
        }
        return total;
    }
}
