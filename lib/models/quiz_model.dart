class Quiz {
  final int id;
  final String title;
  final String description;
  final int duration;
  final String? topic;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? endsAt;
  final int questionsCount;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    this.topic,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
    this.endsAt,
    required this.questionsCount,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'] ?? 'Untitled Quiz',
      description: json['description'] ?? '',
      duration: json['duration'] ?? 0,
      topic: json['topic'],
      isPublished: json['is_published'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      endsAt: json['ends_at'] != null ? DateTime.parse(json['ends_at']) : null,
      questionsCount: json['questions_count'] ?? 0,
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String description;
  final String? detailedSolution;
  final List<Option> options;
  final ReadingMaterial? readingMaterial;
  final String questionFrom;

  Question({
    required this.id,
    required this.description,
    this.detailedSolution,
    required this.options,
    this.readingMaterial,
    required this.questionFrom,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      description: json['description'] ?? '',
      detailedSolution: json['detailed_solution'],
      options: (json['options'] as List)
          .map((o) => Option.fromJson(o))
          .toList(),
      readingMaterial: json['reading_material'] != null
          ? ReadingMaterial.fromJson(json['reading_material'])
          : null,
      questionFrom: json['question_from'] ?? 'Unknown',
    );
  }
}

class Option {
  final int id;
  final String description;
  final bool isCorrect;

  Option({required this.id, required this.description, required this.isCorrect});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['description'] ?? 'No description',
      isCorrect: json['is_correct'] ?? false,
    );
  }
}

class ReadingMaterial {
  final int id;
  final String keywords;
  final String? content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> contentSections;
  final PracticeMaterial? practiceMaterial;

  ReadingMaterial({
    required this.id,
    required this.keywords,
    this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.contentSections,
    this.practiceMaterial,
  });

  factory ReadingMaterial.fromJson(Map<String, dynamic> json) {
    return ReadingMaterial(
      id: json['id'],
      keywords: json['keywords'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      contentSections: (json['content_sections'] as List<dynamic>)
          .map((section) => section as String)
          .toList(),
      practiceMaterial: json['practice_material'] != null
          ? PracticeMaterial.fromJson(json['practice_material'])
          : null,
    );
  }
}

class PracticeMaterial {
  final List<String> content;
  final List<String> keywords;

  PracticeMaterial({required this.content, required this.keywords});

  factory PracticeMaterial.fromJson(Map<String, dynamic> json) {
    return PracticeMaterial(
      content: (json['content'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
      keywords: (json['keywords'] as List<dynamic>)
          .map((item) => item as String)
          .toList(),
    );
  }
}
