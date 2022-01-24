Vue.component('edit-quote-billing', {
    <template>
        <div>
            <h4>Billing</h4>
            <h5>Sub Total</h5>
            <h5>£{{ subTotal }}</h5>
            <h5>VAT</h5>
            <h5>£{{ vat }}</h5>
            <h5>Total</h5>
            <h5>£{{ total }}</h5>
        </div>
    </template>

    <script>
    export default {
        props: {
            quote: {
                type:Object,
            }
        },
        watch: {
            quote: {
                deep: true,
            }
        },
        computed: {
            subTotal: function () {
                const resultArray = this.objToArray(this.quote.products);
                return resultArray.reduce(function (a, c) {
                    // products.price * products.pivot.quantity
                    return a + Number((c[3] * c[4][3]) || 0)
                }, 0).toFixed(2);
            },
            vat: function () {
                return Number(this.subTotal * 0.2).toFixed(2);
            },
            total: function () {
                return (Number(this.subTotal) + Number(this.vat)).toFixed(2);
            }
        },
        methods: {
            objToArray(obj) {
                const result = [];
                for (const prop in obj) {
                    const value = obj[prop];
                    // If nested object, recurse
                    if (typeof value === 'object') {
                        result.push(this.objToArray(value));
                    } else {
                        result.push(value);
                    }
                }
                return result
            },
        }
    }
    </script>
})
