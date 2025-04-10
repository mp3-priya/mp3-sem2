package PartB;

import weka.classifiers.bayes.NaiveBayes;
import weka.core.*;
import java.util.ArrayList;
import java.util.Scanner;

public class EventClassifier {

    public static void main(String[] args) throws Exception {
        // 1. Define nominal values
        ArrayList<String> locations = new ArrayList<>();
        locations.add("London");
        locations.add("Manchester");
        locations.add("Coventry");
        locations.add("Birmingham");
        locations.add("Edinburgh");
        locations.add("Leeds");
        locations.add("Glasgow");
        locations.add("Cardiff");
        locations.add("Liverpool");
        locations.add("Bristol");

        ArrayList<String> descriptions = new ArrayList<>();
        descriptions.add("AI");
        descriptions.add("Wedding");
        descriptions.add("Workshop");
        descriptions.add("NewYear");
        descriptions.add("Tech");
        descriptions.add("Science");
        descriptions.add("Family");
        descriptions.add("Graduation");
        descriptions.add("Cybersecurity");
        descriptions.add("Java");

        ArrayList<String> eventTypes = new ArrayList<>();
        eventTypes.add("Conference");
        eventTypes.add("Wedding");
        eventTypes.add("Workshop");
        eventTypes.add("Party");

        // 2. Define attributes
        ArrayList<Attribute> attributes = new ArrayList<>();
        attributes.add(new Attribute("Location", locations));
        attributes.add(new Attribute("Description", descriptions));
        attributes.add(new Attribute("EventType", eventTypes)); // class attribute

        Instances data = new Instances("EventData", attributes, 0);
        data.setClassIndex(2); // "EventType" is the class

        // 3. Add 50 sample rows
        addInstance(data, "London", "AI", "Conference");
        addInstance(data, "Manchester", "Wedding", "Wedding");
        addInstance(data, "Coventry", "Java", "Workshop");
        addInstance(data, "Birmingham", "NewYear", "Party");
        addInstance(data, "Edinburgh", "Tech", "Conference");
        addInstance(data, "London", "Science", "Workshop");
        addInstance(data, "Leeds", "Family", "Wedding");
        addInstance(data, "Cardiff", "Graduation", "Party");
        addInstance(data, "Glasgow", "Tech", "Conference");
        addInstance(data, "Liverpool", "Cybersecurity", "Workshop");

        // Add more fake data to reach ~50
        for (int i = 0; i < 40; i++) {
            String loc = locations.get(i % locations.size());
            String desc = descriptions.get(i % descriptions.size());
            String type = eventTypes.get(i % eventTypes.size());
            addInstance(data, loc, desc, type);
        }

        // 4. Build model
        NaiveBayes model = new NaiveBayes();
        model.buildClassifier(data);

        // 5. User input
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter Location (e.g., London): ");
        String inputLocation = scanner.nextLine();
        System.out.print("Enter Description Keyword (e.g., AI): ");
        String inputDescription = scanner.nextLine();
        scanner.close();

        // 6. Create instance for prediction
        DenseInstance instance = new DenseInstance(3);
        instance.setDataset(data);
        instance.setValue(0, inputLocation);
        instance.setValue(1, inputDescription);

        double predictedIndex = model.classifyInstance(instance);
        String predictedEventType = data.classAttribute().value((int) predictedIndex);

        System.out.println("Predicted Event Type: " + predictedEventType);
    }

    private static void addInstance(Instances data, String location, String description, String eventType) {
        DenseInstance instance = new DenseInstance(3);
        instance.setValue(data.attribute(0), location);
        instance.setValue(data.attribute(1), description);
        instance.setValue(data.attribute(2), eventType);
        data.add(instance);
    }
}
