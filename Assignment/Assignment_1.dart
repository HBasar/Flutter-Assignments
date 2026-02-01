import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: CourseListScreen()));
}

class CourseListScreen extends StatelessWidget {
  const CourseListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> courses = [
      {
        'img' : 'https://cdn.ostad.app/course/photo/2025-12-08T14-25-01.527Z-Course-Thumbnail-12.jpg',
        'title': 'Full Stack Web Development with JavaScript (MERN)',
        'batch': 'ব্যাচ ১১',
        'seats': '৬ সিট বাকি',
        'days': '৬ দিন বাকি',

      },
      {
        'img' : 'https://cdn.ostad.app/course/cover/2025-12-08T14-31-25.697Z-Full-Stack-Web-Development-with-Python,-Django-&-React.jpg',
        'title': 'Full Stack Web Development with Python, Django & React',
        'batch': 'ব্যাচ ৬',
        'seats': '৮৩ সিট বাকি',
        'days': '৪০ দিন বাকি',
      },
      {
        'img' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgizqPS80axHThSmjt-b5s66t9X0UuUbF-ZQ&s',
        'title': 'Full Stack Web Development with ASP.Net Core',
        'batch': 'ব্যাচ ৭',
        'seats': '৭৫ সিট বাকি',
        'days': '৩৯ দিন বাকি',
      },
      {
        'img' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8KQZTi_QMlj1SSifTA9P-bvFwGN6W8l8jcA&s',
        'title': 'SQA: Manual & Automated Testing',
        'batch': 'ব্যাচ ১৩',
        'seats': '৬৫ সিট বাকি',
        'days': '৪১ দিন বাকি',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Course UI')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return CourseCard(course: courses[index]);
          },
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: course['color'] ?? Colors.blueGrey,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              image: course['img'] != null
                  ? DecorationImage(
                image: NetworkImage(course['img']),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: course['img'] == null
                ? const Center(
              child: Icon(Icons.code, color: Colors.white, size: 40),
            )
                : null,
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip(course['batch'], Icons.layers),
                _buildInfoChip(course['seats'], Icons.people),
                _buildInfoChip(course['days'], Icons.access_time),
              ],
            ),
          ),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                course['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('বিস্তারিত দেখি', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 14),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Icon(icon, size: 10, color: Colors.blueGrey),
          const SizedBox(width: 2),
          Text(text, style: const TextStyle(fontSize: 8, color: Colors.blueGrey)),
        ],
      ),
    );
  }
}