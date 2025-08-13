
from typing import List
from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Or specify your frontend origin
    allow_credentials=True,
    allow_methods=["*"],  # Or ["GET", "POST", "PUT", "DELETE"]
    allow_headers=["*"],
)

class ProductIn(BaseModel):
    Name: str
    ProductCode:str 
    ProductQuantity: str
    ProductPrice: str
    ProductSize: str
class Product(BaseModel):
    id: int
    Name: str
    ProductCode:str 
    ProductQuantity: str
    ProductPrice: str
    ProductSize: str

products: List[Product] = [
    Product(id=1, Name="Tshirt", ProductCode="P101", ProductQuantity="45", ProductPrice="500", ProductSize="XL"),
    Product(id=2, Name="Pant", ProductCode="P101", ProductQuantity="45", ProductPrice="500", ProductSize="XL"),
    Product(id=3, Name="Shirt", ProductCode="P101", ProductQuantity="45", ProductPrice="500", ProductSize="XL"),
    Product(id=4, Name="Panjabi", ProductCode="P101", ProductQuantity="45", ProductPrice="500", ProductSize="XL"),
]


@app.get("/")
def read_root():
    return {"Messege" : "Welcome to the cloths management service"}

@app.get("/api/allproducts")
def all_products():
    return {"All Products" : products}

@app.post("/api/products")
def create_product( product_data: ProductIn):
    if len(products)> 0:
        new_id = products[len(products) - 1].id + 1
    else: 
        new_id = 1
    new_product = Product(id= str(new_id), **product_data.dict())
    products.append(new_product)

    return {"status" : "success", "product" : new_product}

@app.delete("/api/delete/{product_id}")
def delete_product(product_id: int):
    print(product_id)
    for index, product in enumerate(products):
        if product.id == product_id:
            deleted_product = products.pop(index)  # 👈 returns the deleted Product object
            return {"message": "Product deleted successfully", "deleted": deleted_product}
    
    return{"messege": "Something went wrong! try Again"}

@app.post("/api/update/{product_id}")
def update_product(product_id: int, product_data: ProductIn):
    print(id)
    for index, product in enumerate(products):
        if product.id == product_id:
            updated_product = Product(id=product_id, **product_data.dict())
            products[index] = updated_product
            return {
                "message": "Product updated successfully",
                "product": updated_product
            }
    return {"message": "Product not found"}
    