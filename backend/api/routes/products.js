module.exports = app => {
    const controller = app.controllers.products;


    app.route('/api/v1/products')
      .get(controller.listProducts)
      .post(controller.saveProduct);
}