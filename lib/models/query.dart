String createTableSQL =
    'CREATE TABLE members (id VARCHAR(255) NOT NULL PRIMARY KEY, name TEXT, day BOOLEAN NOT NULL, night BOOLEAN NOT NULL)';

String insertMembersSQL = '''INSERT INTO members(id, name, day, night) VALUES
    (1, 'Pallab Bera', 0, 0),
    (2, 'Kamal Karmakar', 0, 0),
    (3, 'Chittaranjan', 0, 0),
    (4, 'Gopal Biswas', 0, 0),
    (5, 'Satyabrata Da', 0, 0),
    (6, 'Somnath', 0, 0),
    (7, 'Chandan Bera', 0, 0),
    (8, 'Sarat Da', 0, 0),
    (9, 'Raja Pradha', 0, 0),
    (10, 'Subhradip', 0, 0),
    (11, 'Shubham Ghosh', 0, 0),
    (12, 'Pralay Da', 0, 0),
    (13, 'Debasish Biswas', 0, 0),
    (14, 'Sourav Das', 0, 0),
    (15, 'Arijit', 0, 0),
    (16, 'Atin Kundu', 0, 0),
    (17, 'Debkumar Mondal', 0, 0),
    (18, 'Shubham Sahoo', 0, 0),
    (19, 'Surajit Maity', 0, 0),
    (20, 'Sandip Mondal', 0, 0),
    (21, 'Shyam', 0, 0),
    (22, 'Sandeep Bankura', 0, 0),
    (23, 'Subhendu', 0, 0),
    (24, 'Supratim Pradhan', 0, 0),
    (25, 'Tapan Da', 0, 0),
    (26, 'Arjun Das', 0, 0),
    (27, 'Biswanath', 0, 0)''';

String insertSingleMembersSQL({required String id, required String name}) {
  return "INSERT INTO members(id, name, day, night) VALUES ($id, $name, 0, 0)";
}

String getMealStatusSQL({
  required String id,
  required bool day,
  required bool night,
}) {
  String query =
      "UPDATE members SET day = ${day ? "1" : "0"}, night = ${night ? "1" : "0"} WHERE id = '$id'";

  return query;
}

String getAllMembersSQL = "SELECT * FROM members";
