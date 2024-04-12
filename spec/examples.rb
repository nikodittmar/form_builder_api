VALID_COMPONENTS = [
    {
      "id": "089302ae-3cba-4ae0-a533-9a405dbb7013",
      "name": "Full Name",
      "required": true,
      "helper": "Please enter your name as it appears on your government issued driver's license or id.",
      "placeholder": "eg. John Doe",
      "type": "text-field"
    },
    {
      "id": "9f1fe3b3-9000-4f87-9ab3-ec79bba5391d",
      "name": "Email",
      "required": true,
      "helper": "",
      "placeholder": "eg. example@domain.com",
      "type": "email-address"
    },
    {
      "id": "b4742588-105d-48af-8cd3-8e29b0387118",
      "name": "Phone Number",
      "required": false,
      "helper": "Message and data rates may apply.",
      "placeholder": "",
      "type": "phone-number"
    },
    {
      "id": "a1b97ffe-a031-4da1-9d67-a59ea80883e9",
      "name": "How many items do you want?",
      "required": true,
      "helper": "",
      "placeholder": "1-10",
      "type": "number-picker"
    },
    {
      "id": "560e655f-8f10-4b6a-a38c-eef476b1c66f",
      "name": "Category",
      "required": true,
      "helper": "Use the age you will be at December 31 of this year.",
      "choices": [
        {
          "id": "bf05fbe4-56b2-4437-96f6-debbb1a7ef82",
          "name": "Youth (18 and under)"
        },
        {
          "id": "c0118b20-131f-4b94-be6b-be10f48d5246",
          "name": "Adult "
        },
        {
          "id": "1a85e154-4e66-4b14-9c39-6dd972d333fe",
          "name": "Senior (65 and over)"
        }
      ],
      "type": "radio-buttons"
    },
    {
      "id": "10e13e8a-95c2-4f40-8085-31ed11ad884b",
      "name": "Items to Purchase",
      "required": true,
      "helper": "",
      "choices": [
        {
          "id": "2608a13e-9b2b-4057-9c21-90ed5650d398",
          "name": "T-Shirt"
        },
        {
          "id": "e0202910-1457-44b0-b4a8-793f366a419a",
          "name": "Pants"
        },
        {
          "id": "cfd565cf-4168-4cbd-a9ba-ececd4bfa639",
          "name": "Jacket"
        }
      ],
      "type": "checkboxes"
    },
    {
      "id": "2f255217-d486-4e70-aebd-02b335c8a20f",
      "name": "Questions of Comments?",
      "required": false,
      "helper": "We will do our best to respond to you within 48 hours",
      "placeholder": "",
      "type": "text-area"
    }
 ]

VALID_COMPONENTS_ALTERNATE = [
    {
      "id": "089302ae-3cba-4ae0-a533-9a405dbb7013",
      "name": "Text Field",
      "required": true,
      "helper": "This is a Helper",
      "placeholder": "This is a Placeholder",
      "type": "text-field"
    },
    {
      "id": "2f255217-d486-4e70-aebd-02b335c8a20f",
      "name": "Text Area",
      "required": false,
      "helper": "This is a Helper",
      "placeholder": "This is a Placeholder",
      "type": "text-area"
    },
    {
      "id": "9f1fe3b3-9000-4f87-9ab3-ec79bba5391d",
      "name": "Email Address",
      "required": true,
      "helper": "This is a Helper",
      "placeholder": "This is a Placeholder",
      "type": "email-address"
    },
    {
      "id": "b4742588-105d-48af-8cd3-8e29b0387118",
      "name": "Phone Number",
      "required": false,
      "helper": "This is a Helper",
      "placeholder": "This is a Placeholder",
      "type": "phone-number"
    },
    {
      "id": "a1b97ffe-a031-4da1-9d67-a59ea80883e9",
      "name": "Number Picker",
      "required": true,
      "helper": "This is a Helper",
      "placeholder": "This is a Placeholder",
      "type": "number-picker"
    },
    {
      "id": "10e13e8a-95c2-4f40-8085-31ed11ad884b",
      "name": "Checkboxes",
      "required": false,
      "helper": "This is a Helper",
      "choices": [
        {
          "id": "2608a13e-9b2b-4057-9c21-90ed5650d398",
          "name": "Option A"
        },
        {
          "id": "e0202910-1457-44b0-b4a8-793f366a419a",
          "name": "Option B"
        },
        {
          "id": "cfd565cf-4168-4cbd-a9ba-ececd4bfa639",
          "name": "Option C"
        }
      ],
      "type": "checkboxes"
    },
    {
      "id": "560e655f-8f10-4b6a-a38c-eef476b1c66f",
      "name": "Radio Buttons",
      "required": true,
      "helper": "This is a Helper",
      "choices": [
        {
          "id": "bf05fbe4-56b2-4437-96f6-debbb1a7ef82",
          "name": "Option A"
        },
        {
          "id": "c0118b20-131f-4b94-be6b-be10f48d5246",
          "name": "Option B"
        },
        {
          "id": "1a85e154-4e66-4b14-9c39-6dd972d333fe",
          "name": "Option C"
        }
      ],
      "type": "radio-buttons"
    }
]

INVALID_COMPONENTS = [
    {
        "name": "Full Name",
        "required": true,
        "helper": "Please enter your name as it appears on your government issued driver's license or id.",
        "placeholder": "eg. John Doe",
        "type": "text-field"
    },
    {
        "id": "9f1fe3b3-9000-4f87-9ab3-ec79bba5391d",
        "name": "Email",
        "helper": "",
        "placeholder": "eg. example@domain.com",
        "type": "email-address"
    },
    {
        "id": "b4742588-105d-48af-8cd3-8e29b0387118",
        "name": "Phone Number",
        "required": false,
        "placeholder": "",
        "type": "phone-number"
    },
    {
        "id": "a1b97ffe-a031-4da1-9d67-a59ea80883e9",
        "required": true,
        "helper": "",
        "placeholder": "1-10",
        "type": "number-picker"
    },
    {
        "id": false,
        "name": 55,
        "required": true,
        "helper": "Use the age you will be at December 31 of this year.",
        "choices": [ 
            {
                "name": "s"
            },
            {
                "id": "1a85e154-4e66-4b14-9c39-6dd972d333fe"
            },
            {
                "id": "1a85e154-4e66-4b14-9c39-6dd972d333fe",
                "name": "Senior (65 and over)",
                "not a parameter": 20
            }
        ],
        "type": "radio-buttons"
    },
    {
        "id": "10e13e8a-95c2-4f40-8085-31ed11ad884b",
        "name": "Items to Purchase",
        "required": true,
        "helper": "",
        "choices": [
        {
            "id": 33,
            "name": "T-Shirt"
        },
        {
            "id": "e0202910-1457-44b0-b4a8-793f366a419a",
            "name": "Pants"
        },
        {
            "id": "cfd565cf-4168-4cbd-a9ba-ececd4bfa639",
            "name": "Jacket"
        }
        ],
        "type": "not a type"
    },
    {
        "id": "2f255217-d486-4e70-aebd-02b335c8a20f",
        "name": "Questions of Comments?",
        "required": false,
        "helper": "We will do our best to respond to you within 48 hours",
        "placeholder": false,
        "type": "text-area"
    }
]