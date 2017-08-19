 $(function() {
            // Initialize form validation on the registration form.
            // It has the name attribute "registration"
    //         $.validator.addMethod("valueNotEquals", function(value, element, arg){
             //  return arg != value;
             // }, "Value must not equal arg.");

            $.validator.methods.email = function( value, element ) {
              return this.optional( element ) || /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test( value );
            }

            $.validator.methods.pincode = function( value, element ) {
              return this.optional( element ) || /^\d{6}$/.test( value );
            }

            jQuery.validator.addMethod("lettersonly", function(value, element) 
            {
            return this.optional(element) || /^[a-z," "]+$/i.test(value);
            }, "Letters and spaces only please"); 

            $("form[name='vender_demographic_form']").validate({
                // Specify validation rules
                rules: {
                    // The key name on the left side is the name attribute
                    // of an input field. Validation rules are defined
                    // on the right side
                    selectservice: {
                        required: true
                    },
                    servicename: {
                        required: true
                    },
                    phone: {
                        required: true,
                        minlength: 10,
                        number: true
                    },
                    description: {
                        required: true
                    },
                    address1: {
                        required: true
                    },
                    address2: {
                        required: true
                    },
                    city: {
                        required: true,
                        lettersonly: true
                    },
                    country: {
                        required: true,
                        lettersonly: true
                    },
                    state: {
                        required: true
                    },
                    pincode: {
                        required: true,
                        pincode: true
                    },
                    url: {
                        required: true,
                        url: true
                    },
                    email: {
                        required: true,
                        email: true
                    }
                },
                // Specify validation error messages
                messages: {
                    selectservice: "Please select an item!",
                    name: "Please enter your name",
                    address1: "Please enter your address1",
                    city: "Please enter your city",
                    country: "Please enter your country name in letters",
                    state: "Please enter your state",
                    pincode: "Please enter your valid pincode",
                    phone: "Please enter 10 digit number",
                    url: {
                      required: "We need your Website",
                      email: "Your website must be in the format of www.yourname.domainname"
                    },
                    email: {
                      required: "We need your email address to contact you",
                      email: "Your email address must be in the format of name@domain.com"
                    }
                },
                // Make sure the form is submitted to the destination defined
                // in the "action" attribute of the form when valid
                submitHandler: function(form, event) {
                    event.preventDefault();
                    console.log($(form).serialize());
                }
            });



            // contact form
                $("form[name='contactusform']").validate({
                    // Specify validation rules
                    rules: {
                        // The key name on the left side is the name attribute
                        // of an input field. Validation rules are defined
                        // on the right side
                        name: "required",
                        message: "required",
                        email: {
                            required: true,
                            email: true
                        },
                        phone: {
                            required: true,
                            minlength: 10,
                            number: true
                        }
                    },
                    // Specify validation error messages
                    messages: {
                        name: "Please enter your name",
                        message: "Please enter your message",
                        phone: "Please enter 10 digit number",
                        email: "Please enter a valid email address"
                    },
                    // Make sure the form is submitted to the destination defined
                    // in the "action" attribute of the form when valid
                    submitHandler: function(form, event) {
                    	form.submit();
                    }
                });
             // enquiry form
                $("form[name='enquiryform']").validate({
                    // Specify validation rules
                    rules: {
                        // The key name on the left side is the name attribute
                        // of an input field. Validation rules are defined
                        // on the right side
                        name: "required",
                        message: "required",
                        enquiry_date:"required",
                        email: {
                            required: true,
                            email: true
                        },
                        phone: {
                            required: true,
                            minlength: 10,
                            number: true
                        }
                    },
                    // Specify validation error messages
                    messages: {
                        name: "Please enter your name",
                        message: "Please enter your event details",
                        phone: "Please enter 10 digit number",
                        email: "Please enter a valid email address",
                        enquiry_date:"Please enter event date"
                    }/*,
                    // Make sure the form is submitted to the destination defined
                    // in the "action" attribute of the form when valid
                    submitHandler: function(form, event) {
                    	form.submit();
                    }*/
                });
        });