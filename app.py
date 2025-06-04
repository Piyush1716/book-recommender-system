from flask import Flask, render_template, request
import pickle
import numpy as np
app = Flask(__name__)

popular_df =        pickle.load(open('models/popular.pkl','rb'))
books_df =          pickle.load(open('models/books.pkl','rb'))
pt =                pickle.load(open('models/pivot.pkl','rb'))
similarity_score =  pickle.load(open('models/similarity.pkl','rb'))

books = []
books_names = list(popular_df['Book-Title'].values)
for i in range(len(popular_df)):
    book_dict = {
        'title': popular_df['Book-Title'].values[i],
        'author': popular_df['Book-Author'].values[i],
        'image': popular_df['Image-URL-L'].values[i],
        'rating': round(popular_df['Avg-Rating'].values[i],3),
        'total_ratings': popular_df['num_ratings'].values[i]
    }
    
    books.append(book_dict)

@app.route('/')
def index():
    return render_template('index.html',books=books)

@app.route('/recommend', methods=['GET','POST'])
def recommend():
    if request.method == 'GET':
        return render_template('recommend.html',books=books_names)
    else:
        name = request.form.get('book_name')
        data = recomend(name)
        return render_template('recommend.html', recommendations=data,books=books_names, searched = name)
        

def recomend(name):
    # index fetch
    if name not in pt.index:
        return [["Book not found", "Unknown", "https://images.amazon.com/images/P/0316666343.01.LZZZZZZZ.jpg"]]

    index = np.where(pt.index==name)[0][0]
    similar_books = sorted(list(enumerate(similarity_score[index])), key= lambda x:x[1],reverse=True)[1:6]
    data = []
    for i in similar_books:
        temp = books_df[books_df['Book-Title'] == pt.index[i[0]]].iloc[0] # to avoid duplicate book names
        data.append([
            temp['Book-Title'],
            temp['Book-Author'],
            temp['Image-URL-L'],
        ])
    return data

if __name__ == '__main__':
    app.run(debug=True)