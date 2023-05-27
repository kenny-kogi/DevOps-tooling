from flask import Flask, jsonify, request

app = Flask(__name__)

# Sample initial data
books = [
    {"id": 1, "title": "River and The Source", "author": "Margaret Ogola"},
    {"id": 2, "title": "DevOps Handbook", "author": "Gene Kim"},
    {"id": 3, "title": "Phoenix Project", "author": "Micheal Hatterman"}
]

next_id = 4

@app.route('/books', methods=['GET'])
def get_books():
    return jsonify(books)


@app.route('/books', methods=['POST'])
def add_book():
    global next_id
    book = {
        "id": next_id,
        "title": request.json.get('title'),
        "author": request.json.get('author')
    }
    books.append(book)
    next_id += 1
    return jsonify(book), 201


@app.route('/books/<int:book_id>', methods=['DELETE'])
def delete_book(book_id):
    global books
    books = [book for book in books if book['id'] != book_id]
    return '', 204


if __name__ == '__main__':
    app.run()
