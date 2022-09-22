const mysql = require('mysql');

module.exports = app => {
    const controller = {};
    const connection = mysql.createConnection({
        host: 'mysql',
        user: 'root',
        password: 'RootPassword',
        database: 'Company'
    });
    connection.connect();

    // GET ALL
    controller.listProducts = (req, res) => {
        
        connection.query('SELECT * FROM products', function (error, results) {
            if (error) { 
                throw error
            };
            res.status(200).json(results.map(item => ({ name: item.name, price: item.price })));
        })
    }
    
    // POST
    controller.saveProduct = (req, res) => {
        const newProduct = {
            name: req.body.name, 
            price: req.body.price
        }
        connection.query(
            'INSERT INTO products SET ?', newProduct, function (error, results) {
            if (error) throw error
        
            res.status(201).json(newProduct);
        
        })
    }


    return controller;
}