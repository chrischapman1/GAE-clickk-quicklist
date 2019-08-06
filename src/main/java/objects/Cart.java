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

    public void addCart(String itemName)
    {
        switch (itemName){
            case "mensHaircut" :
                addCart(new Item("Men's Haircut", 28));
                break;
            case "mensBuzzcut" :
                addCart(new Item("Men's Buzzcut", 20));
                break;
            case "mensFade" :
                addCart(new Item("Men's Fade", 20));
                break;
            case "mensBeard" :
                addCart(new Item("Men's Beard", 18));
                break;
            case "ladiesHaircut" :
                addCart(new Item("Ladies Haircut", 28));
                break;
            case "boysCut" :
                addCart(new Item("Boy's Haircut", 20));
                break;
            case "girlsCut" :
                addCart(new Item("Girl's Haircut", 20));
                break;
            case "pensionCut" :
                addCart(new Item("Pensioner Haircut", 23));
                break;
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
