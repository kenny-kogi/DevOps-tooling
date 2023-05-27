import unittest
import json
from library import app, books

class LibraryAppTestCase(unittest.TestCase):
    def setUp(self):
        app.testing = True
        self.client = app.test_client()

        # Clear the books list before each test
        books.clear()

        # Add some initial books for testing
        books.extend([
            {"id": 1, "title": "Book 1", "author": "Author 1"},
            {"id": 2, "title": "Book 2", "author": "Author 2"},
        ])

    def test_get_books(self):
        response = self.client.get('/books')
        data = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(data), 1)

    def test_add_book(self):
        response = self.client.post('/books', json={"title": "New Book", "author": "John Doe"})
        data = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 201)
        self.assertEqual(data['title'], "New Book")
        self.assertEqual(data['author'], "John Doe")
        self.assertEqual(len(books), 3)
        self.assertEqual(books[2]['title'], "New Book")
        self.assertEqual(books[2]['author'], "John Doe")

    def test_delete_book(self):
        response = self.client.delete('/books/1')
        self.assertEqual(response.status_code, 204)
        # Verify that the book is deleted
        response = self.client.get('/books')
        data = json.loads(response.data.decode('utf-8'))

        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(data), 1)
        self.assertEqual(data[0]['id'], 2)

    def test_delete_book_not_found(self):
        response = self.client.delete('/books/99')

        self.assertEqual(response.status_code, 204)
        self.assertEqual(len(books), 2)

if __name__ == '__main__':
    unittest.main()