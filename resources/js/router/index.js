import {createWebHistory, createRouter} from "vue-router";

import Home from '../pages/Home';
import Register from '../pages/Register';
import Login from '../pages/Login';
import Dashboard from '../pages/Dashboard';

import Quotes from '../components/quotes/Quotes';
import AddQuote from '../components/quotes/AddQuote';
import EditQuote from '../components/quotes/EditQuote';
import Products from '../components/products/Products';
import AddProduct from '../components/products/AddProduct';
import EditProduct from '../components/products/EditProduct';

export const routes = [
    {
        name: 'home',
        path: '/',
        component: Home
    },
    {
        name: 'register',
        path: '/register',
        component: Register
    },
    {
        name: 'login',
        path: '/login',
        component: Login
    },
    {
        name: 'dashboard',
        path: '/dashboard',
        component: Dashboard
    },
    {
        name: 'quotes',
        path: '/quotes',
        component: Quotes
    },
    {
        name: 'addquote',
        path: '/quotes/add',
        component: AddQuote
    },
    {
        name: 'editquote',
        path: '/quotes/edit/:id',
        component: EditQuote
    },
    {
        name: 'products',
        path: '/products',
        component: Products
    },
    {
        name: 'searchproducts',
        path: '/products/livesearch',
        component: Products
    },
    {
        name: 'addproduct',
        path: '/products/add',
        component: AddProduct
    },
    {
        name: 'editproduct',
        path: '/products/edit/:id',
        component: EditProduct
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes: routes,
});

export default router;
