import com.github.javafaker.Faker;
import com.github.javafaker.IdNumber;
import javafx.util.Pair;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

public class randGenDB {
    public static void generateSchedule() {
        Random random = new Random();
        Faker faker = new Faker();
        String[] randomBeginTime = {"09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00"};
        String[] randomEndTime = {"18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00"};
        List<String> res = new ArrayList<>();
        for (int i = 1; i <= 11; ++i) {
            String insert = String.format("insert into schedule (worktime_id, begin_time, end_time) values (%d, '%s','%s');",
                    i, randomBeginTime[i - 1], randomEndTime[i - 1]);
            res.add(insert);
            System.out.println(insert);
        }
    }

    public static void generateShop() throws IOException {
        Faker faker = new Faker();
        File file = new File("genShop.sql");
        FileWriter fw = new FileWriter(file);
        Random random = new Random();
        Set<String> shopName = new HashSet<>();
        while (shopName.size() <= 1050) {
            shopName.add(faker.address().firstName());
        }
        var iter = shopName.iterator();
        for (int i = 1; i <= 1050; ++i) {
            String insert = String.format("insert into shop (shop_id, shop_name, working_time_begin, working_time_end, rent_price, " +
                            "cash_machines, warehouse_size) values (%d, '%s', '%s', '%s', %d, %d, %d);", i, iter.next(), "10:00",
                    "22:00", random.nextInt(100) + 100, random.nextInt(6) + 4, faker.number().numberBetween(3000, 10000));
            fw.write(insert + '\n');
            System.out.println(insert);
        }
    }

    public static void generateRestSchedule() throws IOException {
        Faker faker = new Faker();
        File file = new File("genRestSchedule.sql");
        FileWriter fw = new FileWriter(file);
        Random random = new Random();
        List<Pair<Integer, Integer>> pairs = new ArrayList<>();
        for (int i = 1; i <= 40090; ++i) {
            var fst = random.nextInt(11) + 1;
            String insert = String.format("insert into rest_schedule (worktime_id, shop_assistant_id) values" +
                    "(%d, %d);\n", fst, i);
            fw.write(insert);
        }
    }

    public static void genereteScheduleInShop() throws IOException {
        Faker faker = new Faker();
        List<String> list = new ArrayList<>();
        Random random = new Random();
        File file = new File("genScheduleInShop.sql");
        FileWriter fw = new FileWriter(file);
        List<Pair<Integer, Integer>> pairs = new ArrayList<>();
        for (int i = 1; i <= 40000; ++i) {
            var scnd = random.nextInt(1000) + 1;
            String insert = String.format("insert into schedule_in_shop (id, shop_id) values (%d, %d);\n",
                    i, scnd);
            list.add(insert);
        }
        list.forEach(l -> {
            try {
                fw.write(l);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });
        fw.close();
    }

    public static void generateShopAssistant() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genShopAssistant.sql");
        FileWriter fw = new FileWriter(file);
        for (int i = 1; i <= 40200; ++i) {
            int year = faker.number().numberBetween(1960, 2004);
            int month = faker.number().numberBetween(1, 13);
            int day = 0;
            if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
                day = faker.number().numberBetween(1, 32);
            else if (month == 2)
                day = faker.number().numberBetween(1, 29);
            else if (month == 4 || month == 6 || month == 9 || month == 11)
                day = faker.number().numberBetween(1, 31);
            else throw new RuntimeException();
            var name = faker.name().firstName();
            var surname = faker.name().lastName();
            if (name.contains("'") || surname.contains("'")) {
                i = i - 1;
                continue;
            }
            String insert = String.format("insert into shop_assistant (shop_assistant_id, name, surname, born_date, passport_series, passport_id)" +
                            " values (%d, '%s', '%s', '%s', '%s', '%s');", i, name, surname,
                    Date.valueOf(LocalDate.of(year, month, day)),
                    faker.regexify("[1-9][0-9]{3}"), faker.regexify("[1-9][0-9]{5}"));
            fw.write(insert + '\n');
            //System.out.println(insert);
        }
        fw.close();
    }

    public static void generateSupplier() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genSupplier.sql");
        FileWriter fw = new FileWriter(file);
        Set<String> suppNames = new HashSet<>();
        while (suppNames.size() < 200) {
            suppNames.add(faker.address().lastName());
        }
        var iter = suppNames.iterator();
        for (int i = 1; i <= 200; ++i) {
            String insert = String.format("insert into supplier (supplier_id, name) values (%d, '%s');\n", i, iter.next());
            fw.write(insert);
        }
        fw.close();
    }

    public static void generateDelivery() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genDelivery.sql");
        FileWriter fw = new FileWriter(file);
        Set<String> suppNames = new HashSet<>();
        while (suppNames.size() < 200) {
            suppNames.add(faker.address().lastName());
        }
        var iter = suppNames.iterator();
        for (int i = 1; i <= 60000; ++i) {
            var randomShop = random.nextInt(1000) + 1;
            var randomSupp = random.nextInt(200) + 1;
            int year = random.nextInt(7) + 2015;
            int month = random.nextInt(12) + 1;
            int day = 0;
            if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
                day = random.nextInt(31) + 1;
            else if (month == 2)
                day = random.nextInt(28) + 1;
            else day = random.nextInt(30) + 1;
            String insert = String.format("insert into delivery (delivery_number, shop_id, supplier_id, datetime_delivery, delivery_price)" +
                    " values (%d, %d, %d, '%s', %d);\n", i, randomShop, randomSupp, Date.valueOf(LocalDate.of(year, month, day)), faker.number().numberBetween(100, 201));
            fw.write(insert);
        }
        fw.close();
    }

    public static void generateCouriers() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genCouriers.sql");
        FileWriter fw = new FileWriter(file);
        for (int i = 1; i <= 10000; ++i) {
            int year = faker.number().numberBetween(1960, 2004);
            int month = faker.number().numberBetween(1, 13);
            int day = 0;
            if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
                day = faker.number().numberBetween(1, 32);
            else if (month == 2)
                day = faker.number().numberBetween(1, 29);
            else if (month == 4 || month == 6 || month == 9 || month == 11)
                day = faker.number().numberBetween(1, 31);
            else throw new RuntimeException();
            var name = faker.name().firstName();
            var surname = faker.name().lastName();
            if (name.contains("'") || surname.contains("'")) {
                i = i - 1;
                continue;
            }
            var shop = random.nextInt(1000) + 1;
            String insert = String.format("insert into courier (courier_id, shop_id, name, surname, born_date, passport_series, passport_id)" +
                            " values (%d, %d, '%s', '%s', '%s', '%s', '%s');", i, shop, name, surname,
                    Date.valueOf(LocalDate.of(year, month, day)),
                    faker.regexify("[1-9][0-9]{3}"), faker.regexify("[1-9][0-9]{5}"));
            fw.write(insert + '\n');
        }
        fw.close();
    }

    public static void generateConsumers() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genConsumers.sql");
        FileWriter fw = new FileWriter(file);
        for (int i = 1; i <= 100000; ++i) {
            var name = faker.name().firstName();
            var surname = faker.name().lastName();
            if (name.contains("'") || surname.contains("'")) {
                i = i - 1;
                continue;
            }
            String insert = String.format("insert into customer (customer_id, name, surname, email, phone)" +
                            " values (%d, '%s', '%s', '%s', '%s');", i, name, surname,
                    faker.regexify("[a-z][a-z1-9]{6,10}").concat("@mail.com"), faker.regexify("+7[0-9]{10}"));
            fw.write(insert + '\n');
        }
        fw.close();
    }

    public static void generateClothes() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genClothes.sql");
        FileWriter fw = new FileWriter(file);
        String[] nameArray = {"Belt", "Boots", "Dress", "Gloves", "Hat", "Jeans", "Jumper", "Cap", "Pants", "Raincoat", "Scarf",
                "Shirt", "Shorts", "Socks", "Skirt", "Sweater", "Tie", "Underpants", "Undershirt", "Blouse", "Suit"};
        String[] sizeString = {"XS", "S", "M", "L", "XL", "XXL", "XXXL"};
        for (int i = 1; i <= 100000; ++i) {
            var name = faker.regexify("[A-Z][a-z]{8,12}");
            var color = faker.color().name();
            String insert = String.format("insert into clothes (clothes_id, name, type, color, size, price)" +
                            " values (%d, '%s', '%s', '%s', '%s', '%s');", i, name, nameArray[random.nextInt(21)],
                    color, sizeString[random.nextInt(7)], faker.commerce().price());
            fw.write(insert + '\n');
        }
        fw.close();
    }

    public static void genereteClothisInShop() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genClothesInShop.sql");
        FileWriter fw = new FileWriter(file);
        int[][] ar = new int[1000 + 1][100000 + 1];
        for (int i = 1; i <= 1000000; ++i) {
            int fst = random.nextInt(1000) + 1;
            int scnd = random.nextInt(100000) + 1;
            String insert = String.format("insert into clothes_in_shop (shop_id, clothes_id, quantity)" +
                    " values (%d, %d, %d);", fst, scnd, random.nextInt(20) + 1);
            if (ar[fst][scnd] == 0) {
                ar[fst][scnd] = 1;
            } else continue;
            fw.write(insert + '\n');
        }
        fw.close();
    }

    public static void genereteClothisInOrder() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genClothesInOrder.sql");
        FileWriter fw = new FileWriter(file);
        for (int i = 1; i <= 100000; ++i) {
            Set<Integer> set = new HashSet<>();
            for (int j = 0; j < 50; ++j) {
                int scnd = random.nextInt(600000) + 1;
                if (set.contains(scnd)) {
                    j = j - 1;
                    continue;
                } else set.add(scnd);
                String insert = String.format("insert into clothes_in_order (clothes_id, order_id, quantity_in_order)" +
                        " values (%d, %d, %d);", i, scnd, random.nextInt(20) + 1);
                fw.write(insert + '\n');
            }
        }
        fw.close();
    }

    public static void genereteDeliveryNote() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genDeliveryNote.sql");
        FileWriter fw = new FileWriter(file);
        int[][] ar = new int[1000 + 1][100000 + 1];
        for (int i = 1; i <= 100000; ++i) {
            int fst = random.nextInt(1000) + 1;
            int scnd = random.nextInt(100000) + 1;
            String insert;
            int year = random.nextInt(7) + 2015;
            int month = random.nextInt(12) + 1;
            int day = 0;
            if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
                day = random.nextInt(31) + 1;
            else if (month == 2)
                day = random.nextInt(28) + 1;
            else day = random.nextInt(30) + 1;
            var orderDate = Date.valueOf(LocalDate.of(year, month, day));
            var date = faker.date().between(Date.valueOf("2000-01-01"), Date.valueOf("2001-01-01"));
            var hour = date.getHours();
            var min = date.getMinutes();
            var time = Time.valueOf(LocalTime.of(hour, min));
            if (i < 10000) {
                insert = String.format("insert into delivery_note (delivery_note_id, courier_id, shop_id, " +
                                "description, order_time, delivery_time_planned, delivery_time_real)" +
                                " values (%d, %d, %d,'%s', '%s', '%s', '%s');", i, random.nextInt(10000) + 1,
                        random.nextInt(1000) + 1, faker.regexify("[a-z]{10,30}"), orderDate, time, time);
            } else {
                insert = String.format("insert into delivery_note (delivery_note_id, courier_id, " +
                                "description, order_time, delivery_time_planned, delivery_time_real, customer_signature)" +
                                " values (%d, %d, '%s', '%s', '%s', '%s', '%s');", i, random.nextInt(10000) + 1,
                        faker.regexify("[a-z]{10,30}"), orderDate, time, time, random.nextInt(10) + 1 < 7);
            }
            fw.write(insert + '\n');
        }
        fw.close();
    }

    public static void generateSet() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genSet.sql");
        FileWriter fw = new FileWriter(file);
        for (int i = 1; i <= 10000; ++i) {
            String insert = String.format("insert into set (set_id, price)" +
                    " values (%d, %d); \n", i, random.nextInt(900) + 100);
            fw.write(insert);
        }
        fw.close();
    }

    public static void generateReciept() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genReciept.sql");
        FileWriter fw = new FileWriter(file);
        for (int i = 1; i <= 500000; ++i) {
            int year = random.nextInt(7) + 2015;
            int month = random.nextInt(12) + 1;
            int day = 0;
            if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
                day = random.nextInt(31) + 1;
            else if (month == 2)
                day = random.nextInt(28) + 1;
            else day = random.nextInt(30) + 1;
            var orderDate = Date.valueOf(LocalDate.of(year, month, day));
            var date = faker.date().between(Date.valueOf("2000-01-01"), Date.valueOf("2001-01-01"));
            var hour = date.getHours();
            var min = date.getMinutes();
            var orderTime = Time.valueOf(LocalTime.of(hour, min));
            String dateTime = String.valueOf(orderDate).concat(" ").concat(String.valueOf(orderTime));
            String insert = String.format("insert into receipt (receipt_id, customer_id, shop_assistant_id," +
                            " shopping_date_and_time) values (%d, %d, %d, '%s'); \n", i,
                    random.nextInt(100000) + 1, random.nextInt(40000) + 1, dateTime);
            fw.write(insert);
        }
        fw.close();
    }

    public static void generateCustomerOrder() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genCustomerOrder.sql");
        FileWriter fw = new FileWriter(file);
        for (int i = 1; i <= 600000; ++i) {
            String insert;

            if (i < 10000) {
                insert = String.format("insert into customer_order (order_id, delivery_note_id)" +
                        " values (%d, %d); \n", i, i);
            } else if (i <= 100000) {
                insert = String.format("insert into customer_order (order_id, delivery_note_id, customer_id)" +
                        " values (%d, %d, %d); \n", i, i, random.nextInt(100000) + 1);
            } else {
                insert = String.format("insert into customer_order (order_id, receipt, customer_id)" +
                        " values (%d, %d, %d); \n", i, i-100000, random.nextInt(100000) + 1);
            }
            fw.write(insert);
        }
        fw.close();
    }

    public static void genereteClothisInSet() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genClothesInSet.sql");
        FileWriter fw = new FileWriter(file);
        for (int i = 1; i <= 10000; ++i) {
            Set<Integer> set = new HashSet<>();
            for (int j = 0; j < 100; ++j) {
                int scnd = random.nextInt(100000) + 1;
                if (set.contains(scnd)) {
                    j = j - 1;
                    continue;
                } else set.add(scnd);
                String insert = String.format("insert into clothes_in_set (set_id, clothes_id, quantity_in_set)" +
                        " values (%d, %d, %d);", i, scnd, random.nextInt(5) + 1);
                fw.write(insert + '\n');
            }
        }
        fw.close();
    }

    public static void genereteSetInOrder() throws IOException {
        Faker faker = new Faker();
        Random random = new Random();
        File file = new File("genSetInOrder.sql");
        FileWriter fw = new FileWriter(file);
        for (int i = 1; i <= 10000; ++i) {
            Set<Integer> set = new HashSet<>();
            for (int j = 0; j < 100; ++j) {
                int scnd = random.nextInt(600000) + 1;
                if (set.contains(scnd)) {
                    j = j - 1;
                    continue;
                } else set.add(scnd);
                String insert = String.format("insert into set_in_order (order_id, set_id, quantity_in_order)" +
                        " values (%d, %d, %d);", scnd, i, random.nextInt(3) + 1);
                fw.write(insert + '\n');
            }
        }
        fw.close();
    }

    public static void main(String[] args) throws IOException {
        genereteClothisInOrder();
    }
}
